import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEA3A3A), Color(0xFFD32F2F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Warning Icon
                Image.asset(
                  'assets/panawai.png', // replace with your actual path
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 30),
                // "Disclaimer" Heading
                Text(
                  'Disclaimer',
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Warning Description
                Text(
                  'Changing tag values that the PLC\n'
                  'program behavior depends on may\n'
                  'result in undesired behavior.\n\n'
                  'Be aware that in using this feature,\n'
                  'you may damage property and/or endanger\n'
                  'the safety and life of personnel.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                // "I understand" Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: handle confirmation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD740), // yellow
                    shadowColor: Colors.black,
                    elevation: 8,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 36,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'I understand',
                    style: GoogleFonts.workSans(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
