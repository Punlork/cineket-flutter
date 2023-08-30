import 'package:cineket/environment_variable.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

AppEnv envConfigure(AppEnv appEnv) =>
    AppEnv(appEnv.env, appEnv.appName, appEnv.baseUrl, appEnv.baseImageUrl);

String getEnvVariable(String key) =>
    FlavorConfig.instance.variables[key].toString();
