// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    paymentType: json['paymentType'] as String,
    address: json['address'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : OrderItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'paymentType': instance.paymentType,
      'address': instance.address,
      'items': instance.items,
    };
