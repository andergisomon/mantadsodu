import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient _sbClient = Supabase.instance.client;

Future<List<Map<String, dynamic>>> fetchPlcTags() async {
  try {
    final res = await _sbClient
                  .from("plc_tags")
                  .select("*")
                  .order("id", ascending: false);
    return res;
  }
  catch (e) {
    throw Exception("caught exception $e \nfailed to fetch tags from plc_tags table");
  }
}