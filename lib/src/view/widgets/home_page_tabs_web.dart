import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/home_page_tabs.dart';
import 'package:intertwined/src/view/widgets/neumorphic_container.dart';

class HomePageTabsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphicContainer(
        backgroundColor: MainColors.lavendarBlush,
        color: MainColors.fieryRose,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(homePageTabs.length, (index) => ListTile(
                leading: Icon(homePageTabs[index].tabIcon),
                title: Text(homePageTabs[index].tabName,
                    style: TextStyle(color: Colors.black)),
              ),),
            
          ),
        ),
      ),
    );
  }
}
