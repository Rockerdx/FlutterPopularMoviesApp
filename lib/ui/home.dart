import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/ApiService.dart';
import 'package:flutter_movies_app/model/data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'movies_row.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ApiService apiService;
  int selectedCategory = 0;
  String sort = 'now_playing';

  Future<List<Result>> _future;

  @override
  void initState() {
    apiService = ApiService();
    _future = apiService.getProfiles(sort);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updatelist() {
      _future = apiService.getProfiles(sort);
    }

    List<String> category = new List();
    category.add("New");
    category.add("Popular");
    category.add("Upcoming");

    Widget _buildCategory(int index) {
      return GestureDetector(
          onTap: () {
            setState(() {
              switch (index) {
                case 0:
                  sort = 'now_playing';
                  updatelist();

                  break;
                case 1:
                  sort = 'popular';
                  updatelist();

                  break;
                case 2:
                  sort = 'upcoming';
                  updatelist();
                  break;
              }
              selectedCategory = index;
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              category[index],
              style: TextStyle(
                  color: selectedCategory == index
                      ? Color(0xFF000000)
                      : Color(0xFFAAAAAA),
                  fontWeight: FontWeight.bold),
            ),
          ));
    }

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      GestureDetector(
//                        onTap: () {},
//                        child: CircleAvatar(
//                            backgroundColor: Colors.grey,
//                            foregroundColor: Colors.white,
//                            child: Text('R')),
//                      ),
//                    ],
//                  ),
                  Text(
                    'DISCOVER',
                    style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: category
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => _buildCategory(map.key),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: FutureBuilder(
                  future: _future,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Result>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                            "Something wrong with message: ${snapshot.error.toString()}"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return MovieRow(
                        profiles: snapshot.data,
                        onFav: (int index) {},
                      );
                    } else {
                      return Center(
                          child:
                              SpinKitWave(size: 30.0, color: Colors.blueGrey));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
