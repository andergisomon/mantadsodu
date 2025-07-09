import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagView extends StatelessWidget {
  const TagView({Key? key}) : super(key: key);

  // Data structure to feed UI builder
  final List<Map<String, dynamic>> tagData = const [
    {
      'created_at': '2025-06-19 08:47:50.462048+00',
      'temperature': 23.58846206665,
      'humidity': 52.1568908691406,
      'area_1_lights': 0,
      'area_2_lights': 0,
      'status': 0,
      'area_1_lights_hmi_cmd': 0,
    },
    {
      'created_at': '2025-06-19 06:23:44.783316+00',
      'temperature': 23.6133995056152,
      'humidity': 52.4412078857422,
      'area_1_lights': 1,
      'area_2_lights': 0,
      'status': 0,
      'area_1_lights_hmi_cmd': 1,
    },
        {
      'created_at': '2025-06-19 06:23:44.783316+00',
      'temperature': 23.6133995056152,
      'humidity': 52.4412078857422,
      'area_1_lights': 1,
      'area_2_lights': 0,
      'status': 0,
      'area_1_lights_hmi_cmd': 1,
    },
        {
      'created_at': '2025-06-19 08:47:50.462048+00',
      'temperature': 23.58846206665,
      'humidity': 52.1568908691406,
      'area_1_lights': 0,
      'area_2_lights': 0,
      'status': 0,
      'area_1_lights_hmi_cmd': 0,
    },
    // You can add more entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Tag view',
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tagData.length,
                  itemBuilder: (context, index) {
                    final data = tagData[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.35),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: Offset(
                                0,
                                2,
                              ),
                          ),
                        ],
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${entry.key}\n',
                                      style:
                                        GoogleFonts.workSans(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        )
                                      )
                                    ),
                                    TextSpan(
                                      text: '${entry.value}',
                                      style:
                                        GoogleFonts.workSans(
                                          textStyle:  TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
