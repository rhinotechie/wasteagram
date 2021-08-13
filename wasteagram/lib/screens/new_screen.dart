import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'dart:io';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final _formKey = GlobalKey<FormState>();
  File? photo;
  final photoPicker = ImagePicker();
  int quantity = 0;
  bool _activeButton = false; // Prevents multiple button presses

  @override
  Widget build(BuildContext context) {
    if (photo == null) {
      getPhoto();
      return Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Wasteagram'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.file(photo!, fit: BoxFit.contain)),
                  Semantics(
                    label: 'Text Field',
                    hint:
                        'Opens your keyboard to enter number left over food items.',
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Number of Wasted Items',
                          border: UnderlineInputBorder()),
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Item amount can\'t be empty.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: Semantics(
                      label: 'Upload button',
                      hint: 'Uploads the new post to cloud storage.',
                      button: true,
                      enabled: true,
                      child: ElevatedButton(
                          onPressed: () async {
                            onButtonClick();
                          },
                          child: Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                  )
                ],
              ),
            )),
      );
    }
  }

  // Saves photo, location, date, and quantity to database then closes the screen.
  Future onButtonClick() async {
    if (_formKey.currentState!.validate() && _activeButton == false) {
      _activeButton = true;
      _formKey.currentState!.save(); // Save quantity

      // Retrieves location if permission is allowed
      Location location = new Location();
      bool locationEnabled;
      PermissionStatus allowedLocation;
      LocationData locationData;

      locationEnabled = await location.serviceEnabled();
      if (!locationEnabled) {
        locationEnabled = await location.requestService();
        if (!locationEnabled) {
          _activeButton = true;
          return;
        }
      }

      allowedLocation = await location.hasPermission();
      if (allowedLocation == PermissionStatus.denied) {
        allowedLocation = await location.requestPermission();
        if (allowedLocation != PermissionStatus.granted) {
          _activeButton = true;
          return;
        }
      }

      locationData = await location.getLocation();

      String photoName = DateTime.now().toString() + '.jpg';

      // Stores the new screen's data in firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'date': DateTime.now(),
        'quantity': quantity,
        'latitude': locationData.latitude.toString(),
        'longitude': locationData.longitude.toString(),
        'photo': photoName
      });

      // Stores the photo in cloud storage
      Reference photoReference =
          FirebaseStorage.instance.ref().child(photoName);
      UploadTask uploadTask = photoReference.putFile(photo!);
      await uploadTask;

      // Exits the screen
      Navigator.of(context).pop();
    }
  }

  Future getPhoto() async {
    final foundPhoto = await photoPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = File(foundPhoto!.path);
    });
  }
}
