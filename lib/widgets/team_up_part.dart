import 'package:flutter/material.dart';

class TeamUpPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/toss.jpg'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/home/find-room');
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      border:
                          Border.all(color: Colors.purple.shade900, width: 1)),
                  width: 300,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/search.png',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Find a chat room!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        softWrap: true,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/home/create-room');
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      border:
                          Border.all(color: Colors.purple.shade900, width: 1)),
                  width: 300,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/add.png',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Create new room!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        softWrap: true,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
