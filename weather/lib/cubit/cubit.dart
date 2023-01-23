import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubit/states.dart';
import 'package:weather/service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherservice) : super(StartState());
  Service weatherservice;
  String? cityName;
  Weatherofday? weathermodel;

  void getweather({required String cityname}) async {
    emit(LoadingState());
    weathermodel = await weatherservice.getweather(cityname: cityname);
    if (weathermodel != null) {
      emit(SuccessState());
    } else {
      emit(FailureState());
    }
  }
}
