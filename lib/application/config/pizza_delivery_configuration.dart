import '../../pizza_delivery_api.dart';
import 'database_connection_configuration.dart';

class PizzaDeliveryConfiguration extends Configuration {
  PizzaDeliveryConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConnectionConfiguration database;
}
