import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testwindows/question.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setMinWindowSize(const Size(400, 400));
    DesktopWindow.setMaxWindowSize(const Size(800, 800));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        question: Question(
          "МОЙ ВАПРОС",
          [
            Answer(title: "TITLE"),
            Answer(title: "TITLE2"),
            Answer(title: "TITLE3", isRight: true),
            Answer(title: "TITLE4"),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.question,
    Key? key,
  }) : super(key: key);

  final Question question;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? value;

  late String title;

  @override
  void initState() {
    title = widget.question.question;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Далее'),
        ),
        onPressed: () {
          setState(() => title = "Чем я тут занимаюсь...");
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                widget.question.question,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: widget.question.answers
                    .map(
                      (e) => RadioListTile<String>(
                        title: Text(e.title),
                        value: e.title,
                        groupValue: value,
                        onChanged: (String? newValue) {
                          if (newValue == null) return;
                          if (newValue == value) return;
                          setState(() => value = newValue);
                          if (newValue == e.title && e.isRight) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('ПРАВИЛЬНЫЙ ОТВЕЕЕТ!'),
                            ));
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
