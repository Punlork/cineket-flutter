import 'package:cineket/app/services/base_request.dart';
import 'package:cineket/helper/path.dart';
import 'package:dartz/dartz.dart';

class MovieService {
  Future<Either<String?, Exception>?> onMovieRequest({
    required String path,
  }) async {
    final response = baseRequest<String>(
      path: path,
    );
    return response;
  }
}
