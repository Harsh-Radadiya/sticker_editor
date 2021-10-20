import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickereditor/src/model/picture_model.dart';

class StickerEditingBox extends StatefulWidget {
  final double boundWidth;
  final double boundHeight;
  final PictureModel pictureModel;
  final Function()? onCancel;

  const StickerEditingBox(
      {Key? key,
      required this.boundWidth,
      required this.boundHeight,
      required this.pictureModel,
      this.onCancel})
      : super(key: key);

  @override
  _StickerEditingBoxState createState() => _StickerEditingBoxState();
}

class _StickerEditingBoxState extends State<StickerEditingBox> {
  Offset deltaOffset = const Offset(0, 0);
  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.pictureModel.top,
      left: widget.pictureModel.left,
      child: Transform.scale(
        scale: widget.pictureModel.scale,
        child: Transform.rotate(
          angle: angle,
          child: GestureDetector(
            onScaleStart: (tap) {
              setState(() => deltaOffset = const Offset(0, 0));
            },
            onScaleUpdate: (tap) {
              setState(() {
                if (tap.pointerCount == 2) {
                  angle = tap.rotation;
                  widget.pictureModel.scale = tap.scale;
                }
                if ((widget.pictureModel.left +
                            tap.delta.dx -
                            deltaOffset.dx) <=
                        widget.boundWidth &&
                    (widget.pictureModel.left + tap.delta.dx - deltaOffset.dx) >
                        0) {
                  widget.pictureModel.left += tap.delta.dx - deltaOffset.dx;
                }
                if ((widget.pictureModel.top + tap.delta.dy - deltaOffset.dy) <
                        widget.boundHeight &&
                    (widget.pictureModel.top + tap.delta.dy - deltaOffset.dy) >
                        0) {
                  widget.pictureModel.top += tap.delta.dy - deltaOffset.dy;
                }

                deltaOffset = tap.delta;
              });
            },
            onTap: () {
              if (widget.pictureModel.isSelected) {
                setState(() => widget.pictureModel.isSelected = false);
              } else {
                setState(() => widget.pictureModel.isSelected = true);
              }
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
                        ? Image.network(widget.pictureModel.stringUrl,
                            height: 50, width: 50)
                        : Image.asset(widget.pictureModel.stringUrl,
                            height: 50, width: 50),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails d) {
                      setState(() => angle = d.delta.direction);
                    },
                    child: widget.pictureModel.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Icon(Icons.rotate_right,
                                color: Colors.black, size: 12),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: InkWell(
                    onTap: () {
                      if (widget.onCancel != null) {
                        widget.onCancel!();
                      }
                      setState(() => widget.pictureModel.isSelected = false);
                    },
                    child: widget.pictureModel.isSelected
                        ? Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Icon(Icons.cancel_outlined,
                                color: Colors.black, size: 18),
                          )
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
                          setState(() => widget.pictureModel.scale -= 0.05);
                        } else if (!tap.delta.dx.isNegative &&
                            widget.pictureModel.scale < 5) {
                          setState(() => widget.pictureModel.scale += 0.05);
                        }
                      },
                      child: widget.pictureModel.isSelected
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.crop,
                                  color: Colors.black, size: 12))
                          : Container()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
