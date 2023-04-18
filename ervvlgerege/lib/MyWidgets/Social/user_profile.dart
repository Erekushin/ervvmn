import 'package:flutter/material.dart';

Widget userProPic(String url, double radius) {
  return Container(
      margin: const EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundImage: NetworkImage(url),
        radius: radius,
      ));
}
