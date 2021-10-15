import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'Model/picture_model.dart';

class StickerEditingBox extends StatefulWidget {
  double width;
  double height;
  PictureModel pictureModel;
  StickerEditingBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.pictureModel})
      : super(key: key);

  @override
  _StickerEditingBoxState createState() => _StickerEditingBoxState();
}

class _StickerEditingBoxState extends State<StickerEditingBox> {
  double x1 = 50;
  double y1 = 50;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.pictureModel.top,
      left: widget.pictureModel.left,
      child: Transform.scale(
        scale: widget.pictureModel.scale,
        child: GestureDetector(
          onPanStart: (tap) {
            setState(() {
              x1 = widget.pictureModel.left;
              y1 = widget.pictureModel.top;
            });
          },
          onPanUpdate: (tap) {
            setState(() {
              print(widget.width);
              print(x1 + tap.delta.dx);
              if ((x1 + tap.delta.dx) < widget.width &&
                  (x1 + tap.delta.dx > 0)) {
                x1 += tap.delta.dx;
                widget.pictureModel.left = x1;
              }

              if ((y1 + tap.delta.dy) > 0 &&
                  (y1 + tap.delta.dy) < widget.height) {
                y1 += tap.delta.dy;
                widget.pictureModel.top = y1;
              }
            });
          },
          onTap: () {
            if (widget.pictureModel.isSelected) {
              setState(() {
                widget.pictureModel.isSelected = false;
              });
            } else {
              setState(() {
                widget.pictureModel.isSelected = true;
              });
            }
            // print(widget.pictureModel.stringUrl);
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: DottedBorder(
                    color: widget.pictureModel.isSelected
                        ? Colors.grey[600]!
                        : Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: widget.pictureModel.isNetwork
                        ? Image.network(
                            widget.pictureModel.stringUrl,
                            height: 50,
                            width: 50,
                          )
                        : Image.asset(
                            widget.pictureModel.stringUrl,
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
                    widget.pictureModel.isSelected = false;
                  },
                  child: widget.pictureModel.isSelected
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
                    if (tap.delta.dx.isNegative &&
                        widget.pictureModel.scale > .5) {
                      setState(() {
                        widget.pictureModel.scale -= 0.05;
                      });
                    } else if (!tap.delta.dx.isNegative &&
                        widget.pictureModel.scale < 5) {
                      setState(() {
                        widget.pictureModel.scale += 0.05;
                      });
                    }
                  },
                  child: widget.pictureModel.isSelected
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
}
