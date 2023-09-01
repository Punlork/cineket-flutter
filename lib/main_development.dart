import 'package:cineket/app/app.dart';
import 'package:cineket/bootstrap.dart';
import 'package:cineket/environment_variable.dart';
import 'package:cineket/helper/helper.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  final variables = envConfigure(DevAppEnv());

  FlavorConfig(
    name: variables.appName,
    variables: variables.toMap(),
  );

  bootstrap(() => const App());
}
