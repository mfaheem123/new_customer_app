import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenManager {
  static final _box = GetStorage();

  static String get token => _box.read("token") ?? "";

  static int get userId => _box.read("user_id") ?? 0;

  static bool get isLogin => token.isNotEmpty;

  static saveSession({required String token, required int userId}) {
    _box.write("token", token);
    _box.write("user_id", userId);
  }

  static clearSession() async {
    final email = _box.read("email");

    await _box.erase();

    if (email != null) {
      await _box.write("email", email);
    }

    Get.offAllNamed('/SigIn_Screen');
  }
  static clearAfterDelete() {
    _box.remove("token");
    _box.remove("user_id");
  }
}
