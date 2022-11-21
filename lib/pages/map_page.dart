import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/bloc/map_cubit.dart';
import 'package:spot_the_bird/pages/add_bird_page.dart';
import 'package:image_picker/image_picker.dart';

class MapPage extends StatelessWidget {
  final MapController _mapController = MapController();

  Future<void> _pickImageAndCreatePost({required LatLng latLng, required BuildContext context}) async {
    File? image;
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddBirdPage(latLng: latLng, image: image!),
        ),
      );
    } else {
      print("User didn't pick image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (previousState, currentState) {
          if (currentState is LocationLoaded) {
            _mapController.move(
                LatLng(currentState.latitud, currentState.longitud), 15.6);
          }
          if (currentState is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error"),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.black,
              ),
            );
          }
        },
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onLongPress: (tapPosition, latLng) {
              // TODO:- Pick Image and go to AddBirdScreen

              _pickImageAndCreatePost(latLng: latLng, context: context);
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddBirdPage(latLng: latLng,)),
              );*/
            },
            center: LatLng(0, 0),
            zoom: 15.6,
            maxZoom: 17,
            minZoom: 3.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              retinaMode: true,
            ),
          ],
        ),
      ),
    );
  }
}
