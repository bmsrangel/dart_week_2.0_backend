import '../../../application/entities/order.dart';
import '../view_objects/save_order_input_model.dart';

abstract class IOrderService {
  Future<void> saveOrder(SaveOrderInputModel saveOrder);
  Future<List<Order>> findByUserId(int userId);
}
