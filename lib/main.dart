import 'dart:convert';

import 'package:backgrounds_app/unsplash_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'images_list.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

final apiKey = dotenv.env['ACCESS_KEY'];

Future<List<UnsplashImage>> getImages() async {
  final response = await http
      .get(Uri.parse('https://api.unsplash.com/photos/?client_id=$apiKey' ));
  if (response.statusCode == 200) {
    return List<UnsplashImage>.from(jsonDecode(response.body).map((img) => UnsplashImage.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Toitoine's images",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<List<UnsplashImage>> images;

  @override
  void initState() {
    super.initState();
    images = getImages();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text("Toitoine's images"),
        ),
        body:Container(
          child: FutureBuilder<List<UnsplashImage>>(
            future: getImages(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    children: snapshot.data!.map((e) => ImagesList(img: e)).toList()
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        )
    );
  }
}
