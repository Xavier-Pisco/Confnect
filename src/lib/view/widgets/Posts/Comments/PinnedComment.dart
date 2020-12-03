import 'package:confnect/model/Comment.dart';
import 'package:confnect/model/Post.dart';
import 'package:confnect/model/Talk.dart';
import 'package:confnect/model/User.dart';
import 'package:confnect/view/widgets/Posts/Comments/CommentTile.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class PinnedComment extends StatefulWidget {
  final Post _post;
  final User _host;
  PinnedComment(this._post, this._host);
  @override
  _PinnedCommentState createState() => _PinnedCommentState();
}

class _PinnedCommentState extends State<PinnedComment> {
  Comment olderHostComment() {
    List<Comment> _comments = widget._post.getComments();
    for (int i = 0; i < _comments.length; i++) {
      if (_comments[i].getAuthor().getUsername() ==
          widget._host.getUsername()) {
        return _comments[i];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget._host != null) {
      Comment comment = olderHostComment();
      if (comment == null)
        return Container();
      else
        return new Column(
          children: [
            Divider(
              thickness: 2,
            ),
            Text('Pinned Answer'),
            new CommentTile(comment),
          ],
        );
    } else {
      return Container();
    }
  }
}
