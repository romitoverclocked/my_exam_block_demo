import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_resource.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.btnColor = Colors.black,
    this.titleColor = Colors.white,
  });

  String? title;
  Color? btnColor;

  Color? titleColor;

  double? height;
  double? width;

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(
          title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {super.key,
      required this.icon,
      required this.onTap,
      this.radius,
      this.icnSize,
      this.iconColor});

  double? radius;
  double? icnSize;
  Color? iconColor;

  IconData icon;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius ?? 25,
        backgroundColor: ColorResource.lightBlue,
        child: Icon(
          icon,
          size: icnSize ?? 30,
          color: iconColor ?? Colors.black,
        ),
      ),
    );
  }
}
