import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/views/widget/email_setting_widget.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/views/widget/exam_list_tile.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/views/widget/scans_list_widget.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/views/widget/tab_selection_widget.dart';
import 'package:my_exam_block_demo/views/widgets/custom_loader.dart';

import '../../../widgets/custom_button.dart';

class MyExamScreen extends StatefulWidget {
  const MyExamScreen({super.key});

  @override
  State<MyExamScreen> createState() => _MyExamScreenState();
}

class _MyExamScreenState extends State<MyExamScreen> {
  late MyExamBlock block;

  @override
  void initState() {
    super.initState();
    block = context.read<MyExamBlock>();
    block.getDefaultData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBarMyExam(),
      body: BlocConsumer<MyExamBlock, MyExamState>(
        bloc: block,
        builder: (context, state) {
          if (state is LoadDataMyExamState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomLoader(
            loading: state.loadData,
            // opacity: 0.0,
            child: SingleChildScrollView(
              child: _body(state),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _body(MyExamState state) {
    print(state.tabIndex);
    if (state.tabIndex == 0) {
      return _myExamBody(state);
    }
    if (state.tabIndex == 1) {
      return _sharedWithMeBody(state);
    }
    if (state.tabIndex == 2) {
      return  EmailSettingWidget();
    }
    return const SizedBox();
  }

  Widget _myExamBody(MyExamState state) {
    return Column(
      children: [
        ScansListWidget(
          isFromMyExam: true,
          state: state,
          onScanChange: (n) {
            block.onTapScan(n, true);
          },
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'My Exams',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    title: 'Create New',
                    onTap: () {},
                    height: 40.h,
                    btnColor: ColorResource.orange,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _myExamDataListWidget(state),
            ],
          ),
        )
      ],
    );
  }

  Widget _sharedWithMeBody(MyExamState state) {
    return Column(
      children: [
        ScansListWidget(
          isFromMyExam: false,
          state: state,
          onScanChange: (n) {
            block.onTapScan(n, false);
          },
        ),
        SizedBox(height: 20.h),
        _sharedWithMwListWidget(state)
      ],
    );
  }

  Widget _sharedWithMwListWidget(MyExamState state) {
    return state.sharedWithMeExamData?.data?.isNotEmpty ?? false
        ? ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ExamListTile(
                examData: state.sharedWithMeExamData?.data?[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 15.h,
              );
            },
            itemCount: state.sharedWithMeExamData?.data?.length ?? 0)
        : Container(
            height: 200.h,
            width: 200.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: AssetImage('assets/images/no_data_found_image.jfif'),
              ),
            ),
          );
  }

  Widget _myExamDataListWidget(MyExamState state) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ExamListTile(
            examData: state.myExamData?.data?.data?[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: state.myExamData?.data?.data?.length ?? 0);
  }

  _topBarMyExam() {
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
                icon: Icons.menu,
                onTap: () {},
              ),
              const Spacer(),
              CustomIconButton(
                icon: Icons.notifications_none,
                onTap: () {},
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomIconButton(
                icon: Icons.person,
                onTap: () {},
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          TabSelectionWidget(
            tabIndex: (n) {
              block.onTabChange(n);
            },
          )
        ],
      ),
    );
  }
}
