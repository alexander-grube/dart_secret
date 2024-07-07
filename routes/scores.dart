import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the HTTP method.
  final method = request.method.value;

  switch (method) {
    case 'GET':
      return getScores();
    case 'POST':
      return createScore(request);
    default:
      return Response(
        statusCode: 405,
        body: 'Method Not Allowed',
      );
  }
}

Future<Response> getScores() async {
  final scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null},
  ];
  return Response(
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(scores),
  );
}

Future<Response> createScore(Request request) async {
  final body = await request.body();
  final data = jsonDecode(body);
  final score = data['score'] as int;
  return Response(
    statusCode: 201,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'score': score}),
  );
}
