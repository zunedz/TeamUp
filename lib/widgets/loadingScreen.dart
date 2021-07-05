import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: LoadingIndicator(
            indicatorType: Indicator.lineScale,
            color: Colors.purple.shade300,
          ),
        ),
      ),
    );
  }
}
