import 'package:flutter/material.dart';
import 'package:intertwined/src/view/widgets/web_menu.dart';
import 'package:provider/provider.dart';

import '../files_page.dart';
import '../snippets_page.dart';
import '../images_page.dart';

class HomePageWeb extends StatefulWidget {
  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  int _currentIndex = 0;
  PageController pageController;
  @override
  void initState() {
    pageController = new PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  void onPageChanged(int newIndex) {
    pageController.animateToPage(newIndex,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: TransparentAppBar(title: getTitle()),
      body: Row(
        children: [
          Provider.value(
            value: _currentIndex,
            child: WebMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Pagetitle', style: Theme.of(context).textTheme.headline5,),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int newIndex) =>
                        setState(() => _currentIndex = newIndex),
                    physics: BouncingScrollPhysics(),
                    children: [
                      SnippetsPage(),
                      ImagesPage(),
                      FilesPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  String getTitle() {
    if (_currentIndex == 0)
      return 'Text Snippets';
    else if (_currentIndex == 1)
      return 'Images';
    else
      return 'Files';
  }
}
