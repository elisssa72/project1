import 'package:flutter/material.dart';
import 'flipcardgame.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add an image here
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/game.png'),

              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Choose Difficulty",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
             Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => _list[index].goto,
                          ),
                        );
                      },
                      child: Padding(

                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _list[index].primarycolor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black45,
                                    spreadRadius: 0.5,
                                    offset: Offset(3, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          _list[index].goto,
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: _list[index].primarycolor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      _list[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Details {
  String name;
  Color primarycolor; // Make sure this is assigned a valid Color
  Widget goto;

  Details({
    required this.name,
    required this.primarycolor,
    required this.goto,
  });
}

List<Details> _list = [
  Details(
    name: "EASY",
    primarycolor: Colors.yellow,
    goto: FlipCardGane(Level.Easy),
  ),
  Details(
    name: "MEDIUM",
    primarycolor: Colors.red,
    goto: FlipCardGane(Level.Medium),
  ),
  Details(
    name: "HARD",
    primarycolor: Colors.purple,
    goto: FlipCardGane(Level.Hard),
  ),
];