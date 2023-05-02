import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/simple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DiscussionAddPage extends GeneralPage {
  final String filmId;
  const DiscussionAddPage(this.filmId, {super.key});

  @override
  State<StatefulWidget> createState() => DiscussionAddPageState();
}

class DiscussionAddPageState extends GeneralPageState<DiscussionAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      const Text(
        "Title:",
        textScaleFactor: 1.5,
      ),
      TextField(
        controller: _titleController,
        maxLines: 1,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: "Enter your title..."),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      const Text(
        "Body:",
        textScaleFactor: 1.5,
      ),
      TextField(
        controller: _bodyController,
        maxLines: null,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your content here..."),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Consumer<DiscussionProvider>(
          builder: (context, provider, _) => TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0XFF2C666E))),
              onPressed: () {
                if(_titleController.text == ''){
                  showDialog(context: context, builder: (context){
                    return const GenericDialog(title: "Error:",content: "You can't have an empty title");
                  });
                  return;
                }
                if(_bodyController.text == ''){
                  showDialog(context: context, builder: (context){
                    return const GenericDialog(title: "Error:",content: "You can't have an empty body");
                  });
                  return;     
                }
                provider
                    .addNewDiscussion(Discussion(
                        '',
                        widget.filmId,
                        _titleController.text,
                        _bodyController.text,
                        Profile(),
                        DateTime.now(), []))
                    .then((value) => Navigator.of(context).pop());
              },
              child: const Text("Start your discussion")))
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        iconSize: 40,
      ),
      const SizedBox(width: 10),
      const Text(
        "Add Discussion",
        textAlign: TextAlign.left,
        textScaleFactor: 2.2,
      ),
    ]);
  }
}
