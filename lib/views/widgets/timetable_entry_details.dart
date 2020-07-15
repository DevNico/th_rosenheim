import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../model/splan/timetable_entry.dart';
import 'single_timetable_event_details.dart';

class TimetableEventDetails extends StatefulWidget {
  final DateTime selectedDate;
  final List<TimetableEntry> entries;

  TimetableEventDetails({
    @required this.selectedDate,
    @required this.entries,
  });

  @override
  _TimetableEventDetailsState createState() => _TimetableEventDetailsState();
}

class _TimetableEventDetailsState extends State<TimetableEventDetails>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _children;
  int _currentIndex;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _currentIndex = 0;
    _tabController = TabController(
      vsync: this,
      length: widget.entries.length,
      initialIndex: _currentIndex,
    );
    _children = widget.entries
        .map((event) => SingleTimetableEventDetails(event))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.entries.length > 1)
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: theme.accentColor,
            unselectedLabelColor: theme.primaryColor,
            indicator: MD2Indicator(
              indicatorHeight: 3,
              indicatorColor: theme.accentColor,
              indicatorSize: MD2IndicatorSize.normal,
            ),
            onTap: (_) {
              setState(() {});
            },
            tabs: widget.entries
                .map((e) => Tab(text: e.lectureShortName))
                .toList(),
          ),
        _children[_tabController.index],
      ],
    );
  }
}
