import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/enum/file_picker_state.dart';
import 'package:photo_manager/photo_manager.dart';

part 'custom_file_picker_store.g.dart';

class CustomFilePickerStore = _CustomFilePickerStore
    with _$CustomFilePickerStore;

abstract class _CustomFilePickerStore with Store {
  _CustomFilePickerStore() {
    initializeAlbums();
  }
  ObservableList<AssetPathEntity> albumList = ObservableList.of([]);

  ObservableList<AssetEntity> assetList = ObservableList.of([]);

  ObservableList<AssetEntity> selectedAssetList = ObservableList.of([]);

  int currentIndex = 0;

  int maxCount = 4;

  @observable
  FilePickerState filePickerState = FilePickerState.picking;

  @observable
  AssetPathEntity? selectedAlbum;

  late ScrollController scrollController = ScrollController()
    ..addListener(loadMoreItems);

  /// Get All The List available for Photos
  Future<void> loadAlbums() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) {
      final response = await PhotoManager.getAssetPathList();
      albumList.addAll(response);
      selectedAlbum = albumList[0];
      //debugPrint('Path list is $albumList');
    } else {
      await PhotoManager.openSetting();
    }
  }

  /// Get All The Asset List For Particular AssetPath Entity
  Future<List<AssetEntity>> loadAssets(AssetPathEntity assetPathEntity) async {
    final response = await assetPathEntity.getAssetListRange(
      start: currentIndex,
      end: currentIndex + 20,
    );
    assetList.addAll(response);
    currentIndex = currentIndex + 20;
    filePickerState = FilePickerState.picked;
    return assetList;
  }

  Future<void> initializeAlbums() async {
    await loadAlbums();
    await loadAssets(selectedAlbum!);
  }

  bool isItemAlreadySelected(AssetEntity assetEntity) {
    return selectedAssetList.contains(assetEntity);
  }

  void selectItem(AssetEntity assetEntity) {
    if (selectedAssetList.isEmpty) {
      debugPrint('ADD and Empty');
      selectedAssetList.add(assetEntity);
    } else if (selectedAssetList.contains(assetEntity)) {
      debugPrint('REMOVE');
      selectedAssetList.remove(assetEntity);
    } else {
      debugPrint('Not EMPTY anf ADD');
      selectedAssetList.add(assetEntity);
    }
  }

  void onChangeOfDropDown(AssetPathEntity? value) {
    currentIndex = 0;
    assetList.clear();
    debugPrint('Value is $value');
    selectedAlbum = value;
    loadAssets(selectedAlbum!);
  }

  Future<void> loadMoreItems() async {
    // debugPrint('Total Count is ${await selectedAlbum!.assetCountAsync}');
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !(FilePickerState.picking == filePickerState)) {
      // debugPrint('Selected Album is $selectedAlbum');
      if (currentIndex + 20 < await selectedAlbum!.assetCountAsync) {
        // debugPrint('Inside IF');
        filePickerState = FilePickerState.picking;
        await loadAssets(selectedAlbum!);
      } else if (currentIndex != await selectedAlbum!.assetCountAsync) {
        // debugPrint('Inside ELSE IF');
        filePickerState = FilePickerState.picking;
        await loadAssets(selectedAlbum!);
      }
    }
  }

// Future<void> pickFiles() async {
//   final ps = await PhotoManager.requestPermissionExtend();
//   if (ps.isAuth) {
//     final response = await PhotoManager.getAssetPathList();
//     await addAllPaths(response);
//
//     // pathList.addAll(response);
//     // openBottomSheet();
//
//     debugPrint('Path is ${pathList.length}');
//
//     // Granted.
//   } else {
//     await PhotoManager.openSetting();
//     // Limited(iOS) or Rejected, use `==` for more precise judgements.
//     // You can call `PhotoManager.openSetting()` to open settings for further steps.
//   }
// }
//
// Future<void> addAllPaths(List<AssetPathEntity> response) async {
//   pathList.addAll(response);
//   final response1 = await pathList[0].getAssetListRange(start: 0, end: 30);
//   assets.addAll(response1);
//
//   for (var i = 0; i < assets.length; i++) {
//     debugPrint('Assets are ${assets}');
//   }
// }

  ///We Chat Asset
  ///
/* Future<void> pickFiles() async {
    final _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      final paths = await PhotoManager.getAssetPathList();
      debugPrint('Path is $paths');
      final result = await AssetPicker.pickAssets(
        NavigationService.instance.context,
        pickerConfig: AssetPickerConfig(
          textDelegate: const EnglishAssetPickerTextDelegate(),
          shouldRevertGrid: false,
          limitedPermissionOverlayPredicate: (permissionState) {
            debugPrint('PermissionState $permissionState');
            return true;
          },
          gridCount: 3,
          pageSize: 24,
          specialPickerType: SpecialPickerType.wechatMoment,
          filterOptions: FilterOptionGroup(
            imageOption: const FilterOption(
              needTitle: true,
            ),
          ),
        ),
      );
      debugPrint('Result is ${await result?[0].file}'); // Granted.
    } else if (PermissionState.limited == _ps) {
      final paths = await PhotoManager.getAssetPathList();
      debugPrint('Path is $paths');
      final result = await AssetPicker.pickAssets(
        NavigationService.instance.context,
        pickerConfig: AssetPickerConfig(
          shouldRevertGrid: false,
          limitedPermissionOverlayPredicate: (permissionState) {
            debugPrint('PermissionState $permissionState');
            return true;
          },
          gridCount: 3,
          pageSize: 24,
          specialPickerType: SpecialPickerType.wechatMoment,
        ),
      );
      debugPrint('Result is $result'); // Granted.
    } else {
      await PhotoManager.openSetting();
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
      debugPrint('Exception ::');
    }
  }*/
}
