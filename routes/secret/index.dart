import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../db/db.dart';
import '../../models/secret.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final method = request.method.value;

  switch (method) {
    case 'POST':
      return createSecret(request);
    default:
      return Response(
        statusCode: 405,
        body: 'Method Not Allowed',
      );
  }
}

Future<Response> createSecret(Request request) async {
  final body = await request.body();
  final secretRequest =
      SecretRequest.fromJson(jsonDecode(body) as Map<String, dynamic>);

  final conn = await pool();
  final result = await conn.execute(
    """
      INSERT INTO 
      secret_message (message) 
      VALUES ('${secretRequest.message}') 
      RETURNING id, message
    """,
  );
  await conn.close();

  final secretResponse =
      SecretResponse(result[0][0]! as String, result[0][1]! as String);

  return Response(
    statusCode: 201,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(secretResponse),
  );
}
