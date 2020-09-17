import 'dart:convert';
import 'package:http/http.dart' as http;
import '../general.dart';

class Comment {
  String commentId, resturantId, comment, star;

  Comment(
      {this.commentId = "",
      this.resturantId = "",
      this.comment = "",
      this.star = ""});

  factory Comment.fromJson(json) {
    return Comment(
      commentId: json['comment_id'],
      resturantId: json['resturant_id'],
      comment: json['comment'],
      star: json['star'],
    );
  }

  toMap() {
    return {
      "resturant_id": this.resturantId,
      "comment": this.comment,
      "star": this.star,
    };
  }

  Future<bool> createComment() async {
    http.Response response =
        await http.post("$domain/comment/create.php", body: this.toMap());
    print(response.body);
    var res = json.decode(response.body);
    print(res);
    if (!res['error']) {
      return true;
    }
    return false;
  }
}

Future<List<Comment>> fetchCommentData({String resturantId}) async {
  List<Comment> comments = List();
  http.Response response = await http
      .post("$domain/comment/read.php", body: {"resturant_id": resturantId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['comment'];
  for (var item in data) {
    comments.insert(0, Comment.fromJson(item));
  }
  return comments;
}
