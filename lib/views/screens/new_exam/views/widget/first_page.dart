import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:my_exam_block_demo/resources/color_resource.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/models/item_type_model.dart';
import 'package:my_exam_block_demo/views/widgets/custom_button.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key, required this.values});

  void Function(List<ItemTypeModel>) values;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<ItemTypeModel> itemsList = [];

  Future<void> onTapPhoto() async {
    List<XFile>? items = await ImagePicker().pickMultipleMedia();
    items.forEach((element) async {
      String? mimeStr = lookupMimeType(element.path);
      List<String>? fileType = mimeStr?.split('/');
      if (fileType?[0].toLowerCase() == 'video') {
        Uint8List bytes = await videoImage(element.path);
        itemsList.add(ItemTypeModel(
            file: File(element.path), isVideo: true, videoImage: bytes));
      } else {
        itemsList.add(ItemTypeModel(file: File(element.path), isVideo: false));
      }
    });
    widget.values(itemsList);
    setState(() {});
  }

  Future<void> onTapCamera() async {
    XFile? itm = await ImagePicker().pickImage(source: ImageSource.camera);
    if (itm != null) {
      itemsList.add(
        ItemTypeModel(file: File(itm.path), isVideo: false),
      );
      widget.values(itemsList);

      setState(() {});
    }
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

  void onTapRemove(int index) {
    itemsList.removeAt(index);
    widget.values(itemsList);

    setState(() {});
  }

  late NewExamBlock block;
  late NewExamState state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    block = context.read<NewExamBlock>();
    state = context.read<NewExamBlock>().state;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _itemSelection(),
          _allPhotos(),
        ],
      ),
    );
  }

  Widget _allPhotos() {
    return GridView.builder(
      itemCount: itemsList.length,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            itemsList[index].isVideo ?? false
                ? Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: MemoryImage(
                          itemsList[index].videoImage ?? Uint8List(0),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image:
                            FileImage(File(itemsList[index].file?.path ?? "")),
                      ),
                    ),
                  ),
            if (itemsList[index].isVideo ?? false)
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
                onTap: () => onTapRemove(index),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _itemSelection() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      color: ColorResource.appColor,
      dashPattern: [5],
      child: Container(
        height: 250.h,
        width: 320.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    radius: 35,
                    icnSize: 35,
                    iconColor: ColorResource.appColor,
                    icon: Icons.camera_alt_outlined,
                    onTap: onTapCamera,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  CustomIconButton(
                    radius: 35,
                    icnSize: 35,
                    iconColor: ColorResource.appColor,
                    icon: Icons.photo_outlined,
                    onTap: onTapPhoto,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Text(
                'Upload Scans',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Scan Upload size limit: 150MB',
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
