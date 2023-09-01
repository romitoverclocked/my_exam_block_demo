import 'dart:io';
import 'dart:typed_data';

class ItemTypeModel {
  File? file;
  Uint8List? videoImage;
  bool? isVideo;
  String? img;

  ItemTypeModel({this.file, this.isVideo,this.videoImage,this.img});
}
