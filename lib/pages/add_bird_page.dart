import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';

import '../models/bird_post_model.dart';

class AddBirdPage extends StatefulWidget {
  final LatLng latLng;
  final File image;

  AddBirdPage({required this.latLng, required this.image});

  @override
  State<AddBirdPage> createState() => _AddBirdPageState();
}

class _AddBirdPageState extends State<AddBirdPage> {
  String? name;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bird'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery
              .of(context)
              .size
              .width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: FileImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        TextField(
          onChanged: (value) {
            name = value;
          },
        ),
        TextField(
          onChanged: (value) {
            description = value;
          },
        ),
        FloatingActionButton(
            onPressed: () {
              // TODO:- Add bird post to BirdPostCubit
              if (name != null && description != null) {
                if (name != "" && description != "") {
                  final BirdModel birdModel = BirdModel(
                      birdName: name!,
                      latitude: widget.latLng.latitude,
                      longitude: widget.latLng.longitude,
                      birdDescription: description!,
                      image: widget.image);
                }
              }
            },


            child: const Icon(Icons.check),
      ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
