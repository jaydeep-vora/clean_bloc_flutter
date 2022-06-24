import 'package:clean_bloc/domain/entities/cities.dart';
import 'package:clean_bloc/presentation/bloc/cities_bloc.dart';
import 'package:clean_bloc/presentation/bloc/cities_event.dart';
import 'package:clean_bloc/presentation/bloc/cities_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({Key? key}) : super(key: key);

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  var bloc = CityBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _mainContent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget _mainContent() {
    return BlocBuilder<CityBloc, CitiesState>(
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: bloc.cities?.length ?? 0,
                itemBuilder: (context, index) {
                  return _rowItem(bloc.cities?[index]);
                },
              ),
              _loadingWidget(state)
            ],
          );
        });
  }

  Widget _rowItem(City? cityData) {
    if (cityData == null) return const SizedBox.shrink();

    return InkWell(
      onTap: () {
        bloc.add(GetWeatherDetailsEvent(city: cityData, timestamp: getTimeStamp()));
      },
      child: Container(
        child: Text(
          cityData.city ?? "",
          style: const TextStyle(fontSize: 20),
        ),
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
      ),
    );
  }

  Widget _loadingWidget(CitiesState state) {
    if (state is LoadingCitiesState) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }
}
