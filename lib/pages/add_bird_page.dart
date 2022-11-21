import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AddBirdPage extends StatefulWidget {
  final LatLng latLng;
  AddBirdPage({required this.latLng});

  @override
  State<AddBirdPage> createState() => _AddBirdPageState();
}

class _AddBirdPageState extends State<AddBirdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text("${widget.latLng.latitude} ${widget.latLng.longitude}"),
        ),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("POP"),)
      ],
    );
  }
}
