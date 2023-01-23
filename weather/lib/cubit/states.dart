abstract class WeatherState {}

class StartState extends WeatherState {}

class LoadingState extends WeatherState {}

class SuccessState extends WeatherState {}

class FailureState extends WeatherState {}
