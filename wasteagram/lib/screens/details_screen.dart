import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:wasteagram/models/post.dart';

class DetailsScreen extends StatefulWidget {
  final Post post;
  const DetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${widget.post.getWeekday}, ' +
                  '${widget.post.getMonth} ' +
                  '${widget.post.getWeekday}, ' +
                  '${widget.post.getYear}',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              child: FutureBuilder<String>(
                future: downloadPhoto(widget.post.getPhoto!),
                builder: (context, AsyncSnapshot<String> urlString) {
                  if (urlString.hasData) {
                    return Image.network(urlString.data.toString(),
                        fit: BoxFit.contain);
                  } else if (urlString.hasError) {
                    return Container(color: Colors.red);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              width: double.infinity,
              height: 300,
            ),
            Text('${widget.post.getQuantity} items',
                style: TextStyle(fontSize: 20)),
            Text(
                'Location: (${widget.post.getLatitude}, ${widget.post.getLongitude})',
                style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }

  Future<String> downloadPhoto(String fileName) async {
    String photoURL = await firebase_storage.FirebaseStorage.instance
        .ref(fileName)
        .getDownloadURL();
    return photoURL;
  }
}
