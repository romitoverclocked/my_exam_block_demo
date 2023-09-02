import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';

import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/widgets/custom_button.dart';

import '../../models/exam_Interpretations_model.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late NewExamBlock block;
  late PageController controller;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    block = context.read<NewExamBlock>();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewExamBlock, NewExamState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _itemViewWidget(state),
              _dotIndicators(state),
              _presentAbsentWidget(state),
            ],
          ),
        );
      },
    );
  }

  Widget _presentAbsentWidget(NewExamState state) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ExamInterpretationsModel? model = state.examInterpretationsList?[index];
        bool isChildrenAvailable = model?.children?.isNotEmpty ?? false;

        return isChildrenAvailable
            ? _childrenWidget(model?.children ?? [], index)
            : _PAWidget(model, index, false);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.h);
      },
      itemCount: state.examInterpretationsList?.length ?? 0,
    );
  }

  Widget _childrenWidget(List<Children> children, int index) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, innerIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: ColorResource.orange,
              title: Text(
                children[innerIndex].name ?? "",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              collapsedIconColor: Colors.black,
              collapsedTextColor: Colors.black,
              iconColor: Colors.white,
              collapsedBackgroundColor: Colors.grey.shade300,
              textColor: Colors.white,
              trailing: Icon(Icons.arrow_drop_down),
              children: List.generate(children.length, (ind) {
                ExamInterpretationsModel child = ExamInterpretationsModel(
                  name: children[ind].name,
                  isDefault: children[ind].isDefault,
                  selectedValue: children[ind].selectedValue,
                  date: children[ind].date,
                  scanValueList: children[ind].scanValueList,
                  id: children[ind].id,
                  status: children[ind].status,
                  parentId: children[ind].parentId,
                  scanInputParamsId: children[ind].scanInputParamsId,
                  scanTypeId: children[ind].scanTypeId,
                );
                return _PAWidget(child, innerIndex, true,
                    childrenIndex: ind, child: children[ind]);
              }),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: children.length,
      ),
    );
  }

  Widget _PAWidget(
      ExamInterpretationsModel? model, int index, bool isFromChildren,
      {int childrenIndex = 0, Children? child}) {
    return isFromChildren
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorResource.lightBlue,
            ),
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(child?.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    )),
                SizedBox(
                  height: 13.h,
                ),
                Wrap(
                  spacing: 22,
                  runSpacing: 10,
                  children: List.generate(
                    child?.scanValueList?.length ?? 0,
                    (innerIndex) {
                      bool isSelected = child?.selectedValue ==
                          child?.scanValueList?[innerIndex];
                      bool isSelectedValueEmpty =
                          child?.selectedValue?.isEmpty ?? true;
                      bool isDefaultValue =
                          child?.isDefault == child?.scanValueList?[innerIndex];
                      bool isDefault = (isSelected || isSelectedValueEmpty) &&
                          isDefaultValue;

                      print(isSelected);
                      return button(
                        titleColor: isSelected
                            ? Colors.white
                            : isDefault
                                ? Colors.white
                                : Colors.black,
                        btnColor: isSelected &&
                                child?.isDefault !=
                                    child?.scanValueList?[innerIndex]
                            ? ColorResource.orange
                            : isDefault
                                ? ColorResource.appColor
                                : Colors.white,
                        title: child?.scanValueList?[innerIndex],
                        onTap: () {
                          block.onTapPresentAbsentChildrenButton(
                              index, childrenIndex, innerIndex);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorResource.lightBlue,
              borderRadius: isFromChildren
                  ? null
                  : BorderRadius.all(
                      Radius.circular(10),
                    ),
            ),
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(model?.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    )),
                SizedBox(
                  height: 13.h,
                ),
                Wrap(
                  spacing: 22,
                  runSpacing: 10,
                  children: List.generate(
                    model?.scanValueList?.length ?? 0,
                    (innerIndex) {
                      bool isSelected = model?.selectedValue ==
                          model?.scanValueList?[innerIndex];
                      bool isSelectedValueEmpty =
                          model?.selectedValue?.isEmpty ?? true;
                      bool isDefaultValue =
                          model?.isDefault == model?.scanValueList?[innerIndex];
                      bool isDefault = (isSelected || isSelectedValueEmpty) &&
                          isDefaultValue;

                      return button(
                        titleColor: isSelected
                            ? Colors.white
                            : isDefault
                                ? Colors.white
                                : Colors.black,
                        btnColor: isSelected &&
                                model?.isDefault !=
                                    model?.scanValueList?[innerIndex]
                            ? ColorResource.orange
                            : isDefault
                                ? ColorResource.appColor
                                : Colors.white,
                        title: model?.scanValueList?[innerIndex],
                        onTap: () {
                          block.onTapPresentAbsentButton(index, innerIndex);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget _itemViewWidget(NewExamState state) {
    return SizedBox(
      height: 160.h,
      // width: 320.w,
      child: PageView.builder(
        itemCount: state.examClips?.length,
        controller: controller,
        onPageChanged: (value) {
          selectedPage = value;
          setState(() {});
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  '${state.examClips?[index].clipFileVideo}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dotIndicators(NewExamState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      scrollDirection: Axis.horizontal,
      child: DotsIndicator(
        onTap: (position) {
          controller.jumpToPage(position);
        },
        position: selectedPage,
        dotsCount: state.examClips?.length ?? 0,
        decorator: DotsDecorator(
          color: Colors.grey,
          activeColor: ColorResource.appColor,
        ),
      ),
    );
  }

  Widget button(
      {required String? title,
      Color? btnColor,
      Color? titleColor,
      required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.h,
        width: 130.w,
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
