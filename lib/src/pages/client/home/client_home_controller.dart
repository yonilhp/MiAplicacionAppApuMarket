import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientHomeController extends GetxController {
  var indexTab = 0.obs;
  late User myUser;
  ClientHomeController() {
    myUser = User.fromJson(GetStorage().read('user') ?? {});
  }
  void changeTab(int index) {
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false);
  }
}
