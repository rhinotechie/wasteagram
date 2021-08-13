import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Number of Wasted Items',
                        border: UnderlineInputBorder()),
                    onSaved: (value) {
                      print('Saved!');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Item amount can\'t be empty.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(
                          Icons.cloud_upload,
                          color: Colors.white,
                          size: 40,
                        )),
                  )
                ],
              ),
            )),
      );
    }
  }

  Future getPhoto() async {
    final foundPhoto = await photoPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = File(foundPhoto!.path);
    });
  }
}
