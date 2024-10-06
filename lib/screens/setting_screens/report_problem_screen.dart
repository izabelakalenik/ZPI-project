import 'package:flutter/material.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Report Problem',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}