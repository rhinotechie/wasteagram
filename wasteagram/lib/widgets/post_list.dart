import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/screens/details_screen.dart';
import 'package:wasteagram/models/post.dart';

const weekDays = [
  'placeholder',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const months = [
  'placeholder',
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'December'
];

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snapshotPost = snapshot.data!.docs[index];
                  Post post = Post(
                      date: snapshotPost['date'].toDate(),
                      quantity: snapshotPost['quantity'],
                      photoURL: snapshotPost['photo'],
                      latitude: snapshotPost['latitude'],
                      longitude: snapshotPost['longitude']);
                  return ListTile(
                    title: Text('${post.getWeekday!}, ' +
                        '${post.getMonth} ' +
                        '${post.getDay}, ' +
                        '${post.getYear}'),
                    trailing: Text('${post.getQuantity}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    onTap: () {
                      navToDetails(context, post);
                    },
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void navToDetails(BuildContext context, var post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailsScreen(post: post)));
  }
}
