import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubit/cubit.dart';
import 'package:weather/cubit/states.dart';
import 'package:weather/screens/search_page.dart';
import 'package:weather/service.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  Weatherofday? weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            weather = BlocProvider.of<WeatherCubit>(context).weathermodel;
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weather!.ThemeColor(),
                  weather!.ThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    BlocProvider.of<WeatherCubit>(context).cityName!,
                    style: const TextStyle(fontSize: 36),
                  ),
                  Text(
                    'Updated at : ${weather!.date}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weather!.ImagePath()),
                      Text(
                        '${weather!.temp.toInt()}',
                        style: const TextStyle(fontSize: 36),
                      ),
                      Column(
                        children: [
                          Text(
                            'maxtemp: ${weather!.maxtemp.toInt()}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'mintemp: ${weather!.mintemp.toInt()}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    weather!.weatherstate,
                    style: const TextStyle(fontSize: 36),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                ],
              ),
            );
          } else if (state is FailureState) {
            return const Center(
              child: Text(
                'Something Wrong',
                style: TextStyle(),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'There is no weather 😔 start searching now 🔍',
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
