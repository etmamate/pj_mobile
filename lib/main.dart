import 'package:flutter/material.dart';
import 'package:pj_mobile/pages/telalogin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://bfhyzveodjyeqfusbyio.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmaHl6dmVvZGp5ZXFmdXNieWlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4MDc2MjcsImV4cCI6MjA2NjM4MzYyN30.uZV8OnzvC-MTjVi9IkSBwg-sr_N8ZC1QSlCmzhdWa6I",
  );

  runApp(Telalogin());
}
