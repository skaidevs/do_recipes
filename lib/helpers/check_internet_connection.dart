import 'package:data_connection_checker/data_connection_checker.dart';

Future<bool> checkInternetConnection() async {
  bool _result = await DataConnectionChecker().hasConnection;
  return _result;
}
