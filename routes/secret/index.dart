import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../db/db.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the HTTP method.
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
  final data = jsonDecode(body);
  final message = data['message'] as String;

  final conn = await pool();
  await conn.execute(
    "INSERT INTO secret_message (message) VALUES ('$message')",
  );
  await conn.close();

  return Response(
    statusCode: 201,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'message': message}),
  );
}
