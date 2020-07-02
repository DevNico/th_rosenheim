import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/splan_api.dart';
import '../../prefs.dart';

class LocationSettings extends StatefulWidget {
  LocationSettings({Key key}) : super(key: key);

  @override
  _LocationSettingsState createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  bool loaded;
  bool error;

  List<Location> locations;
  Location selectedLocation;

  @override
  void initState() {
    super.initState();
    loaded = false;
    error = false;
    initData();
  }

  void initData() async {
    final locations = await SplanApi().getLocations();

    final prefs = await SharedPreferences.getInstance();
    var selectedLocation;
    try {
      selectedLocation = Location.fromJson(jsonDecode(prefs.getString(prefSplanLocation) ?? ''));
    } on Exception catch (_) {
      selectedLocation = locations.firstWhere((element) => element.id == 3, orElse: () => null);
    }

    if (locations != null) {
      setState(() {
        loaded = true;
        error = false;
        this.locations = locations;
        this.selectedLocation = selectedLocation;
      });
    } else {
      setState(() {
        loaded = true;
        error = true;
      });
    }
  }

  void _saveLocation(Location location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefSplanLocation, jsonEncode(location.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    var body;

    if (loaded) {
      if (error) {
        body = Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'An error occurred loading the available locations. '
              'Please check your internet connectivity or try again later.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        body = ListView.builder(
          shrinkWrap: true,
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final loc = locations[index];

            return RadioListTile(
              title: Text(loc.name),
              value: loc,
              onChanged: (location) {
                _saveLocation(location);
                setState(() => selectedLocation = location);
              },
              groupValue: selectedLocation,
            );
          },
        );
      }
    } else {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location'),
      ),
      body: body,
    );
  }
}
