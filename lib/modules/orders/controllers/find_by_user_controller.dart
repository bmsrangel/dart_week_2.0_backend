import 'package:injectable/injectable.dart';

import '../../../application/entities/order.dart';
import '../../../pizza_delivery_api.dart';
import '../service/i_order_service.dart';

@Injectable()
class FindByUserController extends ResourceController {
  FindByUserController(this._service);

  final IOrderService _service;

  @Operation.get("userId")
  Future<Response> findById(@Bind.path("userId") int userId) async {
    try {
      final List<Order> orders = await _service.findByUserId(userId);
      return Response.ok(orders.map((o) => o.toJson()).toList());
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        "message": "Erro ao buscar pedidos",
      });
    }
  }
}
