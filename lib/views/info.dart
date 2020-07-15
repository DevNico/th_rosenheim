import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/url_utils.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              'TH Rosenheim',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Hochschulstraße 1\n83024 Rosenheim\nDeutschland'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('info@th-rosenheim.de'),
            onTap: () => launchURL('mailto:info@th-rosenheim.de'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+49 8031 8050'),
            onTap: () => launchURL('tel:+4980318050'),
          ),
          ListTile(
            leading: Icon(MdiIcons.web),
            title: Text('www.th-rosenheim.de'),
            onTap: () => launchURL('https://www.th-rosenheim.de'),
          ),
          ListTile(
            leading: Icon(MdiIcons.youtube),
            title: Text('Youtube'),
            onTap: () => launchURL(
              'https://youtube.com/channel/UCYpKSNr3xlmpEOGRvqlX4XQ',
            ),
          ),
          ListTile(
            leading: Icon(MdiIcons.facebook),
            title: Text('Facebook'),
            onTap: () => launchURL('https://facebook.com/THRosenheim/'),
          ),
        ],
      ),
    );
  }
}
