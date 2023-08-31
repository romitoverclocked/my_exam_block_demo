import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/models/item_type_model.dart';

import '../models/exam_clip_model.dart';

class NewExamState extends Equatable {
  NewExamState({this.controller, this.examClips, this.loadData = false});

  PageController? controller;
  List<ExamClipModel>? examClips;
  bool loadData = false;

  @override
  List<Object?> get props => [controller, examClips, loadData];

  NewExamState copyWith(
      {PageController? controller,
      List<ExamClipModel>? examClips,
      bool? loadData}) {
    return NewExamState(
      controller: controller ?? this.controller,
      examClips: examClips ?? this.examClips,
      loadData: loadData ?? this.loadData,
    );
  }
}


// ignore: must_be_immutable
class LoadDataNewExamState extends NewExamState {
  @override
  List<Object?> get props => [];
}
