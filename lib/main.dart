import 'package:flutter/material.dart';
import 'package:mantadsodu/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
    await dotenv.load(fileName: ".env");
    final String url = dotenv.env['SUPABASE_URL']!;
    final String key = dotenv.env['SUPABASE_KEY']!;
    final String writerEmail = dotenv.env['WRITER_EMAIL']!;
    final String writerPwd = dotenv.env['WRITER_PWD']!;

    await Supabase.initialize(
      url: url,
      anonKey: key,
      debug: true,
      authOptions: FlutterAuthClientOptions(
        detectSessionInUri: false,
      )
    );

    final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
      email: writerEmail,
      password: writerPwd,
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