import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = _fetchImageUrl();
  }

  Future<String> _fetchImageUrl() async {
    var result = "https://via.placeholder.com/150";
    await Future.delayed(Duration(seconds: 3));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            _imageUrl= _fetchImageUrl();
            setState(() {
            });
          },
          child:
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            padding: EdgeInsets.all(8.0),
            itemCount: 2,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: _imageUrl,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                      break;
                    default:
                      break;
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return snapshot.hasData ? Image.network(snapshot.data) : CircularProgressIndicator();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

