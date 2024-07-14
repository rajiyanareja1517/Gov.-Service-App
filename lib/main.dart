import 'package:flutter/material.dart';
import 'package:government_service/provider/change_provider.dart';
import 'package:government_service/view/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ChangeProvider();
      },
      builder: (context,_) {
        return MaterialApp(
          title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
            "/":(context)=>HomePage(),
        },
        );
      }
    );
  }
}

