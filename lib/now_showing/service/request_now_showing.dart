import 'package:cineket/app/services/base_request.dart';
import 'package:cineket/helper/path.dart';
import 'package:dartz/dartz.dart';

class NowShowingService {
  Future<Either<String?, Exception>?> nowShowingRequest({
    required String path,
  }) async {
    final response = baseRequest<String>(
      path: path,
    );
    return response;
  }
}
