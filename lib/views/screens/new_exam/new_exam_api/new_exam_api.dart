import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:my_exam_block_demo/resources/base_url_resource.dart';
import 'package:my_exam_block_demo/services/api_service.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/models/exam_Interpretations_model.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/models/exam_clip_model.dart';

class NewExamApi {
  static Map<String, String> headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjI5ZTY1ZTNkNTNhYzNkZWUwY2NiMTFkNjVmZDVkODUyMzNhNDBkZmM0MmRlMmRlNzYwYWZjOGRhYjdjNDJiOTM4NzY5N2RiYzA1YTE1OWUiLCJpYXQiOjE2OTI3MDY1MTYuNjI2MjA2LCJuYmYiOjE2OTI3MDY1MTYuNjI2MjEyLCJleHAiOjE3MjQzMjg5MTYuNjE5ODgsInN1YiI6IjIyMTgzIiwic2NvcGVzIjpbXX0.euvmL8ShWeuePK-HWP281xjbMfGeIa1e1RrNPc821BoBij6uSu1cGoA0ptPow5rvQ2YVqDVcN4H5mxrgvYlhjEr_pD46LzBmE0vp4AlZcKe7_uvkkjizKmZw5ZnIIxeu_3sorM3SIU2PJ3Wc3Bptf9eTkvwmgbnebxQBR7FFc-0EK9fFBtj3RqbeH6bfUKc0lQfdkOT7iYlZogZ2RREjc3qTu77zrw74d_rrGXfRm5sc_SSCkQ-SLG90u8Sswc8TrKA65GUsKeoGUKDhz-XfJsatRUNt0NySzHklvHhEKPMMQ54JM4CK8G3TieF_8NvCWucnwBKnF68sNcd5UCJeHdPThbGYV0T0JSbcvuDHB1Wfxe7moMbmdXBM8yZaPlr5X9bE6_mWjJnBqaV-HjGwH1hzsjqkXnJ3Y7Ud8jPeChy-xCZ9XlickTcf-0H1NF7SD6EwEgYaC9z0IysCPI5N7Y8Bao7msMMq-xqogLeoUfgq8K0rCFh3MvTeuiq8cZMSpkMss1f2vkscqAaBhEYoP-xC5jkSF_uzJOusvYTNKq2OK_k8zv2M-zALFqJX49qiU9EXyws5DmGZgwEC1Y-Xp46g9dhAiXgDdP72Vd9KuOeUqiD6_U15nhghspoNXhpyRXZ6gbcdxkiU1CnLHziUUzpnuPz5-HhFiwC4lsGyYSo',
  };

  static Future<List<ExamInterpretationsModel>?> getExamInterpretations(
      int scanId) async {
    Response? response = await ApiService.getApi(
        '${BaseUrlResource.baseUrl}api/get-scan-interpretations/$scanId',
        headers);
    if (response?.statusCode == 200) {
      Map map = jsonDecode(response?.body ?? '');
      print('this is Map $map');
      List<ExamInterpretationsModel> list = List<ExamInterpretationsModel>.from(
        map['data'].map(
          (e) => ExamInterpretationsModel.fromJson(e),
        ),
      );
      return list;
    } else {
      return null;
    }
  }

  static Future<List<ExamClipModel>?> postUploadScans(data) async {
    dio.Response<dynamic>? response = await ApiService.dioPostApi(
        '${ApiService.baseUrl}api/upload-scan', data, headers);
    print(response?.data);
    print(response?.statusCode);
    if (response?.statusCode == 200) {
      Map map = response?.data as Map;

      print('map $map');
      Map m = {};
      m['names'] = map['data']['name'];
      m['path'] = map['data']['path'];

      List<ExamClipModel> list = [];
      // m.forEach((key, value) {
      //   Map json = {''};
      // });

      return list;
    } else {
      print('NOT SUCCESS');

      return null;
    }
  }

  static Future<List<ExamClipModel>?> getExamClips() async {
    Response? response =
        await ApiService.getApi('${ApiService.baseUrl}api/get-clips', headers);

    if (response?.statusCode == 200) {
      Map map = jsonDecode(response?.body ?? "");

      List l = map['data'];
      List<ExamClipModel> list = [];
      l.forEach((element) {
        Map json = element as Map;
        list.add(ExamClipModel.fromJson(json));
      });
      return list;
    } else {
      return null;
    }
  }
}
