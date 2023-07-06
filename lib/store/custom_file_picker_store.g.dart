// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_file_picker_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomFilePickerStore on _CustomFilePickerStore, Store {
  late final _$filePickerStateAtom =
      Atom(name: '_CustomFilePickerStore.filePickerState', context: context);

  @override
  FilePickerState get filePickerState {
    _$filePickerStateAtom.reportRead();
    return super.filePickerState;
  }

  @override
  set filePickerState(FilePickerState value) {
    _$filePickerStateAtom.reportWrite(value, super.filePickerState, () {
      super.filePickerState = value;
    });
  }

  late final _$selectedAlbumAtom =
      Atom(name: '_CustomFilePickerStore.selectedAlbum', context: context);

  @override
  AssetPathEntity? get selectedAlbum {
    _$selectedAlbumAtom.reportRead();
    return super.selectedAlbum;
  }

  @override
  set selectedAlbum(AssetPathEntity? value) {
    _$selectedAlbumAtom.reportWrite(value, super.selectedAlbum, () {
      super.selectedAlbum = value;
    });
  }

  @override
  String toString() {
    return '''
filePickerState: ${filePickerState},
selectedAlbum: ${selectedAlbum}
    ''';
  }
}
