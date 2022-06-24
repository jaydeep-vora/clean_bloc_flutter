import 'dart:async';

import 'package:clean_bloc/core/utils/utilities.dart';
import 'package:clean_bloc/domain/entities/cities.dart';
import 'package:clean_bloc/domain/usecases/cities_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CitiesRepository with CitiesUseCase {
  
  StreamSubscription<DocumentSnapshot>? _streamSubscription;
  final tag = 'CitiesRepository';

  StreamController<List<City>> _stream = StreamController<List<City>>();

  @override
  Stream<List<City>> cities() => _stream.stream;

  @override
  Future<void> configureDataListener() async {
    try {
      await _cancelStreamSubscription();

      _streamSubscription = getSnapShots()?.listen((documentSnapshot) {
        printLog('configureDataListener called with data');
        var data = documentSnapshot.data();
        List<City> allCities = [];

        if (data != null) {
          if (data is Map) {
            var cities = List<dynamic>.from(data["items"]).map((e) => City.fromJson(e));
            printLog(cities.length);
            allCities.addAll(cities);
          }
        }
    
        _stream.add(allCities);
      });
    } catch (e) {
      printLog(e);
    }
  }


  Future<void> _cancelStreamSubscription() async {
    if (_streamSubscription != null) {
      printLog('cancelStreamSubscription');
      try {
        await _streamSubscription?.cancel();
      } catch (exception) {
        printLog('cancelStreamSubscription $exception');
      } finally {
        printLog('cancelStreamSubscription finally called');
        _streamSubscription = null;
      }
    }
  }

  Stream<DocumentSnapshot>? getSnapShots() {
    return FirebaseFirestore.instance
          .doc(nodePath())
          .snapshots();
  }

  String nodePath() => "cities/list";
  
  @override
  void dispose() {
    _stream.close();
  }

}

