import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/home_page_tabs.dart';
import 'package:intertwined/src/view/pages/files_page.dart';
import 'package:intertwined/src/view/pages/images_page.dart';
import 'package:intertwined/src/view/pages/snippets_page.dart';
import 'package:intertwined/src/view/widgets/add_snippet_button.dart';
import 'package:intertwined/src/view/widgets/app_drawer.dart';
import 'package:intertwined/src/view/widgets/custom_nav_bar.dart';
import 'package:intertwined/src/view/widgets/transparent_app_bar.dart';

class HomePageMobile extends StatefulWidget {
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int _currentIndex = 0;
  PageController? pageController;
  @override
  void initState() {
    pageController = new PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  void onPageChanged(int newIndex) {
    pageController?.animateToPage(newIndex,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: TransparentAppBar(title: getTitle()),
      body: PageView(
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
      bottomNavigationBar: buildNavBar(context),
      floatingActionButton: AddSnippetButton(),
    );
  }

  String getTitle() {
    return homePageTabs[_currentIndex].tabName;
  }

  Widget buildNavBar(BuildContext context) => CustomNavBarWrapper(
        color: MainColors.fieryRoseMaterialColor.shade800,
        borderRadius: BorderRadius.circular(24.0),
        navBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: _currentIndex,
          onTap: onPageChanged,
          unselectedItemColor: MainColors.fieryRoseMaterialColor.shade300,
          selectedItemColor: MainColors.lavendarBlush,
          items: List.generate(
            homePageTabs.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(homePageTabs[index].tabIcon),
              label: homePageTabs[index].tabName,
            ),
          ),
        ),
      );
}
