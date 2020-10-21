import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/view/widgets/app_drawer.dart';
import 'package:intertwined/src/view/widgets/custom_nav_bar.dart';
import 'package:intertwined/src/view/widgets/transparent_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: TransparentAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: TileColors.celeste,
              child: ListTile(
                title: Text('ABC'),
                subtitle: Text('abc'),
              ),
            ),
            TextButton(
                child: Text('Flutter'),
                onPressed: () {},
                style: TextButton.styleFrom(side: BorderSide())),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      bottomNavigationBar: buildNavBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildNavBar(BuildContext context) => CustomNavBarWrapper(
        color: MainColors.fieryRoseMaterialColor.shade800,
        borderRadius: BorderRadius.circular(24.0),
        navBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: _currentIndex,
          onTap: (value) => setState(() => _currentIndex = value),
          unselectedItemColor: MainColors.fieryRoseMaterialColor.shade300,
          selectedItemColor: MainColors.lavendarBlush,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cached),
              title: Text('Text'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cached),
              title: Text('Text'),
            ),
          ],
        ),
      );
}

