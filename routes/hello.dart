import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final name = context.request.uri.queryParameters['name'] ?? 'World';

  return Response(
    body: 'Hello, $name!',
  );
}
