import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/models/data.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Result result;

  const DetailPage({Key key, this.result}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Stack(children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                "http://image.tmdb.org/t/p/w500/" +
                                    widget.result.posterPath,
                              )),
                        ),
                        constraints: BoxConstraints.expand()),
                    Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.grey.shade900,
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    ),
                    Positioned(
                      right: 20.0,
                      top: 20.0,
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
                          size: 40.0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              widget.result.releaseDate.year.toString() +
                                  ' \u2022 ' +
                                  'Action',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.result.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 80.0,
                                  fontFamily: 'BebasNeue'),
                            ),
                          ],
                        ),
                      ),
                      bottom: 10.0,
                    )
                  ]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              widget.result.voteAverage.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              ' / 10 ',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Image.network(
                              'https://img.icons8.com/color/48/000000/imdb.png',
                              height: 25.0,
                              alignment: Alignment.topCenter,
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            widget.result.overview,
                            style: TextStyle(color: Colors.white, height: 1.5),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RaisedButton(
                                  child: Text('Trailer'),
                                  onPressed: () async {
                                    const url =
                                        'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  }),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
