part of 'map_cubit.dart';

abstract class LocationState extends Equatable{
  const LocationState();

  @override
  List<Object> get props => [];
}
class LocationInitial extends LocationState{
  const LocationInitial();
}

class LocationLoading extends LocationState{
  const LocationLoading();
}

class LocationLoaded extends LocationState{
  final double latitud;
  final double longitud;

  const LocationLoaded({required this.latitud, required this.longitud});
  @override
  List<Object> get props => [latitud, longitud];
}

class LocationError extends LocationState{
  const LocationError();
}
