import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'data.dart';
import 'dart:async';

class FlipCardGane extends StatefulWidget {
  final Level _level;

  FlipCardGane(this._level);

  @override
  _FlipCardGaneState createState() => _FlipCardGaneState(_level);
}

class _FlipCardGaneState extends State<FlipCardGane> {
  bool _isFinished = false;
  int _left = 0;
  Timer? _timer;
  _FlipCardGaneState(this._level);

  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  Level _level;
  // Timer _timer;
  int _time = 5;
  // int _left;
  // bool _isFinished;
  List<String> _data = [];
  List<bool> _cardFlips = [];
  List<GlobalKey<FlipCardState>> _cardStateKeys = [];

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 3,
            spreadRadius: 0.8,
            offset: Offset(2.0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }

  void startTimer() {   //function to count down
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray(
      _level,
    );
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level);
    _time = 5;
    _left = (_data.length ~/ 2);   //nb of pairs left
    _isFinished = false;  //not finished
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        _start = true;
        _timer?.cancel();
      });
    });
  }

  @override
  void initState() {   //assure game is set to inital state when the widget is created
    super.initState();

    restart();
  }

  @override
  void dispose() {
    super.dispose(); //cleanup
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished   //if true
        ? Scaffold(
      body: Center(

        child: AlertDialog(
          title: Text('You Win!'),
          content: Text('Congratulations!.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear the displayed word and start a new game
                setState(() {
                  restart();
                });

              },
              child: Text('Play Again'),
            ),

          ],
        ),

      ),
    )
        : Scaffold(           //else
      body: SafeArea(
        child: SingleChildScrollView(  //allow scrolling
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _time > 0             //if time>0
                    ? Text(
                  '$_time',                       //print(time)
                  style: Theme.of(context).textTheme.headline3,
                )
                    : Text(
                  'Left: $_left',                   //show the countdown
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => _start
                      ? FlipCard(
                      key: _cardStateKeys[index],
                      onFlip: () {
                        if (!_flip) {
                          _flip = true;
                          _previousIndex = index;
                        } else {
                          _flip = false;
                          if (_previousIndex != index) {
                            if (_data[_previousIndex] != _data[index]) {           //compare
                              _wait = true;

                              Future.delayed(const Duration(milliseconds: 1500), () {
                                _cardStateKeys[_previousIndex]
                                    .currentState
                                    ?.toggleCard();
                                _previousIndex = index;
                                _cardStateKeys[_previousIndex].currentState?.toggleCard();

                                Future.delayed(
                                    const Duration(milliseconds: 160), () {
                                  setState(() {
                                    _wait = false;
                                  });
                                });
                              });
                            } else {
                              _cardFlips[_previousIndex] = false;
                              _cardFlips[index] = false;     //are shown not closed
                              print(_cardFlips);

                              setState(() {
                                _left -= 1;               //left is decreased by 1
                              });
                              if (_cardFlips.every((t) => t == false)) {
                                print("Won");
                                Future.delayed(
                                    const Duration(milliseconds: 160), () {
                                  setState(() {
                                    _isFinished = true;
                                    _start = false;
                                  });
                                });
                              }
                            }
                          }
                        }
                        setState(() {});
                      },
                      flipOnTouch: _wait ? false : _cardFlips[index],
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 3,
                              spreadRadius: 0.8,
                              offset: Offset(2.0, 1),
                            )
                          ],
                        ),
                        margin: EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/languages/quest.png",
                          ),
                        ),
                      ),
                      back: getItem(index))
                      : getItem(index),
                  itemCount: _data.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}