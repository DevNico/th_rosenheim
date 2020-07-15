import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Border border;

  RoundedContainer({
    @required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        color: theme.primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(theme.brightness == Brightness.dark
                    ? 0xFF050809
                    : 0xFF3A5160)
                .withOpacity(0.2),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(12),
      child: child,
    );
  }
}
