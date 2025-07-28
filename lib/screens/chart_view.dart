import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantadsodu/services/sb_service.dart';

class ChartDataProcessor {
  static List<LineChartBarData> processTagData(List<Map<String, dynamic>> tagData) {

    tagData.sort((a, b) {
      DateTime dateTimeA = DateTime.parse(a['created_at']);
      DateTime dateTimeB = DateTime.parse(b['created_at']);
      return dateTimeA.millisecondsSinceEpoch.compareTo(dateTimeB.millisecondsSinceEpoch);
    });

    List<FlSpot> temperatureSpots = [];
    List<FlSpot> humiditySpots = [];

    double minX = double.infinity;
    double maxX = double.negativeInfinity;

    for (var data in tagData) {
      try {
        final String createdAtString = data['created_at'];
        final double? temperature = data['temperature']?.toDouble();
        final double? humidity = data['humidity']?.toDouble();
        final DateTime dateTime = DateTime.parse(createdAtString);
        final double xValue = dateTime.millisecondsSinceEpoch.toDouble();

        if (xValue < minX) minX = xValue;
        if (xValue > maxX) maxX = xValue;

        if (temperature != null) {
          temperatureSpots.add(FlSpot(xValue, temperature));
        }
        if (humidity != null) {
          humiditySpots.add(FlSpot(xValue, humidity));
        }
      } catch (e) {
        continue;
      }
    }

    return [
        LineChartBarData(
        spots: humiditySpots,
        isCurved: true,
        gradient: LinearGradient(colors: [Color(0xFF7CC041), Color(0xFF8FDA52)]),
        // color: Colors.blue,
        barWidth: 10.0,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors:
                                    [
                                      Color(0xFF7CC041).withValues(alpha: 0.4),
                                      Color(0xFF8FDA52).withValues(alpha: 0.15)
                                    ]
                                )
                        ),
        ),
      LineChartBarData(
        spots: temperatureSpots,
        isCurved: true,
        gradient: LinearGradient(colors: [Color(0xFF9B4DCC), Color(0xFFD17DD4)]),
        barWidth: 10.0,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: 
                                    [Color(0xFF9B4DCC).withValues(alpha: 0.4),
                                    Color(0xFFD17DD4).withValues(alpha: 0.15)
                                    ]
                                )
                      ),
      ),
    ];
  }
}

class ChartView extends StatefulWidget {
  const ChartView({Key? key}) : super(key: key);
  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<Map<String, dynamic>> tagData = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedTags = await fetchPlcTags();
      setState(() {
        tagData = fetchedTags;
      });
    }
    catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<LineChartBarData> chartBars = ChartDataProcessor.processTagData(tagData);

    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var barData in chartBars) {
      for (var spot in barData.spots) {
        if (spot.x < minX) minX = spot.x;
        if (spot.x > maxX) maxX = spot.x;
        if (spot.y < minY) minY = spot.y;
        if (spot.y > maxY) maxY = spot.y;
      }
    }

    final double yAxisPadding = (maxY - minY) * 0.2;
    minY -= yAxisPadding;
    maxY += yAxisPadding;

  if (!_isLoading) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chart view',
          style: GoogleFonts.workSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 173, 237, 121),

      ),
      backgroundColor: Colors.grey[100],

      body: ListView(
        children: [
              Column(
                  children: [
                    SizedBox(height: 12),
                    Chip(
                      shape: StadiumBorder(),
                      label: Text('Temperature (°C)',
                      style:
                        GoogleFonts.workSans(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        )
                      ),
                      backgroundColor: Color(0xFF9B4DCC),
                    ),
                    Chip(
                      shape: StadiumBorder(),
                      label: Text('Humidity (%RH)',
                      style:
                        GoogleFonts.workSans(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        )
                      ),
                      backgroundColor: Color(0xFF7CC041),
                    ),
                  ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Container(
                  width: 1500,
                  height: 450,
                  padding: EdgeInsets.only(bottom: 32.0, top: 32.0, left: 64.0, right: 128.0),
                    child: 
                        LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                maxContentWidth: 256,
                                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                      return touchedBarSpots.map((LineBarSpot touchedSpot) {
                                      final textStyle = GoogleFonts.workSans(
                                        fontSize: 14,
                                        color: touchedSpot.bar.gradient?.colors.first ??
                                            touchedSpot.bar.color ??
                                            Colors.blueGrey,
                                        fontWeight: FontWeight.w500
                                      );
                                      return LineTooltipItem(touchedSpot.y.toString(), textStyle);
                                    }).toList();
                                },
                                tooltipBorderRadius: BorderRadius.circular(12),
                                getTooltipColor: (LineBarSpot barSpot) => Colors.grey[100]!,
                              )
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: const FlGridData(show: true),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                        final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                        return SideTitleWidget(
                                            space: 16.0,
                                            angle: -32/180,
                                            meta: meta,
                                            child: Text(
                                              dateTime.toIso8601String(),
                                              style: GoogleFonts.workSans(
                                                  color: Colors.blueGrey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                  },
                                  reservedSize: 40,
                                  interval: 50000,
                                  // interval: (maxX - minX) / 3,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                          value.toStringAsFixed(2),
                                          style: GoogleFonts.workSans(
                                                color: Colors.blueGrey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                    );
                                  },
                                  reservedSize: 50,
                                  interval: (maxY - minY) / 8,
                                )
                              )
                            ),
                            minX: minX,
                            maxX: maxX,
                            minY: minY,
                            maxY: maxY,
                            lineBarsData: chartBars                            
                          )
                      )
                ),
              ),
              Container(
                child: 
                  Column(
                    children: [
                      SizedBox(height: 22),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Container(
                            child: 
                              Transform.rotate(angle: pi/2, child: Icon(Icons.expand)),
                          ),
                          SizedBox(width: 28),
                          Container(
                            width: 300,
                            child: 
                              Text(
                                'Scroll sideways to view entire\nlength of graph.',
                                  style: GoogleFonts.workSans(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                )
                              ),
                          )
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Container(
                            child: 
                              Icon(Icons.touch_app),
                          ),
                          SizedBox(width: 28),
                          Container(
                            width: 300,
                            child: 
                              Text(
                                'You can also tap, hold, and swipe across the chart to view tag values\nat that instant.',
                                  style: GoogleFonts.workSans(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                )
                              ),
                          )
                        ],
                      )
                    ],
                  ),
              )  
            ],
      )
    );
  }
  else {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'Chart view',
          style: GoogleFonts.workSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 173, 237, 121),
      ),
      body: SafeArea(child: 
                Center(
                child: Text(
                'Loading...',
                style: GoogleFonts.workSans(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
        ),
      );
    }
  }
}