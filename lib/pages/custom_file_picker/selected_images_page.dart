import 'package:flutter/material.dart';
import 'package:permission_handler_demo/store/custom_file_picker_store.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class SelectedImagesPage extends StatelessWidget {
  const SelectedImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<CustomFilePickerStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Images'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: store.selectedAssetList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Card(
                  child: AssetEntityImage(
                    store.selectedAssetList[index],
                    isOriginal: false,
                    fit: BoxFit.fill,
                    thumbnailSize: const ThumbnailSize.square(250),
                  ),
                ),
              ),
              if (store.selectedAssetList[index].type == AssetType.video)
                const Positioned(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.video_call_sharp,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
