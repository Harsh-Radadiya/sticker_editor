import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stickereditor/Constants/constants_value.dart';
import 'package:stickereditor/Model/picture_model.dart';
import 'package:stickereditor/Model/text_model.dart';
import 'package:stickereditor/Widgets/custom_widget.dart';

class StickerEditingView extends StatefulWidget {
  const StickerEditingView({Key? key}) : super(key: key);

  @override
  _StickerEditingViewState createState() => _StickerEditingViewState();
}

class _StickerEditingViewState extends State<StickerEditingView> {
  // image source
  String backgroundImage = 'assets/t-shirt.jpeg';
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile;
  String fileName = '';
  String imagePath = '';
  File? file;

  // offset
  double x = 120.0;
  double y = 160.0;
  double x1 = 100.0;
  double y1 = 50.0;

  // selected text perameter
  double selectedFontSize = 18;
  TextStyle selectedTextstyle =
      const TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Lato");
  // TextStyle defaultTextstyle =
  //     const TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Lato");
  // TextAlign defaultTextAlign = TextAlign.left;
  String selectedFont = "Lato";
  TextAlign selectedtextAlign = TextAlign.left;
  int selectedTextIndex = -1;
  String selectedtextToShare = "Happy ${weekDays[today - 1]}!";

  // pop up menu
  // RxBool isStickerList = false.obs;

  // new String and Image List
  RxList<TextModel> newStringList = <TextModel>[].obs;
  RxList<PictureModel> newimageList = <PictureModel>[].obs;
  final List<String> stickerList = <String>[];

  // genearting Image
  bool showProgressOnGenerate = false;

