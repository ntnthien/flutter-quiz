import 'package:flutter/material.dart';
import './home_screen.dart';

class ScoreScreen extends StatelessWidget {
  final int _score;
  final int _totalQuestion;

  ScoreScreen(this._score, this._totalQuestion);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Your Score: ",
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50.0),
          ),
          new Text(
              this._score.toString() + "/" + this._totalQuestion.toString()),
          new IconButton(
            icon: new Icon(Icons.arrow_right),
            color: Colors.white,
            iconSize: 50.0,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new HomeScreen()),
                (Route route) => route == null),
          )
        ],
      ),
    );
  }
}
