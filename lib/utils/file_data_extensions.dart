

import 'package:file_picker_pro/file_data.dart';

extension FileDataX on FileData {
  static FileData fromRcordFile({String? fileName,required String path}){
    return FileData(
      hasFile: true,
      fileName: fileName ?? '',
      fileMimeType: "audio/m4a",
      path: path
    );
  }
}