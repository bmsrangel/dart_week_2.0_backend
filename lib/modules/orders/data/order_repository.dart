import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../application/database/i_database_connection.dart';
import '../../../application/entities/menu_item.dart';
import '../../../application/entities/order.dart';
import '../../../application/entities/order_items.dart';
import '../../../application/exceptions/database_error_exception.dart';
import '../view_objects/save_order_input_model.dart';
import 'i_order_repository.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  OrderRepository(this._connection);

  final IDatabaseConnection _connection;

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      await conn.transaction((_) async {
        final Results result = await conn.query(
          """
          insert into pedido(
            id_usuario,
            forma_pagamento,
            endereco_entrega
          ) values(
            ?,
            ?,
            ?
          )
        """,
          [
            saveOrder.userId,
            saveOrder.paymentType,
            saveOrder.address,
          ],
        );

        final int orderId = result.insertId;

        await conn.queryMulti("""
          insert into pedido_item(
            id_pedido,
            id_cardapio_grupo_item
          ) values(
            ?,
            ?
          )
        """, saveOrder.itemsId.map((item) => [orderId, item]));
      });
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Order>> findOrdersByUserId(int userId) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      final List<Order> orders = <Order>[];
      final Results ordersResult = await conn
          .query("select * from pedido where id_usuario = ?", [userId]);
      if (ordersResult.isNotEmpty) {
        for (Row orderResult in ordersResult) {
          final orderData = orderResult.fields;
          final orderItemsResult = await conn.query(
            """
            select p.id_pedido_item, item.id_cardapio_grupo_item, item.nome, item.valor
            from pedido_item p
            inner join cardapio_grupo_item item on item.id_cardapio_grupo_item = p.id_cardapio_grupo_item
            where p.id_pedido = ?
          """,
            [orderData["id_pedido"] as int],
          );

          final items = orderItemsResult.map<OrderItems>((itemData) {
            final itemFields = itemData.fields;
            return OrderItems(
              id: itemFields["id_pedido_item"] as int,
              item: MenuItem(
                id: itemFields["id_cardapio_grupo_item"] as int,
                name: itemFields["nome"] as String,
                price: itemFields["valor"] as double,
              ),
            );
          }).toList();

          final Order order = Order(
            id: orderData["id_pedido"] as int,
            address: (orderData["endereco_entrega"] as Blob).toString(),
            paymentType: orderData["forma_pagamento"] as String,
            items: items,
          );

          orders.add(order);
        }
      }
      return orders;
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException();
    }
  }
}
