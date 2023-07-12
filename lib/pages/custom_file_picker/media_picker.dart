import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/enum/file_picker_state.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/store/custome_file_picker_store/custom_file_picker_store.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class MediaPicker extends StatelessObserverWidget {
  const MediaPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<CustomFilePickerStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: DropdownButton<AssetPathEntity>(
          style: const TextStyle(color: Colors.black),
          value: store.selectedAlbum,
          onChanged: store.onChangeOfDropDown,
          items: store.albumList
              .map<DropdownMenuItem<AssetPathEntity>>((AssetPathEntity album) {
            return DropdownMenuItem<AssetPathEntity>(
              value: album,
              child: Text(
                album.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                NavigationService.instance.navigateToScreen(Routes.selectImage),
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: GridView.builder(
        controller: store.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: store.filePickerState == FilePickerState.picking
            ? store.assetList.length + 1
            : store.assetList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => NavigationService.instance.navigateToScreen(
              Routes.previewPage,
              arguments: store.assetList[index],
            ),
            child: (index == store.assetList.length &&
                    store.filePickerState == FilePickerState.picking)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: Card(
                          child: AssetEntityImage(
                            store.assetList[index],
                            isOriginal: false,
                            fit: BoxFit.fill,
                            thumbnailSize: const ThumbnailSize.square(250),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => store.selectItem(
                              store.assetList[index],
                            ),
                            icon: Observer(
                              builder: (_) {
                                return store.isItemAlreadySelected(
                                  store.assetList[index],
                                )
                                    ? const Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.circle_outlined,
                                        color: Colors.blue,
                                      );
                              },
                            ),
                          ),
                        ),
                      ),
                      if (store.assetList[index].type == AssetType.video)
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
                  ),
          );
        },
      ),
    );
  }
}
