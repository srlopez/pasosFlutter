import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final isLoading;
  CircularProgress([this.isLoading = true]);

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            height: 0,
            width: 0,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
