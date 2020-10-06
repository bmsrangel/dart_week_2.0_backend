class SaveOrderInputModel {
  SaveOrderInputModel({
    this.userId,
    this.address,
    this.paymentType,
    this.itemsId,
  });

  int userId;
  String address;
  String paymentType;
  List<int> itemsId;
}
