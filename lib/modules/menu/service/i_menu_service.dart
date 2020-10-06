import '../../../application/entities/menu.dart';

abstract class IMenuService {
  Future<List<Menu>> getAllMenus();
}
