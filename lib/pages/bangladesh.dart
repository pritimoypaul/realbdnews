import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

Future<List> fetchWpPosts(postamount) async {
  final response = await http.get(
      'http://realbdnews.com/wp-json/wp/v2/posts?categories=2&per_page=${postamount}',
      headers: {"Accept": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future<String> fetchImg(url) async {
  final response = await http.get(url, headers: {"Accept": "application/json"});
  var data = jsonDecode(response.body);
  var imgURL = data['media_details']['sizes']['thumbnail']['source_url'];
  print(imgURL);
  return imgURL;
}

class Bangladesh extends StatefulWidget {
  @override
  _BangladeshState createState() => _BangladeshState();
}

class _BangladeshState extends State<Bangladesh> {
  int postAmount = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1000, 175, 166, 65),
        title: Text('Bangladesh'),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                  child: FutureBuilder(
                future: fetchWpPosts(postAmount),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      cacheExtent: 10,
                      addAutomaticKeepAlives: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map wpPost = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/details',
                              arguments: wpPost['_links']['self'][0]['href'],
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FutureBuilder(
                                      future: fetchImg(wpPost['_links']
                                          ['wp:featuredmedia'][0]['href']),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    snapshot.data)),
                                          );
                                        }
                                        return Container(
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            wpPost['title']['rendered'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Text(timeago.format(
                                              DateTime.parse(wpPost['date'])))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
          ),
          FlatButton(onPressed: () {}, child: Text('Ads Here!!'))
        ],
      ),
    );
  }
}

//fetch image:
// fetchImg(wpPost['_links']['wp:featuredmedia'][0]['href'])
