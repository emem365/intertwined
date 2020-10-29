import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';

class EditSnippet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TileColors.maximumYellowRed,
      appBar: AppBar(
        toolbarHeight: 72,
        title: TextFormField(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: 'Title',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: MainColors.richBlackFogra,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Next',
                    style: TextStyle(color: MainColors.richBlackFogra),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.top,
          maxLines: null,
          expands: true,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: 'Text',
          ),
        ),
      ),
    );
  }
}
