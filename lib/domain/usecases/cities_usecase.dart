import 'package:clean_bloc/domain/entities/cities.dart';

abstract class CitiesUseCase {
  
  Stream<List<City>> cities();

  void configureDataListener();

  void dispose();
}
