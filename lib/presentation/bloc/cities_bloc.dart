import 'package:bloc/bloc.dart';
import 'package:clean_bloc/data/datasource/apis/get_weather_details.dart';
import 'package:clean_bloc/data/repositories/city_repository.dart';
import 'package:clean_bloc/presentation/bloc/cities_event.dart';
import 'package:clean_bloc/presentation/bloc/cities_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/cities.dart';


class CityBloc extends Bloc<CitiesEvent, CitiesState> {
  late CitiesRepository _citiesRepository;

  late List<City>? cities = [];

  CityBloc() : super(InitialCitiesState()) {
    _citiesRepository = CitiesRepository();
    _citiesRepository.configureDataListener();

    on<LoadingCitiesEvent>((event, emit) => emit(LoadingCitiesState(getTimeStamp())));

    on<GetAllCitiesEvent>((event, emit) => emit(CitiesReceivedState(cities: event.cities, timestamp: getTimeStamp())));

    on<GetWeatherDetailsEvent>(((event, emit) => _handleGetWheatherDetailsAPI(event, emit)));

    add(LoadingCitiesEvent(Timestamp.fromDate(DateTime.now())));

    _citiesRepository.cities().listen((data) {
      cities = data;
      add(GetAllCitiesEvent(cities: data, timestamp: getTimeStamp()));
    });
  }

  _handleGetWheatherDetailsAPI(GetWeatherDetailsEvent event, Emitter<CitiesState> emit) async {
    var response = await WeatherDetailsAPI().getDetails(event.city);
    if (response != null) {
      emit(WheatherDetailsReceivedState(response));
    } else {
      emit(WheatherDetailsErrorState("Something went wrong!"));
    }
  }

  @override
  Future<void> close() {
    _citiesRepository.dispose();
    return super.close();
  }
}

Timestamp getTimeStamp() => Timestamp.fromDate(DateTime.now());