  @override
  void initState() {
    initialiseStickerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // new widget _layputs and ..
    List<Widget> _fontList =
        fonts.map<Widget>((fontFamily) => _fontView(fontFamily)).toList();
    List<Widget> _fontSizes = constFontSizeList.map<Widget>((elementFontSize) {
      return Container(
          margin: const EdgeInsets.all(8),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  newStringList[selectedTextIndex].textStyle = TextStyle(
                      fontSize: elementFontSize,
                      fontFamily: selectedFont,
                      color: Colors.black);

                  selectedFontSize = elementFontSize;
                  selectedTextstyle = TextStyle(
                      fontSize: elementFontSize,
                      fontFamily: selectedFont,
                      color: Colors.black);
                });
              },
              child: Container(
                // margin: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                    border: selectedFontSize == elementFontSize
                        ? Border.all(width: 2, color: Colors.grey[800]!)
                        : Border.all(color: Colors.transparent)),

                alignment: Alignment.center,
                child: Text(
                  "A",
                  style: TextStyle(
                      fontSize: elementFontSize > 30 ? 30 : elementFontSize,
                      color: Colors.black),
                ),
              )));
    }).toList();

    List<Widget> _textAlignments = constTextAlignMent.map<Widget>((align) {
      return Container(
          margin: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                newStringList[selectedTextIndex].textAlign = align;

                selectedtextAlign = align;
              });
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                    border: selectedtextAlign == align
                        ? Border.all(
                            width: 2,
                            color: Colors.blue[800]!,
                          )
                        : Border.all(color: Colors.transparent)),
                child: Icon(
                  align == TextAlign.left
                      ? Icons.format_align_left
                      : align == TextAlign.center
                          ? Icons.format_align_center
                          : Icons.format_align_right,
                  color: Colors.white,
                  size: 20,
                )),
          ));
    }).toList();

    List<Widget> _coloreText = colorList.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            newStringList[selectedTextIndex].textStyle = TextStyle(
                fontFamily: selectedFont, fontSize: selectedFontSize, color: e);
          });
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: e,
              shape: BoxShape.circle,
              border: newStringList.isEmpty || selectedTextIndex == -1
                  ? Border.all(color: Colors.black, width: 3)
                  : newStringList[selectedTextIndex].textStyle.color == e
                      ? Border.all(color: Colors.black, width: 3)
                      : Border.all(
                          color: Colors.blue[800]!,
                        )),
        ),
      );
    }).toList();

    return Scaffold(
        body: Obx(() => Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top: height * .14,
                  left: width * .11,
                  child: Screenshot(
                    controller: screenshotController,
                    child: SizedBox(
                      height: height * .40,
                      width: width * .78,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/t-shirt.jpeg',
                            package: 'stickereditor',
                            height: height * .40,
                            width: width * .78,
                          ),
                          ...newStringList.map((v) {
                            return lyricsText(
                                width: width * .78 - width * .20,
                                height: height * .40 - height * .07,
                                newText: v);
                          }).toList(),
                          ...newimageList.map((v) {
                            return pictureStickers(
                                width: width * .70,
                                height: height * .30,
                                pictureModel: v);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomeWidgets.customButton(
                          btnName: 'Add Text',
                          onPressed: () async {
                            await showEditBox(context: context, isNew: true);
                          },
                        ),
                        CustomeWidgets.customButton(
                          btnName: 'Add Stickers',
                          onPressed: () {
                            selectedTextIndex = -1;

                            stickerWidget(context);
                          },
                        ),
                        CustomeWidgets.customButton(
                          btnName: 'Generate',
                          onPressed: () async {
                            for (var e in newStringList) {
                              e.isSelected = false;
                            }
                            for (var e in newimageList) {
                              e.isSelected = false;
                            }

                            setState(() {});
                            imagePath = '';

                            imagePath = (await getExternalStorageDirectory())!
                                .path
                                .trim(); //from path_provide package

                            Random().nextInt(15000);
                            fileName = '${Random().nextInt(15000)}.png';

                            print(imagePath);

                            await screenshotController.captureAndSave(
                                imagePath, //set path where screenshot will be saved
                                fileName: fileName);
                            file = await File('$imagePath/$fileName')
                                .create(recursive: true);

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                _previewDownloadedImage(),
                // isStickerList.value
                //     ? Positioned(
                //         left: 0, bottom: 0, child: stickerWidget(context))
                //     : Container(),
                selectedTextIndex == -1
                    ? Container()
                    : Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          height: height * .25,
                          width: width,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Fontstyle : '),
                                        ..._fontList
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('FontSize : '),
                                        ..._fontSizes,
                                        ..._textAlignments
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Colors :     '),
                                        ..._coloreText
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        )),
                showProgressOnGenerate
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column()
              ],
            )));
  }

  //preview Image
  Widget _previewDownloadedImage() {
    return imagePath != ''
        ? Positioned(
            bottom: 10,
            left: 5,
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(0.3, 0.6))
                      ],
                      image: DecorationImage(
                          // image: FileImage(File('$imagePath/$fileName')),
                          image: FileImage(file!),
                          fit: BoxFit.cover)),
                ),
                InkWell(
                    onTap: () {
                      imagePath = '';
                      setState(() {});
                    },
                    child: const Icon(Icons.cancel)),
              ],
            ))
        : Container();
  }

  // Sticker widget
  Future stickerWidget(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    selectedTextIndex = -1;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Material(
            elevation: 15,
            child: SizedBox(
              height: height * .4,
              width: width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: stickerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        for (var e in newimageList) {
                          e.isSelected = false;
                        }
                        for (var e in newStringList) {
                          e.isSelected = false;
                        }

                        newimageList.add(PictureModel(
                            isNetwork: false,
                            stringUrl: stickerList[index],
                            top: y1 + 10 < 300 ? y1 + 10 : 300,
                            key: DateTime.now().toString(),
                            isSelected: true,
                            scale: 1,
                            left: x1 + 10 < 300 ? x1 + 10 : 300));
                        x1 = x1 + 10 < 200 ? x1 + 10 : 200;
                        y1 = y1 + 10 < 200 ? y1 + 10 : 200;
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Image.asset(
                        stickerList[index],
                        package: 'stickereditor',
                        height: 50,
                        width: 50,
                      ),
                    );
                  }),
            ),
          );
        });
  }

  // Text widget
  Widget lyricsText(
      {required double width,
      required double height,
      required TextModel newText}) {
    // scale
    return Positioned(
      top: newText.top,
      left: newText.left,
      child: Transform.scale(
        scale: newText.scale,
        child: GestureDetector(
            onPanStart: (tap) {
              setState(() {
                x = newText.left;
                y = newText.top;
              });
            },
            onPanUpdate: (tap) {
              setState(() {
                if ((x + tap.delta.dx) < width && (x + tap.delta.dx > 0)) {
                  x += tap.delta.dx;
                  newText.left = x;
                }
                if ((y + tap.delta.dy) < height && (y + tap.delta.dy > 0)) {
                  y += tap.delta.dy;
                  newText.top = y;
                }
              });
            },
            onTap: () {
              if (newText.isSelected) {
                setState(() {
                  newText.isSelected = false;
                  selectedTextIndex = -1;
                });
              } else {
                setState(() {
                  selectedTextIndex = newStringList
                      .indexWhere((element) => element.key == newText.key);
                  for (var e in newStringList) {
                    e.isSelected = false;
                  }
                  for (var e in newimageList) {
                    e.isSelected = false;
                  }
                  newText.isSelected = true;

                  x = newText.left;
                  y = newText.top;
                  selectedTextstyle = newText.textStyle;
                  selectedFont = newText.textStyle.fontFamily!;
                  selectedFontSize = newText.textStyle.fontSize!;
                  selectedtextToShare = newText.name;
                });
              }

              print(newText.name);
            },
            onDoubleTap: () async {
              setState(() {
                x = newText.left;
                y = newText.top;
                selectedTextstyle = newText.textStyle;
                selectedFont = newText.textStyle.fontFamily!;
                selectedFontSize = newText.textStyle.fontSize!;
                selectedtextToShare = newText.name;
              });
              await showEditBox(
                  context: context, textModel: newText, isNew: false);
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DottedBorder(
                    color: newText.isSelected
                        ? Colors.grey[600]!
                        : Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      newText.name,
                      style: newText.textStyle,
                      textAlign: newText.textAlign,
                      // textScaleFactor: _scaleFactor,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      int index = newStringList
                          .indexWhere((element) => element.key == newText.key);
                      newStringList.removeAt(index);
                      selectedTextIndex = -1;
                      setState(() {});
                    },
                    child: newText.isSelected
                        ? Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.black,
                              size: 18,
                            ),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        x = newText.left;
                        y = newText.top;
                        selectedTextstyle = newText.textStyle;
                        selectedFont = newText.textStyle.fontFamily!;
                        selectedFontSize = newText.textStyle.fontSize!;
                        selectedtextToShare = newText.name;
                      });
                      await showEditBox(
                          context: context, textModel: newText, isNew: false);
                    },
                    child: newText.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 12,
                            ),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onPanUpdate: (tap) {
                      if (tap.delta.dx.isNegative && newText.scale > .8) {
                        setState(() {
                          newText.scale -= 0.05;
                        });
                      } else if (!tap.delta.dx.isNegative &&
                          newText.scale < 5) {
                        setState(() {
                          newText.scale += 0.05;
                        });
                      }
                    },
                    child: newText.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.crop,
                              color: Colors.black,
                              size: 12,
                            ),
                          )
                        : Container(),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // Text edit dailog box
  Future showEditBox(
      {BuildContext? context, TextModel? textModel, required bool isNew}) {
    int index = isNew
        ? -1
        : newStringList.indexWhere((element) => element.key == textModel!.key);
    return showDialog(
        context: context!,
        builder: (context) {
          final dailogTextController =
              TextEditingController(text: selectedtextToShare);

          return AlertDialog(
            backgroundColor: const Color.fromARGB(240, 200, 200, 200),
            title: Text(isNew ? 'Add New Text' : 'Edit Text'),
            content: TextField(
              controller: dailogTextController,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              decoration: InputDecoration(hintText: selectedtextToShare),
              // onChanged: (newVal) {},
            ),
            actions: [
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  if (isNew) {
                    setState(() {
                      for (var e in newStringList) {
                        e.isSelected = false;
                      }
                      for (var e in newimageList) {
                        e.isSelected = false;
                      }
                      newStringList.add(TextModel(
                          name: dailogTextController.text,
                          textStyle: selectedTextstyle,
                          top: y + 10,
                          left: x + 10,
                          scale: 1,
                          textAlign: TextAlign.left,
                          isSelected: true,
                          key: DateTime.now().toString()));
                      x = x + 10;
                      y = y + 10;
                      selectedTextIndex = newStringList.indexWhere(
                          (element) => element.key == newStringList.last.key);
                    });
                  } else {
                    setState(() {
                      selectedtextToShare = dailogTextController.text;
                      newStringList[index].name = dailogTextController.text;
                    });
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // picture widget
  Widget pictureStickers(
      {required double width,
      required double height,
      required PictureModel pictureModel}) {
    return Positioned(
      top: pictureModel.top,
      left: pictureModel.left,
      child: Transform.scale(
        scale: pictureModel.scale,
        child: GestureDetector(
          onPanStart: (tap) {
            setState(() {
              x1 = pictureModel.left;
              y1 = pictureModel.top;
            });
          },
          onPanUpdate: (tap) {
            setState(() {
              print(width);
              print(x1 + tap.delta.dx);
              if ((x1 + tap.delta.dx) < width && (x1 + tap.delta.dx > 0)) {
                x1 += tap.delta.dx;
                pictureModel.left = x1;
              }

              if ((y1 + tap.delta.dy) > 0 && (y1 + tap.delta.dy) < height) {
                y1 += tap.delta.dy;
                pictureModel.top = y1;
              }
            });
          },
          onTap: () {
            if (pictureModel.isSelected) {
              setState(() {
                pictureModel.isSelected = false;
              });
            } else {
              setState(() {
                for (var e in newStringList) {
                  e.isSelected = false;
                }
                for (var e in newimageList) {
                  e.isSelected = false;
                }
                selectedTextIndex = -1;
                pictureModel.isSelected = true;
              });
            }
            // print(pictureModel.stringUrl);
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: DottedBorder(
                    color: pictureModel.isSelected
                        ? Colors.grey[600]!
                        : Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: pictureModel.isNetwork
                        ? Image.network(
                            pictureModel.stringUrl,
                            height: 50,
                            width: 50,
                          )
                        : Image.asset(
                            pictureModel.stringUrl,
                            package: 'stickereditor',
                            height: 50,
                            width: 50,
                          )),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: InkWell(
                  onTap: () {
                    int index = newimageList.indexWhere(
                        (element) => element.key == pictureModel.key);
                    newimageList.removeAt(index);
                    setState(() {});
                  },
                  child: pictureModel.isSelected
                      ? Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.black,
                            size: 15,
                          ))
                      : Container(),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 3,
                child: GestureDetector(
                  onPanUpdate: (tap) {
                    if (tap.delta.dx.isNegative && pictureModel.scale > .5) {
                      setState(() {
                        pictureModel.scale -= 0.05;
                      });
                    } else if (!tap.delta.dx.isNegative &&
                        pictureModel.scale < 5) {
                      setState(() {
                        pictureModel.scale += 0.05;
                      });
                    }
                  },
                  child: pictureModel.isSelected
                      ? Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/scale.png',
                            package: 'stickereditor',
                            scale: 50,
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // fontview

  Widget _fontView(String fontFamily) {
    TextStyle font = TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        package: 'stickereditor',
        fontFamily: fontFamily);

    return GestureDetector(
      onTap: () {
        setState(() {
          newStringList[selectedTextIndex].textStyle = TextStyle(
            color: Colors.black,
            fontSize: selectedFontSize,
            fontFamily: fontFamily,
            package: 'stickereditor',
          );
          selectedFont = fontFamily;
          selectedTextstyle = TextStyle(
              color: newStringList[selectedTextIndex].textStyle.color,
              fontSize: selectedFontSize,
              package: 'stickereditor',
              fontFamily: fontFamily);
        });
      },
      child: selectedFont == fontFamily
          ? Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue[800]!, width: 2)),
              child: Text(
                'Aa',
                style: font,
              ),
            )
          : Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Aa',
                style: font,
              ),
            ),
    );
  }

  void initialiseStickerList() {
    for (var i = 0; i < 27; i++) {
      stickerList.add('assets/Stickers/$i.png');
    }
  }
}
