import 'package:cineket/app/services/base_request.dart';
import 'package:cineket/helper/path.dart';
import 'package:dartz/dartz.dart';

class NowShowingService {
  Future<Either<String?, Exception>?> nowShowingRequest() async {
    final response = baseRequest<String>(
      path: ApiPath.NOW_PLAY,
    );
    return response;
  }
}
