import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/canteen/canteen_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/timetable/timetable_bloc.dart';
import '../locale/translation.dart';
import '../model/splan/timetable_entry.dart';
import '../theme.dart';
import '../utils/date_utils.dart';
import 'additives.dart';
import 'widgets/canteen.dart';
import 'widgets/date_selector.dart';
import 'widgets/list_header.dart';
import 'widgets/timetable.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // PageView
  PageController _pageController;
  int _lastPage;

  // DateSelector
  ValueKey _selectorKey;
  DateTime _today;
  DateTime _selectedDate;
  DateTime _visibleWeekStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().toUtc().withoutTime();

    _selectorKey = ValueKey(now);
    _today = now;
    _selectedDate = now;
    _visibleWeekStart = now.weekStart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SettingsBloc, Settings>(
      builder: (context, settings) {
        if (!settings.initialized) {
          return Center(child: CircularProgressIndicator());
        }

        if (settings.semester == null ||
            settings.course == null ||
            settings.lectures == null ||
            settings.lectures.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(ThTranslations.of(context).settingsTimetableNotConfigured),
                if (settings.semester == null) Text(ThTranslations.of(context).settingsSemesterNotConfigured),
                if (settings.course == null) Text(ThTranslations.of(context).settingsCourseNotConfigured),
                if (settings.lectures == null || settings.lectures.isEmpty)
                  Text(ThTranslations.of(context).settingsLecturesNotConfigured),
              ],
            ),
          );
        }

        if (_lastPage == null) {
          _lastPage = settings.semester.startDate.differenceInDaysWithoutWeekends(_selectedDate);
          _pageController = PageController(initialPage: _lastPage);
        }

        return NestedScrollView(
          headerSliverBuilder: (_, b) {
            return [
              SliverAppBar(
                backgroundColor: theme.primaryColorLight,
                shape: kAppBarShape,
                floating: true,
                pinned: true,
                expandedHeight: 140,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text('TH Rosenheim', textAlign: TextAlign.left),
                      ),
                      FlatButton(
                        onPressed: () {
                          _pageController
                              .jumpToPage(settings.semester.startDate.differenceInDaysWithoutWeekends(_today));
                          setState(() => _selectedDate = _today);
                        },
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              DateFormat('EE  dd. MMM', 'de_DE').format(_today).replaceAll(r'(\d+)', r'$1\.'),
                              style: theme.primaryTextTheme.bodyText1.copyWith(fontSize: 16),
                              maxFontSize: 16,
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          DateSelector(
                            key: _selectorKey,
                            startDate: settings.semester.startDate,
                            endDate: settings.semester.endDate,
                            selectedDate: _selectedDate,
                            onDaySelected: (date) {
                              setState(() {
                                _pageController
                                    .jumpToPage(settings.semester.startDate.differenceInDaysWithoutWeekends(date));
                                _selectedDate = date;
                                _visibleWeekStart = date.weekStart();
                                _selectorKey = ValueKey(_visibleWeekStart);
                              });
                            },
                            onSwipe: (weekStart) {
                              setState(() {
                                _visibleWeekStart = weekStart;
                              });
                            },
                          ),
                          Text(
                            DateFormat('MMMM yyyy', 'de_DE').format(_visibleWeekStart),
                            style: theme.primaryTextTheme.bodyText1.copyWith(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: PageView.builder(
            key: ValueKey(_today),
            physics: ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: settings.semester.weekDays,
            itemBuilder: (_, i) {
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                children: <Widget>[
                  ListHeader(text: ThTranslations.of(context).timetable),
                  BlocBuilder<TimetableBloc, TimetableState>(
                    builder: (context, timetableState) {
                      final date = settings.semester.startDate.add(Duration(days: i + (i ~/ 5) * 2)).withoutTime();

                      if (timetableState is! TimetableLoaded ||
                          !(timetableState as TimetableLoaded).timetable.containsKey(i)) {
                        BlocProvider.of<TimetableBloc>(context).add(LoadTimetableWeek(
                          settings: settings,
                          weekStart: date.weekStart(),
                        ));
                      }

                      List<TimetableEntry> timetableEntries;
                      if (timetableState is TimetableLoaded && timetableState.timetable.containsKey(i)) {
                        timetableEntries = timetableState.timetable[i];
                      }

                      return TimetableWidget(
                        selectedDate: _selectedDate,
                        timetableEntries: timetableEntries,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  ListHeader(
                    text: ThTranslations.of(context).canteen,
                    trailing: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Text(ThTranslations.of(context).canteenAllergenes),
                          SizedBox(width: 4),
                          Icon(MdiIcons.arrowRight),
                        ],
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Additives())),
                    ),
                  ),
                  BlocBuilder<CanteenBloc, CanteenState>(
                    builder: (context, state) {
                      if (state is! CanteenLoaded || !(state as CanteenLoaded).canteen.containsKey(i)) {
                        BlocProvider.of<CanteenBloc>(context).add(LoadCanteenWeek(
                          firstDay: settings.semester.startDate,
                          weekStart: _selectedDate.weekStart(),
                        ));
                      }

                      if (state is CanteenLoaded) {
                        if (state.canteen.containsKey(i)) {
                          return CanteenWidget(
                            meals: state.canteen[i],
                          );
                        }
                      }

                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _onPageChanged(int newPage) {
    var date = _selectedDate;

    if (_lastPage < newPage) {
      var add = 1;
      if (date.weekday == DateTime.friday) add = 3;
      date = DateTime(date.year, date.month, date.day + add);
    } else if (_lastPage > newPage) {
      var sub = 1;
      if (date.weekday == DateTime.monday) sub = 3;
      date = DateTime(date.year, date.month, date.day - sub);
    }

    setState(() {
      _lastPage = newPage;
      _selectedDate = date;
    });
  }
}
