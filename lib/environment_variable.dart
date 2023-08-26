class AppEnv {
  AppEnv(this.env, this.appName, this.baseUrl);

  final String env;
  final String appName;
  final String baseUrl;
}

class DevAppEnv implements AppEnv {
  @override
  String get appName => 'CINEKET Dev';

  @override
  String get baseUrl => 'https://pnek.dev.com';

  @override
  String get env => 'DEVELOPMENT';
}

class ProdAppEnv implements AppEnv {
  @override
  String get appName => 'CINEKET';

  @override
  String get baseUrl => 'https://pnek.com';

  @override
  String get env => 'PRODUCTION';
}
