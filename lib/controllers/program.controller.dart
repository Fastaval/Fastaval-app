import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/services/activities.service.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:get/get.dart';

class ProgramController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();

  late List<ActivityItem> programList;

  init() async {
    getDay("2024-03-27");
  }
}
