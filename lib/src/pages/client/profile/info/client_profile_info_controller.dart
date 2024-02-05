import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false);
  }

  void goToProfileUpdate() {
    Get.toNamed('client/profile/update');
  }
}
