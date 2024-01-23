import 'package:flutter/material.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/ui/post_page.dart';

import 'features/home/home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostPage(),
    );
  }
}
