import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'save_object_store.g.dart';

class SaveObjectStore = _SaveObjectStore with _$SaveObjectStore;

abstract class _SaveObjectStore with Store {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
}
