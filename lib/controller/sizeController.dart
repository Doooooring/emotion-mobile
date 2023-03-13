import "package:flutter/material.dart";

double scaleWidth(BuildContext context, int width) {
  const designGuideWidth = 360;
  final diff = MediaQuery.of(context).size.width / designGuideWidth;

  return width * diff;
}

double scaleHeight(BuildContext context, int height) {
  const designGuideHeight = 800;
  final diff = MediaQuery.of(context).size.height / designGuideHeight;

  return height * diff;
}
