import 'package:flutter/material.dart';

const List<String> weekDays = [
  "Monday",
  "Tuesday",
  "Wednusday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
var currentTime = DateTime.now().millisecondsSinceEpoch;
var today = DateTime.now().weekday;

const List<String> backgrounds = [
  "https://i.pinimg.com/originals/e5/f0/de/e5f0de6f7d0762cd08725ea9dfd7c487.png",
  "https://dotbadges.com/wp-content/uploads/2021/05/Stickerview1-152.webp",
  "https://images.unsplash.com/photo-1472552944129-b035e9ea3744",
  "https://images.unsplash.com/photo-1577283617116-cad711fc556d",
  "https://images.unsplash.com/photo-1577261041320-fc4ec1e6b2a2",
  "https://images.unsplash.com/photo-1577218545339-2506e153c843",
  "https://images.unsplash.com/photo-1577269330970-d4f24a498e2f",
  "https://images.unsplash.com/photo-1577318530987-f2f4b903ad37",
  "https://images.unsplash.com/photo-1577234231282-d5017c6ac8b4",
  "https://images.unsplash.com/photo-1577154881361-c957822c3a0c",
];

final List<String> fonts = [
  "Lato",
  "PoiretOne",
  "Monoton",
  "BungeeInline",
  "ConcertOne",
  "FrederickatheGreat",
  "Martel",
  "Vidaloka",
  'OpenSans',
  'Billabong',
  'GrandHotel',
  'Oswald',
  'Quicksand',
  'BeautifulPeople',
  'BeautyMountains',
  'BiteChocolate',
  'BlackberryJam',
  'BunchBlossoms',
  'CinderelaRegular',
  'Countryside',
  'Halimun',
  'LemonJelly',
  'QuiteMagicalRegular',
  'Tomatoes',
  'TropicalAsianDemoRegular',
  'VeganStyle',
];

final List<Color> colorList = [
  Colors.black,
  Colors.grey,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.pink,
  Colors.cyanAccent,
];

const List<double> constFontSizeList = [14, 18, 24, 30, 36, 48];
const List constFontWeightList = [
  FontWeight.bold,
  FontStyle.italic,
];
const List<TextAlign> constTextAlignMent = [
  TextAlign.left,
  TextAlign.center,
  TextAlign.right
];
