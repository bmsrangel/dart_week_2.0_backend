// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) {
  return OrderItems(
    id: json['id'] as int,
    item: json['item'] == null
        ? null
        : MenuItem.fromJson(json['item'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
    };
