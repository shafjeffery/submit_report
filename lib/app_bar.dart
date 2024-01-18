import 'package:flutter/material.dart';
import 'condition_page.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 160 ,
    title:  Padding(
      padding: EdgeInsets.only(left: 8.0),
      // to make report title a bit lower from the top
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'Ubuntu', // Ubuntu font
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

    flexibleSpace: PreferredSize(
      preferredSize: const Size.fromHeight(180.0), // custom height to 180
      child: Container(
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          gradient: LinearGradient(
            colors: [Color(0xFF00ffd0), Color(0xFF0093b4)],
            //  gradient colors mint blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 1.0], //  stops for balancrd gradient
          ),
        ),
      ),
    ),

    actions: <Widget>[
      Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // align icon to end right
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () { // noti icon tap
                  },
                  child: const Icon(
                    Icons.notifications, // noti icon
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 16.0), // position top right
                child: GestureDetector(
                  onTap: () { // Handle profile icon tap
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('images/duck.jpg'), // profile pic
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

