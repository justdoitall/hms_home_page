import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/const.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DataService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<bool> addItem(String key, String value) async {
    try {
      if (await secureStorage.read(key: key) == null) {
        await secureStorage.write(key: key, value: value);
        return true;
      } else if (await secureStorage.read(key: key) != value) {
        await secureStorage.write(key: key, value: value);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> readItem(String key) async {
    String value = '';
    try {
      if (await secureStorage.read(key: key) != null) {
        value = await secureStorage.read(key: key) as String;

        return value;
      } else {
        return value;
      }
    } catch (e) {
      return value;
    }
  }

  Future<void> logOut() async {
    await secureStorage.delete(key: CONST.authToken);
    await secureStorage.delete(key: CONST.refreshToken);
  }

  Future<bool> checkAuth() async {
    if (await readItem(CONST.refreshToken) == "" || await readItem(CONST.authToken) == "") {
      return false;
    }
    final authToken = await readItem(CONST.authToken);
    final refreshToken = await readItem(CONST.refreshToken);
    if (isExpired(authToken)) {
      try {

        await getRefresh(refreshToken);
        return true;
      } catch (e) {
        print("cant refresh");
        return false;
      }
    } else {
      return true;
    }
  }

  Future<bool> isVerified() async {
    final decodedToken  = decodeToken(await readItem(CONST.authToken));
    if(decodedToken["verify_email"] == null || decodedToken["verify_email"]) {
      return true;
    }
    return false;
  }

  Future<bool> isVerifiedOnPasswordChange() async {
    final decodedToken  = decodeToken(await readItem(CONST.authToken));
    if(decodedToken["verify"] == null || decodedToken["verify"]) {
      return true;
    }
    return false;
  }

  Future<bool> isPasswordChanged() async {
    final decodedToken  = decodeToken(await readItem(CONST.authToken));
    print(decodedToken);
    if(decodedToken["pw_changed"] == null || decodedToken["pw_changed"]) {
      return true;
    }
    return false;
  }


   Future<bool> isFirstEntry() async {
    final decodedToken  = decodeToken(await readItem(CONST.authToken));
    if(decodedToken["first_entry"] == null || decodedToken["first_entry"]) {
      return true;
    }
    return false;
  }

  bool isExpired(token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch(e) {
      return true;
    }
  }

  Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  Future<void> getRefresh(String refreshToken) async {
      await GetIt.I<InterfaceAuthRepository>().refreshToken();

  }
}
