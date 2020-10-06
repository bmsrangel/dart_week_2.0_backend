import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../application/database/i_database_connection.dart';
import '../../../application/entities/user.dart';
import '../../../application/exceptions/database_error_exception.dart';
import '../../../application/exceptions/user_not_found_exception.dart';
import '../../../application/helpers/crypt_helpers.dart';
import '../view_models/register_user_input_model.dart';
import 'i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._connection);
  final IDatabaseConnection _connection;

  @override
  Future<void> saveUser(RegisterUserInputModel inputModel) async {
    final conn = await _connection.openConnection();
    try {
      await conn.query("insert usuario(nome, email, senha) values(?, ?, ?)", [
        inputModel.name,
        inputModel.email,
        CryptHelpers.generateSHA256Hash(inputModel.password)
      ]);
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: "Erro ao registrar usuário");
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    final conn = await _connection.openConnection();
    try {
      final Results result = await conn.query(
        """
        select * from usuario where email = ? and senha = ?
      """,
        [email, CryptHelpers.generateSHA256Hash(password)],
      );
      if (result.isEmpty) {
        throw UserNotFoundException();
      }

      final fields = result.first.fields;
      return User(
        id: fields["id_usuario"] as int,
        name: fields["nome"] as String,
        email: fields["email"] as String,
        password: fields["password"] as String,
      );
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: "Erro ao registrar usuário");
    } finally {
      await conn?.close();
    }
  }
}
