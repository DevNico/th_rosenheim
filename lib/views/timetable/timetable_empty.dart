import 'package:flutter/material.dart';

import '../widgets/rounded_container.dart';

class TimetableNoLectures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/sleep.png',
            width: 200,
          ),
          SizedBox(height: 16),
          Text(
            'Heute keine Vorlesungen',
            style: Theme.of(context)
                .primaryTextTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
