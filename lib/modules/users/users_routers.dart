import 'package:get_it/get_it.dart';

import '../../application/routers/i_router_configure.dart';
import '../../pizza_delivery_api.dart';
import 'controllers/login_user_controller.dart';
import 'controllers/register_user_controller.dart';

class UsersRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/user").link(() => GetIt.I.get<RegisterUserController>());
    router.route("user/auth").link(() => GetIt.I.get<LoginUserController>());
  }
}
