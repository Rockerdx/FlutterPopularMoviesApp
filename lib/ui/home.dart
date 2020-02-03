import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/models/data.dart';
import 'package:flutter_movies_app/bloc/movies_bloc.dart';

import 'movies_row.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedCategory = 0;
  String sort = 'now_playing';


  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies(sort);

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
                  bloc.fetchAllMovies(sort);

                  break;
                case 1:
                  sort = 'popular';
                  bloc.fetchAllMovies(sort);

                  break;
                case 2:
                  sort = 'upcoming';
                  bloc.fetchAllMovies(sort);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            child: Text('R')),
                      ),
                    ],
                  ),
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
                child: StreamBuilder(
                  stream: bloc.allMovies,
                  builder: (context, AsyncSnapshot<List<Result>> snapshot) {
                    if (snapshot.hasData) {
                      return MovieRow(
                        movies: snapshot.data,
                        onFav: (int index) {},
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
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
