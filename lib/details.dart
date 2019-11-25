import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:share/share.dart';

Future<String> fetchPostTitle(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var postTitle = data['title']['rendered'];
  print(postTitle);
  return postTitle;
}

Future<String> fetchPostImage(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var postImg = data['_links']['wp:featuredmedia'][0]['href'];
  print(postImg);
  return postImg;
}

Future<String> fetchImg(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var imgURL = data['guid']['rendered'];
  print(imgURL);
  return imgURL;
}

Future<String> fetchPostDesc(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var postDesc = data['content']['rendered'];
  print(postDesc);
  return postDesc;
}

Future<String> fetchPostLink(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var postLink = data['link'];
  print(postLink);
  return postLink;
}

class Details extends StatelessWidget {
  final String data;

  Details({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1000, 175, 166, 65),
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: fetchPostTitle(data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: fetchPostImage(data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: fetchImg(snapshot.data),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image(
                              image: NetworkImage(snapshot.data),
                            );
                          }
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: fetchPostDesc(data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        parse(snapshot.data.toString()).documentElement.text,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: fetchPostLink(data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FlatButton(
                        onPressed: () {
                          Share.share(
                              'Read more Real BD News at ' + snapshot.data);
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Container(
                          width: 80,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.share),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Share'),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
