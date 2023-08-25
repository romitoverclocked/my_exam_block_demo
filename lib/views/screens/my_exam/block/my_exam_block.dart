import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';

import '../my_exam_api/my_exam_api.dart';

class MyExamBlock extends Cubit<MyExamState> {
  MyExamBlock() : super(MyExamState());

  Future<bool> onTapSave(String data) async {
    return await MyExamApi.postChangeEmailSetting(data);
  }

  Future<void> onTabChange(int tabIndex) async {
    emit(state.copyWith(loadData: true));
    print(tabIndex);

    if (tabIndex == 0) {
      if (state.myExamApiCalled == false || state.sharedExamApiCalled == null) {
        state.myExamData =
            await MyExamApi.getExamsData(state.selectedMyExamScan, 1);
      }
    }

    if (tabIndex == 1) {
      if (state.sharedWithMeExamData == false) {
        state.sharedWithMeExamData =
            await MyExamApi.getSharedWithMeExamData(state.selectedMyExamScan);
      }
    }

    emit(
      state.copyWith(
        loadData: false,
        tabIndex: tabIndex,
        sharedExamApiCalled: tabIndex == 1
            ? state.sharedExamApiCalled == false ||
                    state.sharedExamApiCalled == null
                ? true
                : false
            : false,
        myExamData: state.myExamData,
        sharedWithMeExamData: state.sharedWithMeExamData,
      ),
    );
  }

  Future<void> onTapScan(int scanId, bool isFromMyExam) async {
    emit(state.copyWith(loadData: true));

    if (isFromMyExam) {
      state.myExamData = await MyExamApi.getExamsData(scanId, 1);
    } else {
      state.sharedWithMeExamData =
          await MyExamApi.getSharedWithMeExamData(scanId);
    }

    emit(
      state.copyWith(
        loadData: false,
        selectedMyExamScan: isFromMyExam ? scanId : state.selectedMyExamScan,
        selectedSharedWithMeScan:
            isFromMyExam == false ? scanId : state.selectedSharedWithMeScan,
        sharedWithMeExamData: state.sharedWithMeExamData,
        myExamData: state.myExamData,
      ),
    );
  }

  Future<void> getDefaultData() async {
    emit(LoadDataMyExamState());
    state.allScans = await MyExamApi.getScanTypes();
    log(state.allScans!.data.toString(), name: "ALL SCANS");
    state.myExamData = await MyExamApi.getExamsData(1, 1);
    log(state.myExamData!.data!.data.toString(), name: "ALL MY EXAM DATA");

    emit(state.copyWith(
      allScans: state.allScans,
      myExamData: state.myExamData,
      myExamApiCalled: true,
    ));
  }
}
