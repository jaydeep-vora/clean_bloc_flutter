import 'package:clean_bloc/domain/entities/cities.dart';
import 'package:clean_bloc/domain/entities/weather_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class CitiesState extends Equatable {

  @override
  List<Object?> get props => [];

}

class InitialCitiesState extends CitiesState {}

class LoadingCitiesState extends CitiesState {
  final Timestamp timestamp;

  LoadingCitiesState(this.timestamp);
}

class CitiesReceivedState extends CitiesState {

  final List<City> cities;
  final Timestamp timestamp;

  CitiesReceivedState({required this.cities, required this.timestamp});
}

class WheatherDetailsReceivedState extends CitiesState {

  final WheatherDetails wheatherDetails;

  WheatherDetailsReceivedState(this.wheatherDetails);
}

class WheatherDetailsErrorState extends CitiesState {

  final String erroMessage;

  WheatherDetailsErrorState(this.erroMessage);
}