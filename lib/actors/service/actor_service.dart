import 'package:cineket/app/services/base_request.dart';
import 'package:cineket/helper/helper.dart';
import 'package:dartz/dartz.dart';

class ActorService {
  Future<Either<String?, Exception>>? onActorRequested() => baseRequest<String>(
        path: ApiPath.ACTOR_POPULAR,
      );
}
