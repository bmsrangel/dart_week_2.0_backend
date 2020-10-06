import 'package:injectable/injectable.dart';

import '../../../application/entities/user.dart';
import '../../../application/exceptions/user_not_found_exception.dart';
import '../../../pizza_delivery_api.dart';
import '../service/i_user_service.dart';
import 'models/login_user_rq.dart';

@Injectable()
class LoginUserController extends ResourceController {
  LoginUserController(this._service);
  final IUserService _service;

  @Operation.post()
  Future<Response> login(@Bind.body() LoginUserRq requestLogin) async {
    try {
      final User user =
          await _service.login(requestLogin.email, requestLogin.password);
      return Response.ok({
        "id": user.id,
        "name": user.name,
        "email": user.email,
      });
    } on UserNotFoundException catch (e) {
      print(e);
      return Response.forbidden();
    } catch (e) {
      print(e);
      return Response.serverError(body: {"message": "Internal server error"});
    }
  }
}
