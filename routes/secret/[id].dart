import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../db/db.dart';
import '../../models/secret.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  // Access the incoming request.
  final request = context.request;

  // Access the HTTP method.
  final method = request.method.value;

  switch (method) {
    case 'GET':
      return getSecret(id);
    default:
      return Response(
        statusCode: 405,
        body: 'Method Not Allowed',
      );
  }
}

Future<Response> getSecret(String uuid) async {
  final conn = await pool();
  Result result;
  try {
    result = await conn.execute(
      """
        SELECT * from secret_message 
        where id = '$uuid' 
        limit 1
      """,
    );
    if (result.isEmpty) {
      throw Exception('Secret not found');
    }
    await conn.execute(
      """
        DELETE from secret_message 
        where id = '$uuid'
      """,
    );
  } catch (e) {
    return Response(
      statusCode: 404,
      body: e.toString(),
    );
  } finally {
    await conn.close();
  }

  final secret =
      SecretResponse(result[0][0]! as String, result[0][1]! as String);

  return Response(
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(secret),
  );
}
