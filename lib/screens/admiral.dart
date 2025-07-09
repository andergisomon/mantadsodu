import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdmiralScreen extends StatefulWidget {
  const AdmiralScreen({Key? key}) : super(key: key);

  @override
  State<AdmiralScreen> createState() => _AdmiralScreenState();
}

class _AdmiralScreenState extends State<AdmiralScreen> {
  bool area1LightsOn = false;
  String ragLightsStatus = 'OFF';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admiral',
          style: GoogleFonts.workSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[600],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Area 1 Lights Control
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toggle Buttons
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    area1LightsOn = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: area1LightsOn ? const Color.fromARGB(255, 54, 166, 60) : Colors.grey[600],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'ON',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    area1LightsOn = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: !area1LightsOn ? Colors.black : Colors.grey[600],
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'OFF',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Label
                        Text(
                          'area_1_lights',
                          style: GoogleFonts.workSans(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Feedback Section
                  // Honestly cba to pipe the bits from the PLC to the OPC UA server and through the sunsuyon gateway again
                  // so this will be commented out

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Feedback',
                  //       style: GoogleFonts.workSans(
                  //         color: Colors.grey[700],
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 8),
                  //     Text(
                  //       'ON',
                  //       style: GoogleFonts.workSans(
                  //         color: Colors.black,
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // RAG Lights Control
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Color Buttons
                ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 90,
                        maxWidth: 90
                      ),
                      child:
                        Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ragLightsStatus = 'RED';
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: ragLightsStatus == 'RED' ? Colors.red[600] : Colors.grey[600],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'RED',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ragLightsStatus = 'AMBER';
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: ragLightsStatus == 'AMBER' ? Colors.amber[600] : Colors.grey[600],
                                  ),
                                  child: Text(
                                    'AMBER',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ragLightsStatus = 'GREEN';
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: ragLightsStatus == 'GREEN' ? Colors.green[600] : Colors.grey[600],
                                  ),
                                  child: Text(
                                    'GREEN',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ragLightsStatus = 'OFF';
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: ragLightsStatus == 'OFF' ? Colors.black : Colors.grey[600],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'OFF',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Label
                        Text(
                          'rag_lights',
                          style: GoogleFonts.workSans(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Tower Light Image
                  Container(
                    width: 150,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/naau_ragangsiloutomou.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),


                  // Feedback Section
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Feedback',
                  //       style: GoogleFonts.workSans(
                  //         color: Colors.grey[700],
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 8),
                  //     Text(
                  //       ragLightsStatus,
                  //       style: GoogleFonts.workSans(
                  //         color: ragLightsStatus == 'RED' 
                  //           ? Colors.red[600] 
                  //           : ragLightsStatus == 'AMBER' 
                  //           ? const Color.fromARGB(255, 222, 144, 9) 
                  //           : Colors.green[600],
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 32,),

            // Note Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                    style: GoogleFonts.workSans(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ensure permissives and interlocks',
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   'If feedback values do not update as expected, remote commands might be overridden.',
                  //   style: GoogleFonts.workSans(
                  //     color: Colors.grey[700],
                  //     fontSize: 14,
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  Text(
                    'PLC requires remote command accept permissive in order for remote commands to take effect, among other additional permissives and interlocks. Please consult field personnel.',
                    style: GoogleFonts.workSans(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}