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
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${shortWeekDays[post['date'].toDate().weekday]}, ' +
                  '${shortMonths[post['date'].toDate().month]} ' +
                  '${post['date'].toDate().day}, ' +
                  '${post['date'].toDate().year}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
