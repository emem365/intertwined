import 'package:flutter/material.dart';
import 'package:send_to/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        color: MainColors.fieryRoseMaterialColor.shade800,
        borderRadius: BorderRadius.circular(24.0),
        currentIndex: _currentIndex,
        onTap: (value)=>setState(()=>_currentIndex = value),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            title: Text('Text'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final Color color;
  final int currentIndex;
  final void Function(int) onTap;
  final BorderRadius borderRadius;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final List<BottomNavigationBarItem> items;

  CustomNavBar({
    this.color,
    this.currentIndex,
    this.onTap,
    this.borderRadius,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 0,
          bottom: 16,
        ),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 6.0,
          color: color ?? Theme.of(context).primaryColorDark,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: currentIndex,
              onTap: onTap,
              unselectedItemColor: unselectedItemColor,
              selectedItemColor: selectedItemColor,
              items: items,
            ),
          ),
        ),
      ),
    );
  }
}
// MainColors.fieryRoseMaterialColor[300]
// MainColors.lavendarBlush