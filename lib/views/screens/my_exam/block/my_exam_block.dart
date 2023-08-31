import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/exam_data_model.dart';

import '../my_exam_api/my_exam_api.dart';

class MyExamBlock extends Cubit<MyExamState> {
  MyExamBlock() : super(MyExamState());

  Future<bool> onTapSave(String data) async {
    return await MyExamApi.postChangeEmailSetting(data);
  }

  Future<void> onTabChange(int tabIndex) async {
    if (state.tabIndex == tabIndex) {
    } else {
      emit(state.copyWith(loadData: true));
      if (tabIndex == 1) {
        if (state.sharedExamApiCalled == false) {
          emit(state.copyWith(sharedExamApiCalled: true));

          state.sharedWithMeDataList =
              await MyExamApi.getSharedWithMeExamData(state.selectedMyExamScan);
        }
      }

      emit(
        state.copyWith(
          loadData: false,
          tabIndex: tabIndex,
          sharedWithMeDataList: state.sharedWithMeDataList,
        ),
      );
    }
  }

  Future<void> onTapScan(int scanId, bool isFromMyExam) async {
    emit(state.copyWith(loadData: true, myExamPage: 1));

    if (isFromMyExam) {
      state.myExamDataList = await MyExamApi.getExamsData(scanId, 1);
    } else {
      state.sharedWithMeDataList =
          await MyExamApi.getSharedWithMeExamData(scanId);
    }

    emit(
      state.copyWith(
        loadData: false,
        selectedMyExamScan: isFromMyExam ? scanId : state.selectedMyExamScan,
        selectedSharedWithMeScan:
            isFromMyExam == false ? scanId : state.selectedSharedWithMeScan,
        sharedWithMeDataList: state.sharedWithMeDataList,
        myExamDataList: state.myExamDataList,
      ),
    );
  }

  Future<void> _loadMoreData() async {
    if (state.scrollController?.position.pixels ==
        state.scrollController?.position.maxScrollExtent) {
      emit(state.copyWith(loadPaginationData: true));
      int page = state.myExamPage + 1;
      List<ExamData>? myExamData =
          await MyExamApi.getExamsData(state.selectedMyExamScan, page);
      if (myExamData?.isNotEmpty ?? false) {
        List<ExamData> examList = state.myExamDataList ?? [];

        examList.addAll(myExamData as List<ExamData>);
        List<ExamData> finalMyExamData = examList;
        emit(state.copyWith(
          myExamDataList: finalMyExamData,
          myExamPage: page,
        ));
      }
      emit(state.copyWith(
        loadPaginationData: false,
      ));
    }
  }

  Future<void> getDefaultData() async {
    emit(LoadDataMyExamState());
    state.allScans = await MyExamApi.getScanTypes();
    log(state.allScans!.data.toString(), name: "ALL SCANS");
    state.scrollController = ScrollController()..addListener(_loadMoreData);

    state.myExamDataList = await MyExamApi.getExamsData(1, 1);

    emit(state.copyWith(
      allScans: state.allScans,
      scrollController: state.scrollController,
      myExamDataList: state.myExamDataList,
      myExamApiCalled: true,
    ));
  }
}
