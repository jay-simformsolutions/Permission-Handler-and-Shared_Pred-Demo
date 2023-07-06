import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({required this.imagePreview, super.key});

  final AssetEntity imagePreview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Page'),
      ),
      body: Center(
        child: SizedBox(
          child: AssetEntityImage(
            imagePreview,
          ),
        ),
      ),
    );
  }
}
