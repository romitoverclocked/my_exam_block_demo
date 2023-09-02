import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/new_exam_api/new_exam_api.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../resources/base_url_resource.dart';
import '../models/exam_Interpretations_model.dart';
import '../models/exam_clip_model.dart';
import '../models/item_type_model.dart';

class NewExamBlock extends Cubit<NewExamState> {
  NewExamBlock() : super(NewExamState());

  void onTapPresentAbsentButton(int scanIntIndex, int scanListIndex) {
    List<ExamInterpretationsModel>? list = state.examInterpretationsList;
    ExamInterpretationsModel? selectedElement = list?[scanIntIndex];

    selectedElement?.selectedValue =
        selectedElement.scanValueList?[scanListIndex];
    list?[scanIntIndex] = selectedElement!;
    emit(state.copyWith(examInterpretationsList: list));
  }

  void onTapPresentAbsentChildrenButton(
      int index, int childrenIndex, int scanListIndex) {
    List<ExamInterpretationsModel>? list = state.examInterpretationsList;
    list?[index].children?[childrenIndex].selectedValue = state
        .examInterpretationsList?[index]
        .children?[childrenIndex]
        .scanValueList?[scanListIndex];

    emit(state.copyWith(examInterpretationsList: list));
  }

  void onTapSelectedFiles(int id) {
    List<int> list = state.selectedFiles ?? [];
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    emit(
      state.copyWith(selectedFiles: list),
    );
  }

  Future<void> firstPageContinue(List<ItemTypeModel> allItems) async {
    emit(state.copyWith(loadData: true));
    List<File> allFiles =
        allItems.map((e) => e.file).whereType<File>().toList();
    List<MultipartFile> filesList = [];
    for (var file in allFiles) {
      filesList.add(await MultipartFile.fromFile(file.path));
    }

    FormData formData = FormData.fromMap({"file[]": filesList});
    var examClips = await NewExamApi.postUploadScans(formData);

    emit(
      state.copyWith(
        loadData: false,
        controller: state.controller?..jumpToPage(1),
      ),
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

  Future<void> getExamClips() async {
    emit(LoadDataNewExamState());
    List<ExamClipModel>? examClips = await NewExamApi.getExamClips();
    List<ExamClipModel>? newExamClips = [];
    int initialPage = 0;
    print('This is Exam Clips');
    print(examClips);
    examClips?.forEach((element) async {
      bool? isVideo = element.clipFileVideo?.endsWith('.mp4');
      String url =
          "${BaseUrlResource.examImageUrl}Jemish15-${element.userId}/${element.clipFileVideo ?? ""}";
      if (isVideo ?? false) {
        element.isVideo = true;

        Uint8List img = await videoImage(url);
        element.videoImg = img;

        newExamClips.add(element);
      } else {
        element.clipFileVideo = url;
        newExamClips.add(element);
      }
    });
    if (examClips != null && examClips != []) {
      initialPage = 1;
    } else {
      initialPage = 0;
    }
    emit(
      state.copyWith(
        controller: PageController(initialPage: initialPage),
        examClips: newExamClips,
      ),
    );
  }

  Future<void> secondPageContinue(int selectedScanId) async {
    emit(state.copyWith(loadData: true));
    List<ExamInterpretationsModel>? list =
        await NewExamApi.getExamInterpretations(selectedScanId);
    emit(
      state.copyWith(
        loadData: false,
        examInterpretationsList: list,
        controller: state.controller?..jumpToPage(2),
      ),
    );
  }
}
