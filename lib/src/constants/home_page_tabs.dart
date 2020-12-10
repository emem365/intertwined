import 'package:flutter/material.dart';
import 'package:intertwined/src/model/page_tab.dart';

const List<PageTab> homePageTabs = <PageTab>[
  PageTab(
    tabIcon: Icons.text_snippet,
    tabName: 'Text Snippets',
  ),
  PageTab(
    tabIcon: Icons.image,
    tabName: 'Images',
  ),
  PageTab(
    tabIcon: Icons.upload_file,
    tabName: 'Files',
  ),
];
