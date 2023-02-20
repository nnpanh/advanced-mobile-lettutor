import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title,
        style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
        textAlign: TextAlign.justify,
      ),
    );
}