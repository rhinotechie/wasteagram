import 'package:flutter/material.dart';

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

class DetailsScreen extends StatelessWidget {
  final post;
  const DetailsScreen({Key? key, required this.post}) : super(key: key);

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
              '${shortWeekDays[post['date'].toDate().weekday]}, ' +
                  '${shortMonths[post['date'].toDate().month]} ' +
                  '${post['date'].toDate().day}, ' +
                  '${post['date'].toDate().year}',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              child: Placeholder(),
              width: 200,
              height: 200,
            ),
            Text('${post['quantity']} items', style: TextStyle(fontSize: 20)),
            Text('Location: (${post['latitude']}, ${post['longitude']})',
                style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}
