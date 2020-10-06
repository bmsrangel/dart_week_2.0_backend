import 'package:injectable/injectable.dart';

import '../../../pizza_delivery_api.dart';
import '../service/i_order_service.dart';
import '../view_objects/save_order_input_model.dart';
import 'models/register_order_rq.dart';

@Injectable()
class RegisterOrderController extends ResourceController {
  RegisterOrderController(this._service);

  final IOrderService _service;

  @Operation.post()
  Future<Response> saveOrder(@Bind.body() RegisterOrderRq orderRq) async {
    try {
      await _service.saveOrder(mapper(orderRq));
      return Response.ok({});
    } catch (e) {
      return Response.serverError(body: {
        "message": "Erro ao registrar o pedido",
      });
    }
  }

  SaveOrderInputModel mapper(RegisterOrderRq orderRq) => SaveOrderInputModel(
        userId: orderRq.userId,
        address: orderRq.address,
        paymentType: orderRq.paymentType,
        itemsId: orderRq.itemsId,
      );
}
