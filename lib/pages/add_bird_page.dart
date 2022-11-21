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
  final _formKey = GlobalKey<FormState>();

  late final FocusNode _descriptionfocusNode;

  String? name;
  String? description;

  void _submit(BirdModel birdModel, BuildContext context){
    if(!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _descriptionfocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bird'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter bird name",
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    name = value!.trim();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionfocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      print("Please enter bird name...");
                    }
                    if (value.length < 2) {
                      print('Please enter a longer name');
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter bird description",
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    final BirdModel birdModel = BirdModel(
                        birdName: name,
                        latitude: widget.latLng.latitude,
                        longitude: widget.latLng.longitude,
                        birdDescription: description,
                        image: widget.image);
                    _submit(birdModel, context);
                  },
                  onSaved: (value) {
                    description = value!.trim();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      print("Please enter bird description...");
                    }
                    if (value.length < 2) {
                      print('Please enter a longer description');
                    }
                    return null;
                  },
                ),
                FloatingActionButton(
                  onPressed: () {
                    // TODO:- Add bird post to BirdPostCubit

                    final BirdModel birdModel = BirdModel(
                        birdName: name,
                        latitude: widget.latLng.latitude,
                        longitude: widget.latLng.longitude,
                        birdDescription: description,
                        image: widget.image);
                        //context.read<BirdPostCubit>().addPost(birdModel);
                        _submit(birdModel, context);
                  },
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
