import 'package:cineket/environment_variable.dart';

enum EnvVariable { appName, baseUrl, env }

Map<String, dynamic> envConfigure(AppEnv appEnv) => {
      EnvVariable.appName.name: appEnv.appName,
      EnvVariable.baseUrl.name: appEnv.baseUrl,
      EnvVariable.env.name: appEnv.env,
    };
