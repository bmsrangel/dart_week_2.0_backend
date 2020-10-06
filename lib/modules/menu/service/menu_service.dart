import 'package:injectable/injectable.dart';

import '../../../application/entities/menu.dart';
import '../data/i_menu_repository.dart';
import 'i_menu_service.dart';

@LazySingleton(as: IMenuService)
class MenuService implements IMenuService {
  MenuService(this._repository);
  final IMenuRepository _repository;

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();
  }
}
