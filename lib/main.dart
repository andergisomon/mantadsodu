import 'package:flutter/material.dart';
import 'package:mantadsodu/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'screens/dashboard.dart';

Future main() async {
    await dotenv.load(fileName: ".env");
    final String url = dotenv.env['SUPABASE_URL']!;
    final String key = dotenv.env['SUPABASE_KEY']!;
    final String writer_email = dotenv.env['WRITER_EMAIL']!;
    final String writer_pwd = dotenv.env['WRITER_PWD']!;

    await Supabase.initialize(url: url, anonKey: key, debug: true);


    final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
      email: writer_email,
      password: writer_pwd,
    );
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Mantadsodu',
        home: HomeScreen(),
    );
    }
}