import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubit/cubit.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityname;

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search A City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            onChanged: (data) {
              cityname = data;
            },
            onSubmitted: (data) async {
              cityname = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getweather(cityname: cityname!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityname;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30,
              ),
              label: const Text('Search'),
              border: const OutlineInputBorder(),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    BlocProvider.of<WeatherCubit>(context)
                        .getweather(cityname: cityname!);
                    BlocProvider.of<WeatherCubit>(context).cityName = cityname;
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
              hintText: 'Enter City Name',
            ),
          ),
        ),
      ),
    );
  }
}
