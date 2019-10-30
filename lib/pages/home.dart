import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final response = await http.get('http://realbdnews.com/wp-json/wp/v2/posts',
      headers: {"Accept": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<String> fetchImg(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var imgURL = data['guid']['rendered'];
  print(imgURL);
  return imgURL;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: <Widget>[
            ListTile(
              onTap: null,
              title: Text('Page 1'),
            ),
            ListTile(
              onTap: null,
              title: Text('হোম'),
            ),
            ListTile(
              onTap: null,
              title: Text('বাংলাদেশ'),
            ),
            ListTile(
              onTap: null,
              title: Text('বিশ্ব'),
            ),
          ],
        )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('RealBDNews'),
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
          future: fetchWpPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map wpPost = snapshot.data[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                              future: fetchImg(wpPost['_links']
                                  ['wp:featuredmedia'][0]['href']),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image(
                                      image: NetworkImage(snapshot.data));
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 2.0),
                            child: Text(
                              wpPost['title']['rendered'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}

//fetch image:
// fetchImg(wpPost['_links']['wp:featuredmedia'][0]['href'])
