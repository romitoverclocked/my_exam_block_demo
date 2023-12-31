import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/first_page.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/second_page.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/third_page.dart';
import 'package:my_exam_block_demo/views/widgets/custom_loader.dart';
import 'package:toast/toast.dart';

import '../../../widgets/custom_button.dart';
import '../models/item_type_model.dart';

class NewExamScreen extends StatefulWidget {
  const NewExamScreen({super.key});

  @override
  State<NewExamScreen> createState() => _NewExamScreenState();
}

class _NewExamScreenState extends State<NewExamScreen> {
  late NewExamBlock block;
  late NewExamState state;
  List<ItemTypeModel> itemList = [];
  int selectedScanId = 0;
  List<int> selectedFile = [];

  int page = 0;

  @override
  void initState() {
    super.initState();
    block = context.read<NewExamBlock>()..getExamClips();
    state = block.state;
    page = (state.controller?.initialPage ?? 0 + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBarNewExam(page),
      body: BlocConsumer<NewExamBlock, NewExamState>(
        bloc: block,
        builder: (context, state) {
          if (state is LoadDataNewExamState) {
            return CustomLoader(
              loading: true,
              child: Center(),
            );
          }

          return CustomLoader(
            loading: state.loadData,
            child: PageView(
              controller: state.controller,
              onPageChanged: (value) {
                page = value;
                setState(() {});
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FirstPage(
                  values: (p0) {
                    itemList = p0;
                  },
                ),
                SecondPage(
                  onChange: (scanId, files) {
                    selectedFile = files;
                    selectedScanId = scanId;
                  },
                ),
                ThirdPage(),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
      bottomNavigationBar: bottomButton(),
    );
  }

  Widget bottomButton() {
    return page == 2
        ? Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 35.w,
              top: 10.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 45.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResource.appColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: CustomButton(
                    title: 'Save Exam as Draft',
                    onTap: () {},
                    height: 43.h,
                    titleColor: ColorResource.appColor,
                    btnColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  title: 'Submit Exam',
                  onTap: () {},
                  height: 45.h,
                  btnColor: ColorResource.appColor,
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 35.w, top: 25.w),
            child: CustomButton(
              title: 'Continue',
              onTap: page == 0
                  ? firstPageContinue
                  : page == 1
                      ? secondPageContinue
                      : null,
              height: 45.h,
              btnColor: ColorResource.appColor,
            ),
          );
  }

  _topBarNewExam(int page) {
    return PreferredSize(
      preferredSize: Size(100.w, 70.h),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              CustomIconButton(
                icon: Icons.arrow_back_ios_new,
                icnSize: 20,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              Text(
                'Create New Exam',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
              ),
              const Spacer(),
              Stack(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    value: page == 0
                        ? 0.35
                        : page == 1
                            ? 0.7
                            : 1,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorResource.appColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 7.w,
                      top: 8.h,
                    ),
                    child: Text(
                      '${page + 1}/3',
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void thirdPageSubmit() {}

  void secondPageContinue() {
    ToastContext().init(context);
    if (selectedScanId == 0) {
      Toast.show(
        'Please Select Scan',
        duration: 2,
        backgroundRadius: 10,
      );
    } else if (selectedFile.isEmpty) {
      Toast.show(
        'Please Select Scan File ',
        duration: 2,
        backgroundRadius: 10,
      );
    } else {
      block.secondPageContinue(selectedScanId);
    }
  }

  void firstPageContinue() {
    if (itemList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: 70.h,
            left: 40.w,
            right: 40.w,
          ),
          duration: const Duration(
            seconds: 2,
          ),
          content: const Text('Please Select Image'),
        ),
      );
    } else {
      double mb = 0;
      itemList.forEach((element) {
        final bytes = element.file?.readAsBytesSync().lengthInBytes;
        final kb = (bytes ?? 0 / 1024) / 100;
        mb = kb / 1024;
      });
      log(mb.toString(), name: 'Total SIZE in MB --> ');

      if (mb <= 150) {
        block.firstPageContinue(itemList);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: 70.h,
              left: 40.w,
              right: 40.w,
            ),
            duration: const Duration(
              seconds: 2,
            ),
            content: const Text('Please Select Items Under 150 MB.'),
          ),
        );
      }
    }
  }
}
