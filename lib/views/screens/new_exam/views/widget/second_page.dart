import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/resources/base_url_resource.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../block/new_exam_block.dart';

class SecondPage extends StatefulWidget {
  SecondPage({required this.onChange, super.key});

  void Function(int selectedScanId, List<int> selectedFile) onChange;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late NewExamBlock block;

  late MyExamBlock myExamBlock;
  int selectedScan = -1;

  @override
  void initState() {
    super.initState();
    block = context.read<NewExamBlock>();
    myExamBlock = context.read<MyExamBlock>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewExamBlock, NewExamState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Scan file(s)',
                    style: TextStyle(
                        fontSize: 22.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'First select the uploaded file(s) to create the exam',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                  ),
                ),
                _allPhotos(state),
                Text(
                  'Asign Exam Type',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'select anyone uploaded type and continue',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                  ),
                ),
                allScans(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> videoImage(String path) async {
    Uint8List? uint8list = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );
    return uint8list ?? Uint8List(0);
  }

  Widget _allPhotos(NewExamState state) {
    return GridView.builder(
      itemCount: state.examClips?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (context, index) {
        bool? isSelected =
            state.selectedFiles?.contains(state.examClips?[index].id);
        return GestureDetector(
          onTap: () {
            block.onTapSelectedFiles(state.examClips?[index].id ?? 1);
            widget.onChange(selectedScan, state.selectedFiles ?? []);
            setState(() {});
          },
          child: Stack(
            children: [
              state.examClips?[index].isVideo ?? false
                  ? Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(
                              state.examClips?[index].videoImg ?? Uint8List(0)),
                        ),
                      ),
                    )
                  : Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              state.examClips?[index].clipFileVideo ?? ""),
                        ),
                      ),
                    ),
              if (state.examClips?[index].isVideo ?? false)
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: Icon(
                      Icons.play_arrow,
                      size: 20,
                      color: ColorResource.appColor,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: isSelected ?? false
                          ? ColorResource.orange
                          : ColorResource.lightBlue,
                      child: isSelected ?? false
                          ? Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget allScans() {
    return GridView.builder(
      itemCount: myExamBlock.state.allScans?.data?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 30),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                widget.onChange(
                    myExamBlock.state.allScans?.data?[index].id ?? 1,
                    block.state.selectedFiles ?? []);
                selectedScan = myExamBlock.state.allScans?.data?[index].id ?? 1;
                setState(() {});
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(top: 5.h, right: 5.w),
                decoration: BoxDecoration(
                  color: selectedScan ==
                          myExamBlock.state.allScans?.data?[index].id
                      ? ColorResource.lightBlue
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            '${BaseUrlResource.scanImageBaseUrl}${myExamBlock.state.allScans?.data?[index].categoryImage ?? ""}',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      myExamBlock.state.allScans?.data?[index].categoryName ??
                          "",
                      style: TextStyle(fontSize: 11.sp),
                    )
                  ],
                ),
              ),
            ),
            if (selectedScan == myExamBlock.state.allScans?.data?[index].id)
              Container(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: ColorResource.orange,
                    child: Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
