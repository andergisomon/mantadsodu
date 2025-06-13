import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/dashboard.dart';

Future main() async {
    await dotenv.load(fileName: ".env");
    final String url = dotenv.env['SUPABASE_URL']!;
    final String key = dotenv.env['SUPABASE_KEY']!;
    await Supabase.initialize(url: url, anonKey: key, debug: true);

    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Mantadsodu',
        home: Dashboard(),
    );
    }
}