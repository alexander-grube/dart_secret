import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

import '../../db/db.dart';

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
  dynamic result;
  try {
    result = await conn.execute(
      "SELECT message from secret_message where id = '$uuid' limit 1",
    );
  } catch (e) {
    return Response(
      statusCode: 404,
      body: 'Secret not found',
    );
  } finally {
    await conn.close();
  }

  return Response(
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(result),
  );
}
