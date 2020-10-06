import 'package:get_it/get_it.dart';

import 'application/config/pizza_delivery_configuration.dart';
import 'application/config/service_locator_config.dart';
import 'application/routers/routers_configure.dart';
import 'pizza_delivery_api.dart';

class PizzaDeliveryApiChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    GetIt.instance.registerLazySingleton(
        () => PizzaDeliveryConfiguration(options.configurationFilePath));
    configureDependencies();
  }

  @override
  Controller get entryPoint {
    final router = Router();

    RoutersConfigure(router).configure();

    return router;
  }
}
