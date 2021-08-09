

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonController extends GetxController {

  static CommonController get to=>Get.put<CommonController>(CommonController());
  final box = GetStorage();

  init() {
  }

}