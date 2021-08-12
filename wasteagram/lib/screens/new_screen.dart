import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                child: Placeholder(),
                aspectRatio: 3 / 2,
              ),
              TextFormField(
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
              Container(
                width: double.infinity,
                height: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                      size: 40,
                    )),
              )
            ],
          )),
    );
  }
}
