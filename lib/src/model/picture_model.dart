class PictureModel {
  String stringUrl;
  double top;
  bool isSelected;
  /// 
  double scale;
  // This is your Image link type
  bool isNetwork;
  double left;

  PictureModel(
      {required this.stringUrl,
      required this.top,
      required this.isSelected,
      required this.scale,
      required this.isNetwork,
      required this.left});
}
