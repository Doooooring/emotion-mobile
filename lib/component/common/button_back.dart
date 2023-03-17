import "package:flutter/material.dart";
import "package:get/get.dart";

IconButton ButtonBack() {
  return IconButton(
      padding: EdgeInsets.zero, // 패딩 설정
      constraints: BoxConstraints(),
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back_ios));
}
