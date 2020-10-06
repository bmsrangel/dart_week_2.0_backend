import 'package:injectable/injectable.dart';

import '../../../application/entities/menu.dart';
import '../../../pizza_delivery_api.dart';
import '../service/i_menu_service.dart';

@Injectable()
class MenuFindController extends ResourceController {
  MenuFindController(this._service);
  final IMenuService _service;

  @Operation.get()
  Future<Response> findAll() async {
    final List<Menu> menus = await _service.getAllMenus();

    return Response.ok(menus.map((e) => e.toJson()).toList());
  }
}
