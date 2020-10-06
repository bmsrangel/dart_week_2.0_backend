import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../application/database/i_database_connection.dart';
import '../../../application/entities/menu.dart';
import '../../../application/entities/menu_item.dart';
import '../../../application/exceptions/database_error_exception.dart';
import 'i_menu_repository.dart';

@LazySingleton(as: IMenuRepository)
class MenuRepository implements IMenuRepository {
  MenuRepository(this._connection);
  final IDatabaseConnection _connection;

  @override
  Future<List<Menu>> findAll() async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      final Results result = await conn.query("select * from cardapio_grupo");
      if (result.isNotEmpty) {
        final List<Menu> menus = result.map<Menu>((row) {
          final fields = row.fields;
          return Menu(
              id: fields["id_cardapio_grupo"] as int,
              name: fields["nome_grupo"] as String);
        }).toList();
        for (Menu menu in menus) {
          final resultItems = await conn.query(
            "select * from cardapio_grupo_item where id_cardapio_grupo = ?",
            [menu.id],
          );

          if (resultItems.isNotEmpty) {
            final items = resultItems.map<MenuItem>((row) {
              final fields = row.fields;
              return MenuItem(
                id: fields["id_cardapio_grupo_item"] as int,
                name: fields["nome"] as String,
                price: fields["valor"] as double,
              );
            }).toList();
            menu.items = items;
          }
        }

        return menus;
      }

      return [];
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException();
    } finally {
      await conn?.close();
    }
  }
}
