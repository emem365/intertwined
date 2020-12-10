import 'package:flutter/material.dart';
import 'package:intertwined/src/view/pages/home_page/home_page_mobile.dart';
import 'package:intertwined/src/view/pages/home_page/home_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: HomePageWeb(),
      mobile: HomePageMobile(),
    );
  }
}

