import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/store/file_picker_store.dart';
import 'package:provider/provider.dart';

class FilePickerDemo extends StatelessWidget {
  const FilePickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<FilePickerStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: store.setSizeLimit,
              child: const Text('Check Size Limit'),
            ),
            ElevatedButton(
              onPressed: store.selectMultipleFiles,
              child: const Text('File Selection Limit'),
            ),
            ElevatedButton(
              onPressed: store.getVideoDetails,
              child: const Text('Video Details'),
            ),
            ElevatedButton(
              onPressed: store.showIndicatorDuringLargeFiles,
              child: const Text('Pick File'),
            ),
            Observer(
              builder: (_) {
                return CircularProgressIndicator(
                  color: Colors.black,
                  value: double.parse(store.totalPercentage.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
