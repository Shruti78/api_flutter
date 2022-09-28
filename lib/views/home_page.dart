import 'package:api_flutter/services/remote_services.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    // method responsible to get data
    super.initState();

    // fetch data from api

    getdata();
  }

  getdata() async {
    posts = await RemoteServices().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Posts')),
      ),
      body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: ((context, index) {
                return Container(
                  child: Text(posts![index].title),
                );
              })),
          replacement: const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
