import '../../modules/menu/menu_routers.dart';
import '../../modules/orders/orders_routers.dart';
import '../../modules/users/users_routers.dart';
import '../../pizza_delivery_api.dart';
import 'i_router_configure.dart';

class RoutersConfigure {
  RoutersConfigure(this._router);

  final Router _router;
  final List<IRouterConfigure> routers = [
    UsersRouters(),
    MenuRouters(),
    OrdersRouters(),
  ];

  void configure() => routers.forEach((r) => r.configure(_router));
}
