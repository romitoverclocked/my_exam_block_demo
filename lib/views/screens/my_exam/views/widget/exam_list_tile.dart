import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/base_url_resource.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/my_exam_data_model.dart';
import 'package:my_exam_block_demo/views/widgets/custom_button.dart';

class ExamListTile extends StatelessWidget {
  ExamListTile({super.key, required this.examData});

  Datum? examData;
  String month = '';

  @override
  Widget build(BuildContext context) {
    String reviewStatus =
        examData?.reviewStatus?.toString().substring(13).toLowerCase() ?? "";
    print(reviewStatus);
    int mon = examData?.createdAt?.month ?? 1;
    switch (mon) {
      case 01:
        month = "january";
        break;
      case 2:
        month = "february";
        break;
      case 3:
        month = "march";
        break;
      case 4:
        month = "april";
        break;
      case 5:
        month = "may";
        break;
      case 6:
        month = "june";
        break;
      case 7:
        month = "july";
        break;
      case 8:
        month = "august";
        break;
      case 9:
        month = "september";
        break;
      case 10:
        month = "october";
        break;
      case 11:
        month = "november";
        break;
      case 12:
        month = "december";
        break;
    }
    return Row(
      children: [
        Container(
          height: 55.h,
          width: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLQ5avukuwL9udUfrB95TjGJ8NDuf4e43DcQ&usqp=CAU',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: reviewStatus == 'submitted' || reviewStatus == 'draft'
                      ? 90.w
                      : 180.w,
                  child: Text(
                    examData?.examName ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                reviewStatus == 'submitted' || reviewStatus == 'draft'
                    ? Container(
                        height: 15.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: reviewStatus == 'submitted'
                              ? ColorResource.green
                              : ColorResource.darkRed,
                          borderRadius: BorderRadius.all(
                            Radius.circular(101),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          reviewStatus == 'draft' ? 'In Draft' : 'Submitted',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(),
                reviewStatus == 'submitted' || reviewStatus == 'draft'
                    ? SizedBox(
                        width: 10.w,
                      )
                    : SizedBox(),
                reviewStatus == 'submitted' || reviewStatus == 'draft'
                    ? Image.asset(
                        height: 20.h,
                        width: 20.h,
                        'assets/images/verified_png_image.avif')
                    : SizedBox(),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
                '$month ${examData?.createdAt?.day},${examData?.createdAt?.year} • ${examData?.counts} Scans'),
          ],
        ),
        Spacer(),
        CustomIconButton(
          radius: 20,
          icnSize: 20,
          icon: Icons.arrow_forward_ios_rounded,
          onTap: () {},
        )
      ],
    );
  }
}
