import '../../../../pizza_delivery_api.dart';

class RegisterOrderRq extends Serializable {
  int userId;
  String address;
  String paymentType;
  List<int> itemsId;

  @override
  Map<String, dynamic> asMap() {
    return {
      "userId": userId,
      "address": address,
      "paymentType": paymentType,
      "itemsId": itemsId,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    userId = object["userId"] as int;
    address = object["address"] as String;
    paymentType = object["paymentType"] as String;
    itemsId = (object["itemsId"] as List).cast<int>();
  }
}
