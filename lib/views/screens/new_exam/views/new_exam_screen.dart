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
import 'package:my_exam_block_demo/views/widgets/toast.dart';

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

  @override
  void initState() {
    super.initState();
    block = context.read<NewExamBlock>()..getExamClips();
    state = block.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBarNewExam(state.controller?.initialPage ?? 0),
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
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FirstPage(
                  values: (p0) {
                    itemList = p0;
                  },
                ),
                SecondPage(),
                ThirdPage(),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
      bottomNavigationBar: bottomButton(state.controller?.initialPage ?? 0),
    );
  }

  Widget bottomButton(int page) {
    return BlocBuilder<NewExamBlock, NewExamState>(builder: (context, state) {
      if (state is LoadDataNewExamState) {
        return const SizedBox();
      }
      return Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 35.w, top: 25.w),
        child: CustomButton(
          title: 'Continue',
          onTap: page == 0
              ? firstPageContinue
              : page == 1
                  ? secondPageContinue
                  : thirdPageSubmit,
          height: 45.h,
          btnColor: ColorResource.appColor,
        ),
      );
    });
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
                      '${1 + page}/3',
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

  void secondPageContinue() {}

  void firstPageContinue() {
    double size = 0;
    itemList.forEach((element) {
      final bytes = element.file?.readAsBytesSync().lengthInBytes;
      var kb = bytes ?? 0 / 1024;
      kb = kb / 100;
      final mb = kb / 1024;
      size = mb;
    });
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
          content: const Text('Please Select Image Or Video'),
        ),
      );
    } else {
      if (size <= 150) {
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
