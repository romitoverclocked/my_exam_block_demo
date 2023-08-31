import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/new_exam_api/new_exam_api.dart';

import '../models/exam_clip_model.dart';
import '../models/item_type_model.dart';

class NewExamBlock extends Cubit<NewExamState> {
  NewExamBlock() : super(NewExamState());

  Future<void> firstPageContinue(List<ItemTypeModel> allItems) async {
    List<File> allFiles =
        allItems.map((e) => e.file).whereType<File>().toList();
    List<MultipartFile> filesList = [];
    for (var file in allFiles) {
      filesList.add(await MultipartFile.fromFile(file.path));
    }

    FormData formData = FormData.fromMap({"file[]": filesList});
    await NewExamApi.postUploadScans(formData);
  }

  Future<void> getExamClips() async {
    emit(LoadDataNewExamState());
    List<ExamClipModel>? examClips = await NewExamApi.getExamClips();
    int initialPage = 0;
    if (state.examClips != null && state.examClips != []) {
      initialPage = 1;
    } else {
      initialPage = 0;
    }
    emit(
      state.copyWith(
        controller: PageController(initialPage: initialPage),
        examClips: examClips,
      ),
    );
  }

  void secondPageContinue() {}
}
