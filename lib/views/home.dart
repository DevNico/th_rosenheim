import 'dart:ui';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../locale/translation.dart';
import 'dashboard.dart';
import 'map.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _index;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController(initialPage: _index, keepPage: true);
    _pageController.addListener(() => setState(() => _index = _pageController.page.toInt()));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          DashboardPage(),
          MapPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        hasInk: true,
        currentIndex: _index,
        onTap: (index) => _pageController.jumpToPage(index),
        backgroundColor: theme.primaryColorLight,
        items: <BubbleBottomBarItem>[
          _buildBubbleBottomBarItem(Icons.home, ThTranslations.of(context).dashboard),
          _buildBubbleBottomBarItem(MdiIcons.map, ThTranslations.of(context).map),
          _buildBubbleBottomBarItem(MdiIcons.cog, ThTranslations.of(context).settings),
        ],
      ),
    );
  }

  BubbleBottomBarItem _buildBubbleBottomBarItem(IconData icon, String text) {
    final theme = Theme.of(context);

    return BubbleBottomBarItem(
      icon: Icon(icon, color: theme.primaryIconTheme.color),
      activeIcon: Icon(icon, color: theme.accentColor),
      title: Text(text, style: TextStyle(color: theme.primaryTextTheme.subtitle1.color)),
      backgroundColor: theme.accentColor,
    );
  }
}
