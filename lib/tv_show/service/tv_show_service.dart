import 'package:cineket/app/services/base_request.dart';
import 'package:dartz/dartz.dart';

class TvShowService {
  Future<Either<String?, Exception>?> onTvShowRequest({
    required String path,
  }) async {
    final response = baseRequest<String>(
      path: path,
    );
    return response;
  }
}
