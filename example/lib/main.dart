import 'package:flutter/material.dart';
import 'package:stickereditor/Model/picture_model.dart';
import 'package:stickereditor/Model/text_model.dart';

import 'package:stickereditor/home_screen.dart';
import 'package:stickereditor/textbox_widget.dart';
import 'package:stickereditor/sticker_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(home: TextEditingBoxScreen());
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StickerEditor Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StickerEditingViewScreen()));
                },
                child: const Text('StickerEditingViewScreen')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TextEditingBoxScreen()));
                },
                child: const Text('TextEditingBox')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StickerEditingBoxScreen()));
                },
                child: const Text('StickerEditingBox'))
          ],
        ),
      ),
    );
  }
}

class StickerEditingViewScreen extends StatefulWidget {
  const StickerEditingViewScreen({Key? key}) : super(key: key);

  @override
  _StickerEditingViewScreenState createState() =>
      _StickerEditingViewScreenState();
}

class _StickerEditingViewScreenState extends State<StickerEditingViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StickerEditingView'),
      ),
      body: const StickerEditingView(),
    );
  }
}

class TextEditingBoxScreen extends StatefulWidget {
  const TextEditingBoxScreen({Key? key}) : super(key: key);

  @override
  _TextEditingBoxScreenState createState() => _TextEditingBoxScreenState();
}

class _TextEditingBoxScreenState extends State<TextEditingBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Editing Box Demo')),
      body: Stack(
        children: [
          TextEditingBox(
            height: 500,
            width: 500,
            newText: TextModel(
                name: 'Text EditingBox',
                textStyle: const TextStyle(),
                top: 50,
                key: 'uniq_key',
                isSelected: false,
                textAlign: TextAlign.center,
                scale: 1,
                left: 100),
          ),
        ],
      ),
    );
  }
}

class StickerEditingBoxScreen extends StatefulWidget {
  const StickerEditingBoxScreen({Key? key}) : super(key: key);

  @override
  _StickerEditingBoxScreenState createState() =>
      _StickerEditingBoxScreenState();
}

class _StickerEditingBoxScreenState extends State<StickerEditingBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticker EditingBox Demo '),
      ),
      body: Stack(
        children: [
          StickerEditingBox(
              height: 500,
              width: 500,
              pictureModel: PictureModel(
                  isNetwork: true,
                  isSelected: false,
                  left: 50,
                  top: 50,
                  scale: 1,
                  stringUrl:
                      'https://thumbs.dreamstime.com/z/lime-green-t-shirt-template-invisible-mannequin-lime-green-t-shirt-template-invisible-mannequin-isolated-white-223084157.jpg',
                  key: 'uniq_key')),
        ],
      ),
    );
  }
}
