import 'package:flutter/material.dart';
import 'package:permission_handler_demo/pages/custom_file_picker/media_picker.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

class CustomFilePicker extends StatelessWidget {
  const CustomFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom File Picker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            NavigationService.instance.context,
            MaterialPageRoute<Widget>(
              builder: (_) => const MediaPicker(),
            ),
          );
        },
        child: const Icon(Icons.photo),
      ),
    );
  }
}
