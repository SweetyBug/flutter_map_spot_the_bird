import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_the_bird/bloc/map_cubit.dart';
import 'package:spot_the_bird/pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.1
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // App Bar Color
          primaryColor: Color(0xFF863A6F),
          colorScheme: ColorScheme.light().copyWith(
            // TextField Color
            primary: Color(0xFFFCE2DB),
            //Floating Action button
            secondary: Color(0xFF6D9886),
          ),
        ),
        home: MapPage(),
      ),
    );
  }
}
