import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_screen.dart';
import 'package:wasteagram/widgets/post_list.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Center(child: PostList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navToNew(context);
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  navToNew(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewScreen()));
  }
}
