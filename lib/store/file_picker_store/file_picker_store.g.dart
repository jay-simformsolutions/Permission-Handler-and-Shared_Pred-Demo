// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_picker_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilePickerStore on _FilePickerStore, Store {
  late final _$totalPercentageAtom =
      Atom(name: '_FilePickerStore.totalPercentage', context: context);

  @override
  int get totalPercentage {
    _$totalPercentageAtom.reportRead();
    return super.totalPercentage;
  }

  @override
  set totalPercentage(int value) {
    _$totalPercentageAtom.reportWrite(value, super.totalPercentage, () {
      super.totalPercentage = value;
    });
  }

  @override
  String toString() {
    return '''
totalPercentage: ${totalPercentage}
    ''';
  }
}
