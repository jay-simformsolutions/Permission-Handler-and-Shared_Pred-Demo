import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'file_picker_store.g.dart';

class FilePickerStore = _FilePickerStore with _$FilePickerStore;

abstract class _FilePickerStore with Store {
  @observable
  int totalPercentage = 0;

  /// Make Size Limit while pick files
  Future<void> setSizeLimit() async {
    final result = await FilePicker.platform.pickFiles();
    final fileInfo = result?.files.first;
    debugPrint('----------------------------------------');
    debugPrint('File-Name ${fileInfo?.name}');
    debugPrint('File-Size ${fileInfo!.size}');
    debugPrint('File-Extension ${fileInfo.extension}');
    debugPrint('File-Identifier ${fileInfo.identifier}');
    debugPrint('File-Path ${fileInfo.path}');
    debugPrint('File-Bytes ${fileInfo.bytes}');
    debugPrint('----------------------------------------');
    final size = result?.files.first.size;
    final sizeInMB = (size != null) ? size / (1024 * 1024) : 0;
    debugPrint('Size of file in MB is $sizeInMB');
    if (sizeInMB > 500) {
      debugPrint('Too Much large File');
      ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
        const SnackBar(content: Text('Size of file is large')),
      );
    }
  }

  /// Make Limitation on File Selection
  Future<void> selectMultipleFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result!.count > 2) {
      ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
        const SnackBar(content: Text('Can not pick more than 2 files')),
      );
    }
  }

  /// Get Video Details
  Future<void> getVideoDetails() async {
    final result = await FilePicker.platform.pickFiles();

    final video = FlutterVideoInfo();
    final videoInfo = await video.getVideoInfo(result!.paths.first!);
    debugPrint('Title ${videoInfo?.title}');
    debugPrint('Duration ${videoInfo?.duration}');
    debugPrint('File-Size ${videoInfo?.filesize}');
    debugPrint('Path ${videoInfo?.path}');
    debugPrint('Date ${videoInfo?.date}');
  }

  ///Show Progress indicator
  Future<void> showIndicatorDuringLargeFiles() async {
    final result = await FilePicker.platform.pickFiles();
  }
}
