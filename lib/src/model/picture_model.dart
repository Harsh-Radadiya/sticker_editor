class PictureModel {
  String stringUrl;
  double top;
  bool isSelected;
  double angle;

  /// Scale image
  double scale;
  // This is your Image link type
  bool isNetwork;
  double left;

  PictureModel(
      {required this.stringUrl,
      required this.top,
      required this.isSelected,
      this.angle = 0,
      required this.scale,
      required this.isNetwork,
      required this.left});
}
