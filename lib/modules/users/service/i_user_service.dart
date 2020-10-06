import '../../../application/entities/user.dart';
import '../view_models/register_user_input_model.dart';

abstract class IUserService {
  Future<void> registerUser(RegisterUserInputModel registerInput);
  Future<User> login(String email, String password);
}
