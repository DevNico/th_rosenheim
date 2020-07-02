import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String text;
  final Widget trailing;

  ListHeader({
    @required this.text,
    this.trailing,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: trailing == null ? 12 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).primaryTextTheme.headline6.copyWith(fontWeight: FontWeight.w500),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
