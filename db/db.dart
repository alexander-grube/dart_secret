import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

Future<Pool<dynamic>> pool() async {
  final pool = Pool.withEndpoints(
    [
      Endpoint(
        host: env['DB_HOST']!,
        database: env['DB_NAME']!,
        username: env['DB_USER'],
        password: env['DB_PASS'],
      ),
    ],
    settings: const PoolSettings(
      maxConnectionCount: 10,
      queryTimeout: Duration(seconds: 30),
      sslMode: SslMode.disable,
    ),
  );
  return pool;
}
