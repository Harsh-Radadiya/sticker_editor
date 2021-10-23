# Sticker Editor
A flutter plugin for iOS, Android and Mac for Rotate, Scaling, Moving and Editing Text, Photo, Stickers

![](https://github.com/Harsh-Radadiya/sticker_editor/raw/master/assets/readme/demo.gif)

<br>

| Sticker Editor                                                                                     |                                                                                                       |
| -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| ![](https://github.com/Harsh-Radadiya/sticker_editor/raw/master/assets/readme/text_editor_box.png) | ![](https://github.com/Harsh-Radadiya/sticker_editor/raw/master/assets/readme/sticker_editor_box.png) |

<br>

<br>

| Only Text                                                                                    | Only Photo                                                                                      |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![](https://github.com/Harsh-Radadiya/sticker_editor/raw/master/assets/readme/only_text.png) | ![](https://github.com/Harsh-Radadiya/sticker_editor/raw/master/assets/readme/only_picture.png) |

<br>
 

A flutter package Sticker Editor which will help you to create editable and scalable text or sticker widget that can be dragged around the area you given in screen.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Features 💚

- Manually Control the position of the widget along with drags.
- You can bound the dragarea of your widget using boundHeight and boundWidth parameters
- onTap and onCancel function where user's can use there own function
- You can resizes widget using scaling function
- Highly customizable
- You can use whole sticker view or particular widgets
## Installation

First, add `stickereditor` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

### MacOs
Fore NetworkImage, macOS needs you to request a specific entitlement in order to access the network. To do that open macos/Runner/DebugProfile.entitlements and add the following key-value pair.
```xml
<key>com.apple.security.network.client</key>
<true/>
```
## How to use
- Sticker View 
```Dart
StickerEditingView(
  isnetwork: false,
  height: 300,
  width: 300,
  imgUrl: backgroundImageUrl,
  fonts: fonts,
  palletColor: colorPallet,
  assetList: stickerList,
),
```

- Text Editing Box
```Dart
Container(
  height: 300,
  width: 300,
  color: Colors.blue,
  child: Stack(
    children: [
      TextEditingBox(
        fonts: fonts,
        boundHeight: 200,
        boundWidth: 100,
        isSelected: true,
        palletColor: colorPallet,
        newText: TextModel(
            name: 'Text EditingBox',
            textStyle:
                GoogleFonts.pacifico(fontSize: 25, color: Colwhite),
            top: top,
            isSelected: true,
            textAlign: TextAlign.center,
            scale: 1,
            left: left),
      ),
    ],
  ),
),
```
- Picture Editing Box
```Dart
Container(
  height: 300,
  width: 300,
  color: Colors.blue,
  child: Stack(
    children: [
      StickerEditingBox(
          boundHeight: 200,
          boundWidth: 200,
          pictureModel: PictureModel(
            isNetwork: true,
            isSelected: false,
            left: 50,
            top: 50,
            scale: 1,
            stringUrl:
                'https://raw.githubusercontent.com/Harsh-Radadiya/sticker_editor/master/assets/t-shirt.jpeg',
          )),
    ],
  ),
)
```

Run the example app in the exmaple folder to find out more about how to use it.
