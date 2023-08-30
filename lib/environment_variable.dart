class AppEnv {
  AppEnv(
    this.env,
    this.appName,
    this.baseUrl,
    this.baseImageUrl,
  );

  final String env;
  final String appName;
  final String baseUrl;
  final String baseImageUrl;

  Map<String, dynamic> toMap() => {
        'env': env,
        'appName': appName,
        'baseUrl': baseUrl,
        'baseImageUrl': baseImageUrl,
      };
}

class DevAppEnv implements AppEnv {
  @override
  String get appName => 'CINEKET Dev';

  @override
  String get baseUrl => 'https://api.themoviedb.org/3/';

  @override
  String get env => 'DEVELOPMENT';

  @override
  String get baseImageUrl => 'https://image.tmdb.org/t/p/w500';

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}

class ProdAppEnv implements AppEnv {
  @override
  String get appName => 'CINEKET';

  @override
  String get baseUrl => 'https://api.themoviedb.org/3/';

  @override
  String get env => 'PRODUCTION';

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  @override
  String get baseImageUrl => throw UnimplementedError();
}
