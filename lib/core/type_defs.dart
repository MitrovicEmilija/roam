import 'package:fpdart/fpdart.dart';
import 'package:roam/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>; // FutureEither<UserModel>
typedef FutureVoid = FutureEither<void>;
