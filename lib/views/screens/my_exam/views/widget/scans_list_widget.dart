import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/base_url_resource.dart';
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
  int selectedScan = 1;

  @override
  Widget build(BuildContext context) {
    if (isFromMyExam) {
      selectedScan = state.selectedMyExamScan;
    } else {
      selectedScan = state.selectedSharedWithMeScan;
    }
    return Container(
      color: ColorResource.appColor,
      width: double.infinity,
      height: 110.h,
      padding: EdgeInsets.only(top: 10.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onScanChange(state.allScans?.data?[index].id ?? 1);
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        selectedScan == state.allScans?.data?[index].id
                            ? ColorResource.appColor
                            : Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: CachedNetworkImage(
                        height: 30.h,
                        width: 30.w,
                        imageUrl:
                            '${BaseUrlResource.scanImageBaseUrl}${state.allScans?.data?[index].categoryImage ?? ""}',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  state.allScans?.data?[index].categoryName ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                selectedScan == state.allScans?.data?[index].id
                    ? Container(
                        height: 4.h,
                        width: 55.w,
                        color: Colors.white,
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 20.w,
          );
        },
        itemCount: state.allScans?.data?.length ?? 0,
      ),
    );
  }
}
