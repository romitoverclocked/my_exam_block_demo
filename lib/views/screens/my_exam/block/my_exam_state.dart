import 'package:equatable/equatable.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/my_exam_data_model.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/shared_with_me_exam_model.dart';

import '../models/scans_model.dart';

enum TabStatus { INITIAL, LOAD, SUCCESS }

// ignore: must_be_immutable
class MyExamState extends Equatable {
  MyExamState({
    this.allScans,
    this.myExamData,
    this.tabStatus,
    this.sharedWithMeExamData,
    this.tabIndex = 0,
    this.selectedMyExamScan = 1,
    this.selectedSharedWithMeScan = 1,
    this.myExamApiCalled,
    this.sharedExamApiCalled,
    this.loadData = false,
  });

  bool loadData = false;

  TabStatus? tabStatus;

  int tabIndex = 0;
  int selectedMyExamScan = 1;
  int selectedSharedWithMeScan = 1;
  bool? myExamApiCalled;
  bool? sharedExamApiCalled;

  ScansModel? allScans;
  MyExamData? myExamData;
  SharedWithMeExam? sharedWithMeExamData;

  @override
  List<Object?> get props => [
        allScans,
        tabIndex,
        sharedWithMeExamData,
        myExamApiCalled,
        tabStatus,
        selectedMyExamScan,
        myExamData,
        sharedExamApiCalled,
        loadData,
        selectedSharedWithMeScan,
      ];

  MyExamState copyWith(
      {ScansModel? allScans,
      MyExamData? myExamData,
      bool? myExamApiCalled,
      SharedWithMeExam? sharedWithMeExamData,
      TabStatus? tabStatus,
      bool? sharedExamApiCalled,
      int? tabIndex,
      int? selectedMyExamScan,
      int? selectedSharedWithMeScan,
      bool? loadData}) {
    return MyExamState(
        allScans: allScans ?? this.allScans,
        myExamData: myExamData ?? this.myExamData,
        sharedWithMeExamData: sharedWithMeExamData ?? this.sharedWithMeExamData,
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
