import 'package:example/values/theme.dart';
import 'package:flutter/material.dart';

import 'TabItem.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.elliptical(50, 55),
        topLeft: Radius.elliptical(50, 55),
      ),
      child: BottomNavigationBar(
        backgroundColor: cardBlue,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.newFortune),
          _buildItem(TabItem.profile)
        ],
        onTap: (index) => onSelectTab(
          TabItem.values[index],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        _iconTabMatching(tabItem),
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  MaterialColor? _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }

    IconData? _iconTabMatching(TabItem item) {
      return tabIcon[item];
  }

}
