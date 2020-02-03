import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/models/data.dart';
import 'package:flutter_movies_app/ui/detail.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'movies.dart';

class MovieRow extends StatefulWidget {
  final List<Result> movies;

  final Function onFav;

  const MovieRow({Key key, this.movies, this.onFav}) : super(key: key);
  @override
  _MovieRowState createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Result result = widget.movies[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    result: result,
                                  )));
                    },
                    child: Movies(result: result)),
              ),
            ),
          );
        },
        itemCount: widget.movies.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 185 / 278,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0),
      ),
    );
  }
}
