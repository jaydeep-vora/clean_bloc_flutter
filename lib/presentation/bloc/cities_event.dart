import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/cities.dart';

abstract class CitiesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingCitiesEvent extends CitiesEvent {
  final Timestamp timestamp;

  LoadingCitiesEvent(this.timestamp);
}

class GetAllCitiesEvent extends CitiesEvent {

  final List<City> cities;
  final Timestamp timestamp;

  GetAllCitiesEvent({required this.cities, required this.timestamp});
}

class GetWeatherDetailsEvent extends CitiesEvent {

  final City city;
  final Timestamp timestamp;

  GetWeatherDetailsEvent({required this.city, required this.timestamp});
}