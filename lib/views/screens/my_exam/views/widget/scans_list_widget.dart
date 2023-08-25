import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';

class ScansListWidget extends StatelessWidget {
  ScansListWidget(
      {super.key,
      required this.state,
      required this.isFromMyExam,
      required this.onScanChange});

  bool isFromMyExam;
  MyExamState state;

  void Function(int n) onScanChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResource.appColor,
      width: double.infinity,
      height: 200.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column();
        },
        separatorBuilder: (context, index) {
          return SizedBox();
        },
        itemCount: state.allScans?.data?.length ?? 0,
      ),
    );
  }
}
