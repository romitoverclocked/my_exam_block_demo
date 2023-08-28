import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/first_page.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/second_page.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/views/widget/third_page.dart';

import '../../../widgets/custom_button.dart';

class NewExamScreen extends StatefulWidget {
  const NewExamScreen({super.key});

  @override
  State<NewExamScreen> createState() => _NewExamScreenState();
}

class _NewExamScreenState extends State<NewExamScreen> {
  late NewExamBlock block;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    block = context.read<NewExamBlock>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBarNewExam(),
      body: BlocConsumer<NewExamBlock, NewExamState>(
        bloc: block,
        builder: (context, state) {
          return PageView(
            children: [
              FirstPage(),
              SecondPage(),
              ThirdPage(),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  _body(int page) {
    if (page == 1) {}
    if (page == 2) {}
    if (page == 3) {}
  }

  _topBarNewExam() {
    return PreferredSize(
      preferredSize: Size(100.w, 120.h),
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
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorResource.appColor,
                ),
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
}
