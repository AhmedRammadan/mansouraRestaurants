import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatelessWidget {
  String url;

  ShowImage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            child: PhotoView(
              imageProvider: NetworkImage(url),
            )),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: IconButton(
                icon: Icon(Icons.arrow_forward,color: Colors.white,),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ]),
    );
  }
}
