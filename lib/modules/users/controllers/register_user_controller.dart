import 'package:injectable/injectable.dart';

import '../../../pizza_delivery_api.dart';
import '../service/i_user_service.dart';
import '../view_models/register_user_input_model.dart';
import 'models/register_user_rq.dart';

@Injectable()
class RegisterUserController extends ResourceController {
  RegisterUserController(this._service);
  final IUserService _service;

  @Operation.post()
  Future<Response> registerUser(@Bind.body() RegisterUserRq registerRq) async {
    try {
      final registerInput = mapper(registerRq);
      await _service.registerUser(registerInput);
      return Response.ok({
        "message": "Usuário criado com sucesso",
      });
    } catch (e) {
      print(e);
      return Response.serverError(
        body: {"message": "Erro ao registrar novo usuário"},
      );
    }
  }

  RegisterUserInputModel mapper(RegisterUserRq registerUserRq) {
    return RegisterUserInputModel(
      name: registerUserRq.name,
      email: registerUserRq.email,
      password: registerUserRq.password,
    );
  }
}
