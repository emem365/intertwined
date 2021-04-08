import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/utils.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/db/database.dart';
import 'package:intertwined/src/model/text_snippets.dart';
import 'package:intertwined/src/view/widgets/loading_banner.dart';
import 'package:provider/provider.dart';

class EditSnippet extends StatefulWidget {
  final TextSnippet snippet;
  EditSnippet(this.snippet);

  @override
  _EditSnippetState createState() => _EditSnippetState();
}

class _EditSnippetState extends State<EditSnippet> {
  TextEditingController? _titleController;
  TextEditingController? _bodyController;
  bool isLoading = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.snippet.title);
    _bodyController = TextEditingController(text: widget.snippet.content);
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      isLoading = true;
    });
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    widget.snippet.updateSnippet(_titleController!.text, _bodyController!.text);
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    await databaseService.updateTextSnippet(user, widget.snippet);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await saveData();
        return true;
      },
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: TileColors.fromCode(widget.snippet.colorCode),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 72,
            title: TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: "No Title"),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              TextButton.icon(
                icon: Icon(
                  Icons.check,
                  color: MainColors.richBlackFogra,
                ),
                label: Text(
                  'Next',
                  style: TextStyle(color: MainColors.richBlackFogra),
                ),
                onPressed: () async {
                  await saveData();
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                widget.snippet.lastUpdated == null
                    ? 'Newly Created'
                    : 'Last updated: ${Utils.formatDateTime(widget.snippet.lastUpdated ?? DateTime.now())}',
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _bodyController,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Text',
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController?.dispose();
    _bodyController?.dispose();
    super.dispose();
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  LoadingOverlay({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) LoadingBanner(),
      ],
    );
  }
}

// TODO: Move Loading Overlay tpo new file
// TODO: Create a controller for this class
// TODO: Add dialog box onWillPop
