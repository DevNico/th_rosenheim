import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: AssetImage('assets/lageplan.png'),
      backgroundDecoration: BoxDecoration(color: Colors.white),
    );
  }
}
