import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubit/cubit.dart';
import 'package:weather/screens/home_page.dart';
import 'package:weather/service.dart';

void main() {
  runApp(BlocProvider(
      create: (context) {
        return WeatherCubit(Service());
      },
      child: Weather()));
}

class Weather extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: BlocProvider.of<WeatherCubit>(context).weathermodel == null
              ? Colors.blue
              : BlocProvider.of<WeatherCubit>(context)
                  .weathermodel!
                  .ThemeColor(),
        ),
        primarySwatch: BlocProvider.of<WeatherCubit>(context).weathermodel ==
                null
            ? Colors.blue
            : BlocProvider.of<WeatherCubit>(context).weathermodel!.ThemeColor(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
