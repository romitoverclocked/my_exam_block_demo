import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/widgets/custom_button.dart';

class TabSelectionWidget extends StatefulWidget {
  TabSelectionWidget({super.key, required this.tabIndex});

  void Function(int n) tabIndex;

  @override
  State<TabSelectionWidget> createState() => _TabSelectionWidgetState();
}

class _TabSelectionWidgetState extends State<TabSelectionWidget> {
  List<String> tabs = ['My Exam', 'Shared With Me', 'Email Settings'];
  bool myExam = true;
  bool sharedWithMe = false;
  bool emailSettings = false;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      margin: EdgeInsets.symmetric(vertical: 18.h),
      child: ListView.separated(
        padding: REdgeInsets.symmetric(horizontal: 15.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomButton(
            title: tabs[index],
            btnColor: selectedTab == index
                ? ColorResource.darkTeal
                : ColorResource.lightBlue,
            height: 25.h,
            titleColor: selectedTab == index ? Colors.white : Colors.black,
            onTap: () {
              selectedTab = index;

              widget.tabIndex(index);
              setState(() {});
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10.w,
          );
        },
        itemCount: tabs.length,
      ),
    );
  }
}
