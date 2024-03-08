import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();
  final loggedIn = false.obs;
  final navIndex = 1.obs;
  //final user = User().obs;
  final userUpdateTime = 0.obs;

  updateLoggedIn(bool status) {
    loggedIn(status);
  }

  updateNavIndex(int index) {
    navIndex(index);
  }

  /*  updateUser(User newUser) {
    user(newUser);
  }
 */
  init() async {
    //await getUser();
  }

  /* Future getUser() async {
    await UserService().getUser().then((newUser) => {
          //updateUser(newUser),
          updateLoggedIn(true),
        });
  } */
}
