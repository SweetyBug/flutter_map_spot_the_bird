import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'map_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationInitial());
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied || permission != LocationPermission.deniedForever){
      permission = await Geolocator.requestPermission();
      emit(LocationLoading());
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
        );
        emit(LocationLoaded(latitud: position.latitude, longitud: position.longitude));
      }catch (error) {
        print(error);
        emit(LocationError());
      }
    }
  }
}

