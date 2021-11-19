import 'dart:developer';
import 'dart:ui';

import 'package:backgrounds_app/main.dart';
import 'package:backgrounds_app/unsplash_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class image extends StatelessWidget {

  final UnsplashImage img;

  const image (
      { required this.img }
      ) : super();

  _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    await launch(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Image.network(
              img.regularUrl,
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "Toitoine's images",)));
                  }),),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          width: 400.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200.withOpacity(0.5),
                          ),
                          child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(img.description ?? 'This image has no description'),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              log("The image has been downloaded");
                                            },
                                            child: const Text('Download', style: TextStyle(color: Colors.white),),
                                            style: ElevatedButton.styleFrom(primary: Colors.black, fixedSize: const Size(130, 30)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:10.0),
                                        child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(color: Colors.black),
                                              children: [
                                                const TextSpan(text: "Captured by :")
                                              ]
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            _launchUrl(img.userProfileUrl);
                                          },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(img.userProfileImage ?? '', fit: BoxFit.cover,),
                                            ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}