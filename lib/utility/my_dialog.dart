// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungtransport/widges/show_image.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> twoWayDialog(
      {required String title, required String subTitle}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: SizedBox(width: 100,
            child: ShowImage(
              path: 'images/avatar.png',
            ),
          ),
        ),
      ),
    );
  }
}   // Class
