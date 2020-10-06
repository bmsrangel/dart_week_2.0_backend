import 'package:injectable/injectable.dart';

import '../../../application/entities/order.dart';
import '../data/i_order_repository.dart';
import '../view_objects/save_order_input_model.dart';
import 'i_order_service.dart';

@LazySingleton(as: IOrderService)
class OrderService implements IOrderService {
  OrderService(this._repository);
  final IOrderRepository _repository;

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    await _repository.saveOrder(saveOrder);
  }

  @override
  Future<List<Order>> findByUserId(int userId) async {
    return _repository.findOrdersByUserId(userId);
  }
}
