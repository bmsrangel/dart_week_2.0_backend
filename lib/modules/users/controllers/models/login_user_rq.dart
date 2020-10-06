import '../../../../pizza_delivery_api.dart';

class LoginUserRq extends Serializable {
  String email;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      "email": email,
      "password": password,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    email = object["email"] as String;
    password = object["password"] as String;
  }
}
