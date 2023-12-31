import 'package:cineket/enviroment.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

final baseUrl = FlavorConfig.instance.variables['baseUrl'].toString();

final baseOptions = BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {
    'content-Type': 'application/json',
    'authorization': 'Bearer ${Environment.apiKey}',
  },
);

final dio = Dio(baseOptions);

enum RequestType {
  post,
  get,
  head,
  put,
}

Future<Either<T?, Exception>>? baseRequest<T>({
  String path = '',
  RequestType type = RequestType.get,
  Map<String, dynamic>? queryParameters,
  Object? data,
}) {
  Future<Either<T?, Exception>> getRequest() async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      switch (response.statusCode) {
        case 200:
          return Left(response.data);
        default:
          return Right(Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return Right(e);
    }
  }

  Future<Either<T?, Exception>> postRequest() async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
      );
      switch (response.statusCode) {
        case 200:
          return Left(response.data);
        default:
          return Right(Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return Right(e);
    }
  }

  switch (type) {
    case RequestType.get:
      return getRequest();
    case RequestType.post:
      return postRequest();
    case RequestType.head:
    case RequestType.put:
  }

  return null;

  // response.
}
