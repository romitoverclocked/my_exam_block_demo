import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_block.dart';
import 'package:my_exam_block_demo/views/widgets/custom_loader.dart';

import '../../../../../resources/color_resource.dart';
import '../../../../widgets/custom_button.dart';

class EmailSettingWidget extends StatefulWidget {
  const EmailSettingWidget({super.key});

  @override
  State<EmailSettingWidget> createState() => _EmailSettingWidgetState();
}

class _EmailSettingWidgetState extends State<EmailSettingWidget> {
  bool immediately = false;
  bool daily = false;
  bool weekly = false;
  bool load = false;
  String data = '';

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      loading: load,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            Row(
              children: [
                Text(
                  'Email Settings',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            _option('Immediately', () {
              immediately = !immediately;
              setState(() {});
            }, immediately),
            _option('Daily', () {
              daily = !daily;
              setState(() {});
            }, daily),
            _option('Weekly', () {
              weekly = !weekly;
              setState(() {});
            }, weekly),
            SizedBox(height: 270.h),
            CustomButton(
              title: 'Save',
              btnColor: ColorResource.appColor,
              onTap: () async {
                if (immediately) {
                  data = '$data immediately,';
                }
                if (daily) {
                  data = '$data daily,';
                }
                if (weekly) {
                  data = '$data weekly,';
                }
                if (data.isNotEmpty) {
                  load = true;
                  setState(() {});
                  MyExamBlock block = context.read<MyExamBlock>();
                  bool isDone = await block.onTapSave(data);
                  if (isDone) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: 70.h,
                          left: 40.w,
                          right: 40.w,
                        ),
                        duration:const Duration(
                          seconds: 2,
                        ),
                        content:
                            const Text('Email Settings Updated Successfully.'),
                      ),
                    );
                  }
                  load = false;
                  setState(() {});
                }
                data = '';
              },
              height: 40.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _option(String name, void Function() onTap, bool selected) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor:
                  selected ? ColorResource.orange : ColorResource.lightBlue,
              radius: 20,
              child: selected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : SizedBox(),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 18.sp),
          )
        ],
      ),
    );
  }
}
