import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
    const Dashboard({super.key});

    @override
    DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

    final _future = Supabase.instance.client
                    .from('plc_tags')
                    .select().order('id', ascending: false);

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
            }

            final plc_tags = snapshot.data!;
            final length = plc_tags.length;

            return ListView.builder(
                itemCount: 20,
                itemBuilder: (
                    (context, index) {
                        final plc_tag = plc_tags[index];

                        return ListTile(
                            title: Text(plc_tag['humidity'].toString()),
                            subtitle: Text(plc_tag['created_at']),
                        );
                    }
                ),
            );
        }
        ),
    );
  }
}