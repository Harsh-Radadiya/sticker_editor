// ignore_for_file: must_be_immutable
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickereditor/Constants/constants_value.dart';
import 'package:stickereditor/Model/text_model.dart';

class TextEditingBox extends StatefulWidget {
  double width;
  double height;
  TextModel newText;

  TextEditingBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.newText})
      : super(key: key);

  @override
  _TextEditingBoxState createState() => _TextEditingBoxState();
}

class _TextEditingBoxState extends State<TextEditingBox> {
  double x = 50;
  double y = 50;

  // selected text perameter
  double selectedFontSize = 18;
  TextStyle selectedTextstyle =
      const TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Lato");
  String selectedFont = "Lato";
  TextAlign selectedtextAlign = TextAlign.left;
  String selectedtextToShare = "Happy ${weekDays[today - 1]}!";

  @override
  void initState() {
    x = widget.newText.left;
    y = widget.newText.top;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.newText.top,
      left: widget.newText.left,
      child: Transform.scale(
        scale: widget.newText.scale,
        child: GestureDetector(
            onPanStart: (tap) {
              setState(() {
                x = widget.newText.left;
                y = widget.newText.top;
              });
            },
            onPanUpdate: (tap) {
              setState(() {
                if ((x + tap.delta.dx) < widget.width &&
                    (x + tap.delta.dx > 0)) {
                  x += tap.delta.dx;
                  widget.newText.left = x;
                }
                if ((y + tap.delta.dy) < widget.height &&
                    (y + tap.delta.dy > 0)) {
                  y += tap.delta.dy;
                  widget.newText.top = y;
                }
              });
            },
            onTap: () {
              if (widget.newText.isSelected) {
                setState(() {
                  widget.newText.isSelected = false;
                });
              } else {
                setState(() {
                  widget.newText.isSelected = true;

                  x = widget.newText.left;
                  y = widget.newText.top;
                  selectedTextstyle = widget.newText.textStyle;
                  selectedFont = widget.newText.textStyle.fontFamily ?? 'Lato';
                  selectedFontSize = widget.newText.textStyle.fontSize ?? 15;
                  selectedtextToShare = widget.newText.name;
                });
              }

              print(widget.newText.name);
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DottedBorder(
                    color: widget.newText.isSelected
                        ? Colors.grey[600]!
                        : Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      widget.newText.name,
                      style: widget.newText.textStyle,
                      textAlign: widget.newText.textAlign,
                      // textScaleFactor: _scaleFactor,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      widget.newText.isSelected = false;
                      setState(() {});
                    },
                    child: widget.newText.isSelected
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
                        x = widget.newText.left;
                        y = widget.newText.top;
                        selectedTextstyle = widget.newText.textStyle;
                        selectedFont =
                            widget.newText.textStyle.fontFamily ?? 'Lato';
                        selectedFontSize =
                            widget.newText.textStyle.fontSize ?? 15;
                        selectedtextToShare = widget.newText.name;
                      });
                      await showEditBox(
                        context: context,
                        textModel: widget.newText,
                      );
                    },
                    child: widget.newText.isSelected
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
                      if (tap.delta.dx.isNegative &&
                          widget.newText.scale > .8) {
                        setState(() {
                          widget.newText.scale -= 0.05;
                        });
                      } else if (!tap.delta.dx.isNegative &&
                          widget.newText.scale < 5) {
                        setState(() {
                          widget.newText.scale += 0.05;
                        });
                      }
                    },
                    child: widget.newText.isSelected
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
  Future showEditBox({BuildContext? context, TextModel? textModel}) {
    return showDialog(
        context: context!,
        builder: (context) {
          final dailogTextController =
              TextEditingController(text: selectedtextToShare);

          return AlertDialog(
            backgroundColor: const Color.fromARGB(240, 200, 200, 200),
            title: const Text('Edit Text'),
            content: TextField(
              controller: dailogTextController,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              decoration: InputDecoration(hintText: selectedtextToShare),
            ),
            actions: [
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  setState(() {
                    widget.newText.name = dailogTextController.text;
                  });

                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
