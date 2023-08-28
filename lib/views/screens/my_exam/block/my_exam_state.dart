import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/exam_data_model.dart';

import '../models/scans_model.dart';

enum TabStatus { INITIAL, LOAD, SUCCESS }

// ignore: must_be_immutable
class MyExamState extends Equatable {
  MyExamState({
    this.allScans,
    this.myExamDataList,
    this.tabStatus,
    this.sharedWithMeDataList,
    this.tabIndex = 0,
    this.selectedMyExamScan = 1,
    this.selectedSharedWithMeScan = 1,
    this.myExamApiCalled,
    this.scrollController,
    this.sharedExamApiCalled,
    this.myExamPage = 1,
    this.loadData = false,
    this.loadPaginationData = false,
  });

  bool loadData = false;

  ScrollController? scrollController;

  TabStatus? tabStatus;
  int myExamPage = 1;
  int tabIndex = 0;
  int selectedMyExamScan = 1;
  int selectedSharedWithMeScan = 1;
  bool? myExamApiCalled;
  bool? sharedExamApiCalled;
  bool loadPaginationData = false;

  ScansModel? allScans;
  List<ExamData>? myExamDataList ;
  List<ExamData>? sharedWithMeDataList ;

  @override
  List<Object?> get props => [
        allScans,
        tabIndex,
        loadPaginationData,
        scrollController,
    sharedWithMeDataList,
        myExamApiCalled,
        tabStatus,
        selectedMyExamScan,
    myExamDataList,
        sharedExamApiCalled,
        loadData,
        myExamPage,
        selectedSharedWithMeScan,
      ];

  MyExamState copyWith(
      {ScansModel? allScans,
      List<ExamData>? myExamDataList,
      ScrollController? scrollController,
      bool? myExamApiCalled,
      int? myExamPage,
      List<ExamData>? sharedWithMeDataList,
      TabStatus? tabStatus,
      bool? sharedExamApiCalled,
      int? tabIndex,
      bool? loadPaginationData,
      int? selectedMyExamScan,
      int? selectedSharedWithMeScan,
      bool? loadData}) {
    return MyExamState(
        allScans: allScans ?? this.allScans,
        myExamDataList: myExamDataList ?? this.myExamDataList,
        loadPaginationData: loadPaginationData ?? this.loadPaginationData,
        myExamPage: myExamPage ?? this.myExamPage,
        scrollController: scrollController ?? this.scrollController,
        sharedWithMeDataList: sharedWithMeDataList ?? this.sharedWithMeDataList,
        tabStatus: tabStatus ?? this.tabStatus,
        myExamApiCalled: myExamApiCalled ?? this.myExamApiCalled,
        tabIndex: tabIndex ?? this.tabIndex,
        sharedExamApiCalled: sharedExamApiCalled ?? this.sharedExamApiCalled,
        selectedMyExamScan: selectedMyExamScan ?? this.selectedMyExamScan,
        selectedSharedWithMeScan:
            selectedSharedWithMeScan ?? this.selectedSharedWithMeScan,
        loadData: loadData ?? this.loadData);
  }
}

// ignore: must_be_immutable
class LoadDataMyExamState extends MyExamState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadScansData extends MyExamState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DataLoadedMyExamState extends MyExamState {
  @override
  List<Object?> get props => [];
}
