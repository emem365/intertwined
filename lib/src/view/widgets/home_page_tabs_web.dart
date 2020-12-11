import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/home_page_tabs.dart';
import 'package:intertwined/src/view/widgets/neumorphic_container.dart';
import 'package:provider/provider.dart';

class HomePageTabsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    int _currentIndex = Provider.of<int>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphicContainer(
        backgroundColor: MainColors.lavendarBlush,
        color: MainColors.fieryRose,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              homePageTabs.length,
              (index) => ListTile(
                // TODO: Setup ontap for listTile
                onTap: (){
                  var msg = 'This feature has not yet been implemented. Please Try again later';
                  if(index==0) msg = 'You\'re on Snippets Page already';
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                  ));
                },
                leading: Icon(
                  homePageTabs[index].tabIcon,
                  color:
                      (_currentIndex == index) ? Colors.black : Colors.black54,
                ),
                title: Text(homePageTabs[index].tabName,
                    style: TextStyle(
                      color: (_currentIndex == index)
                          ? Colors.black
                          : Colors.black54,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
