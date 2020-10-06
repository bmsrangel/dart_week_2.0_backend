import 'package:get_it/get_it.dart';

import '../../application/routers/i_router_configure.dart';
import '../../pizza_delivery_api.dart';
import 'controllers/find_by_user_controller.dart';
import 'controllers/register_order_controller.dart';

class OrdersRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/order").link(() => GetIt.I.get<RegisterOrderController>());
    router
        .route("/orders/user/:userId")
        .link(() => GetIt.I.get<FindByUserController>());
  }
}
