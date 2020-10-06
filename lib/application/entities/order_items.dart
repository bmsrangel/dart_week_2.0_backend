import 'package:json_annotation/json_annotation.dart';

import 'menu_item.dart';

part 'order_items.g.dart';

@JsonSerializable()
class OrderItems {
  OrderItems({this.id, this.item});

  final int id;
  final MenuItem item;

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}
