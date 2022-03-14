import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bookCard() {
  return Container(
    height: 150,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        buildCard(),
        SizedBox(
          width: 12,
        ),
        buildCard(),
        SizedBox(
          width: 12,
        ),
        buildCard(),
        SizedBox(
          width: 12,
        ),
        buildCard(),
        SizedBox(
          width: 12,
        ),
      ],
    ),
  );
}

Widget buildCard() => Container(
      width: 200,
      height: 200,
      color: Colors.red,
    );
