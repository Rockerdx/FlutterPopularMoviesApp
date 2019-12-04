import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/model/data.dart';

class Movies extends StatefulWidget {
  final Result result;
  final Function onFav;

  const Movies({Key key, this.result, this.onFav}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(12.0),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Stack(
            children: <Widget>[
              Image.network(
                "http://image.tmdb.org/t/p/w185/" + widget.result.posterPath,
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.result.isFav
                          ? widget.result.isFav = false
                          : widget.result.isFav = true;
                    });
                  },
                  child: Icon(
                    widget.result.isFav
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: widget.result.isFav
                        ? Colors.amber.shade400
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
