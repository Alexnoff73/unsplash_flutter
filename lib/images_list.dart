import 'package:backgrounds_app/unsplash_image.dart';
import 'package:flutter/material.dart';

import 'image.dart';

class ImagesList extends StatelessWidget {

  final UnsplashImage img;

  const ImagesList (
      { required this.img }
      ) : super();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child : Card(
          color: Colors.transparent,
          elevation: 5,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image : NetworkImage(img.regularUrl),
                      fit: BoxFit.cover
                  )
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => image(img: img,)),
                  );
                },
              )
          ),
        )
    );
  }}