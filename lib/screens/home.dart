import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mantadsodu/screens/disclaimer.dart';
import 'package:mantadsodu/screens/tag_view.dart';
import 'package:mantadsodu/screens/chart_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildGradientButton({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: 600,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.workSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: GoogleFonts.workSans(
              textStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Home',
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const TagView()),
                    );
                  },
                  child:
                    _buildGradientButton(
                    title: 'View tags',
                    subtitle: 'Fetch from the database the latest tag records reported by the PLC.',
                    gradientColors: [Color(0xFF9B4DCC), Color(0xFFD17DD4)],
                  )
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ChartView()),
                    );
                  },
                  child:
                    _buildGradientButton(
                      title: 'Chart view',
                      subtitle: 'Visualize tag values over time.',
                      gradientColors: [Color(0xFF7CC041), Color(0xFF8FDA52)],
                    )
                ),
                GestureDetector(      
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DisclaimerScreen()),
                    );
                  },
                  child:
                    _buildGradientButton(
                      title: 'Admiral',
                      subtitle: 'Remotely send commands to the PLC.',
                      gradientColors: [Color(0xFF3A7DAB), Color(0xFF5DC4D6)],
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
