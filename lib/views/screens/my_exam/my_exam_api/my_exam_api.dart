import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_exam_block_demo/resources/base_url_resource.dart';
import 'package:my_exam_block_demo/services/api_service.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/scans_model.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/models/shared_with_me_exam_model.dart';

import '../models/my_exam_data_model.dart';

class MyExamApi {
  static String scanTypeUrl = '${BaseUrlResource.baseUrl}api/get-scan-types';
  static Map<String, String> headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjI5ZTY1ZTNkNTNhYzNkZWUwY2NiMTFkNjVmZDVkODUyMzNhNDBkZmM0MmRlMmRlNzYwYWZjOGRhYjdjNDJiOTM4NzY5N2RiYzA1YTE1OWUiLCJpYXQiOjE2OTI3MDY1MTYuNjI2MjA2LCJuYmYiOjE2OTI3MDY1MTYuNjI2MjEyLCJleHAiOjE3MjQzMjg5MTYuNjE5ODgsInN1YiI6IjIyMTgzIiwic2NvcGVzIjpbXX0.euvmL8ShWeuePK-HWP281xjbMfGeIa1e1RrNPc821BoBij6uSu1cGoA0ptPow5rvQ2YVqDVcN4H5mxrgvYlhjEr_pD46LzBmE0vp4AlZcKe7_uvkkjizKmZw5ZnIIxeu_3sorM3SIU2PJ3Wc3Bptf9eTkvwmgbnebxQBR7FFc-0EK9fFBtj3RqbeH6bfUKc0lQfdkOT7iYlZogZ2RREjc3qTu77zrw74d_rrGXfRm5sc_SSCkQ-SLG90u8Sswc8TrKA65GUsKeoGUKDhz-XfJsatRUNt0NySzHklvHhEKPMMQ54JM4CK8G3TieF_8NvCWucnwBKnF68sNcd5UCJeHdPThbGYV0T0JSbcvuDHB1Wfxe7moMbmdXBM8yZaPlr5X9bE6_mWjJnBqaV-HjGwH1hzsjqkXnJ3Y7Ud8jPeChy-xCZ9XlickTcf-0H1NF7SD6EwEgYaC9z0IysCPI5N7Y8Bao7msMMq-xqogLeoUfgq8K0rCFh3MvTeuiq8cZMSpkMss1f2vkscqAaBhEYoP-xC5jkSF_uzJOusvYTNKq2OK_k8zv2M-zALFqJX49qiU9EXyws5DmGZgwEC1Y-Xp46g9dhAiXgDdP72Vd9KuOeUqiD6_U15nhghspoNXhpyRXZ6gbcdxkiU1CnLHziUUzpnuPz5-HhFiwC4lsGyYSo',
  };

  // static String examUrl = '${baseUrl}/api/get-user-exam/${searchRequest.scanTypeId}?page=${searchRequest.page}';

  static Future<ScansModel> getScanTypes() async {
    Response? response =
        await ApiService.getApi(scanTypeUrl, MyExamApi.headers);

    log('${response?.body.toString()}', name: 'api/get-scan-types - body');
    if (response?.statusCode == 200 && response != null) {
      return scansModelFromJson(response.body);
    } else {
      return ScansModel();
    }
  }

  static Future<MyExamData?> getExamsData(int scanTypeId, int page) async {
    Response? response = await ApiService.getApi(
      '${BaseUrlResource.baseUrl}api/get-user-exam/$scanTypeId?page=$page',
      MyExamApi.headers,
    );
    print(response?.reasonPhrase);
    log('${response?.body.toString()}', name: '/api/get-user-exam');
    if (response?.statusCode == 200 && response != null) {
      return myExamDataFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<SharedWithMeExam?> getSharedWithMeExamData(
      int scanTypeId) async {
    Response? response = await ApiService.getApi(
      '${BaseUrlResource.baseUrl}api/shared-with-me/$scanTypeId',
      MyExamApi.headers,
    );
    print(response?.reasonPhrase);
    log('${response?.body.toString()}', name: '/api/get-user-exam');
    if (response?.statusCode == 200 && response != null) {
      return sharedWithMeExamFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> postChangeEmailSetting(
      String changedEmailSettings) async {
    Response? response = await ApiService.postApi(
      '${BaseUrlResource.baseUrl}api/update-email-settings',
      {'user_email_settings': changedEmailSettings},
      MyExamApi.headers,
    );

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    print(response?.statusCode);
    print(response?.reasonPhrase);
  }
}
