import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts(postamount) async {
  final response = await http.get(
      'http://realbdnews.com/wp-json/wp/v2/posts?per_page=${postamount}',
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int postAmount = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Bangladesh',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Campus',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Economy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Education',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Entertainment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Features',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Health',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'International',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Jobs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Lifestyle',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Opinion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Others',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Politics',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Pressbox',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Religion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Sports',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'Technology',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      'We are',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1000, 19, 32, 48),
        title: Text('RealBDNews'),
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
                                          0.64,
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
                                          Text(wpPost['date']
                                              .toString()
                                              .replaceFirst('T', ' | '))
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
