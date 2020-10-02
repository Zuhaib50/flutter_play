import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../ui-elemnts/tab_bar.dart';
import '../pages/home/sub_tab_home.dart';
import 'package:flutter_play/models/page.dart';

List<Pages> _allPages = <Pages>[
  Pages(icon: Icons.explore, text: 'For You', category: 'category-name'),
  Pages(
      icon: Icons.insert_chart, text: 'Top Charts', category: 'category-name'),
  Pages(icon: Icons.category, text: 'Categories', category: 'category-name'),
  Pages(icon: Icons.stars, text: 'Editor\'s Choice', category: 'category-name'),
  Pages(icon: Icons.wb_sunny, text: 'Family', category: 'category-name'),
  Pages(
      icon: Icons.directions_bus,
      text: 'Early Access',
      category: 'category-name'),
];

class HomeTab extends StatefulWidget {
  HomeTab({this.scrollController});

  final ScrollController scrollController;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  TabController _controller;

  Key _key = new PageStorageKey({});
  double _offset = 0.0;
  double _newOffset = 0.0;

  void _scrollListener() {
    if (widget.scrollController.position.extentAfter == 0.0) {
      _newOffset = 25.0;
      if (Platform.isIOS) {
        _newOffset = 35.0;
      }
    } else {
      _newOffset = 0.0;
    }
    setState(() {
      _offset = _newOffset;
    });
  }

  @override
  void initState() {
    _controller = new TabController(vsync: this, length: _allPages.length);
    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget build(BuildContext context) {
    final List<Widget> tabChildernPages = <Widget>[];
    _allPages.forEach((Pages page) => tabChildernPages.add(HomeSubTab()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: _offset),
          decoration: BoxDecoration(color: Colors.green),
        ),
        TabBarWidget(_controller, _allPages),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: TabBarView(
              key: _key,
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: tabChildernPages,
            ),
          ),
        ),
      ],
    );
  }
}
