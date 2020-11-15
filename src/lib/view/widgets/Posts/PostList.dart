import 'package:confnect/controller/Controller.dart';
import 'package:confnect/controller/database/MockAdapter.dart';
import 'package:confnect/view/widgets/Posts/PostTile/PostTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  Controller _controller;
  PostList(this._controller);
  @override
  Widget build(BuildContext context) {
    //final Users users = Provider.of(context);
    return ListView(children: posts());
  }

  List<PostTile> posts() {
    return MockAdapter.getPosts()
        .map((post) => PostTile(post, this._controller))
        .toList();
  }
}
