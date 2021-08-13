import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

const shortWeekDays = [
  'placeholder',
  'Mon',
  'Tues',
  'Wed',
  'Thurs',
  'Fri',
  'Sat',
  'Sun'
];

const shortMonths = [
  'placeholder',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Dec'
];

class DetailsScreen extends StatefulWidget {
  final post;
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
              '${shortWeekDays[widget.post['date'].toDate().weekday]}, ' +
                  '${shortMonths[widget.post['date'].toDate().month]} ' +
                  '${widget.post['date'].toDate().day}, ' +
                  '${widget.post['date'].toDate().year}',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              child: FutureBuilder<String>(
                future: downloadPhoto(widget.post['photo']),
                builder: (context, AsyncSnapshot<String> urlString) {
                  if (urlString.hasData) {
                    return Image.network(urlString.data.toString(),
                        fit: BoxFit.contain);
                  } else if (urlString.hasError) {
                    return Container(color: Colors.red);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              width: double.infinity,
              height: 300,
            ),
            Text('${widget.post['quantity']} items',
                style: TextStyle(fontSize: 20)),
            Text(
                'Location: (${widget.post['latitude']}, ${widget.post['longitude']})',
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
