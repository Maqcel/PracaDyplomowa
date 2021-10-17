import 'package:dartz/dartz.dart';
import 'package:praca_inz/domain/common/failure.dart';

Future<Either<Failure, T>> genericCall<T>({
  required Future<T> Function() functionWithReturn,
  Failure? failure,
}) async {
  try {
    final ret = await functionWithReturn();
    return right(ret);
  } catch (error) {
    return left(failure ?? Failure.unexpected());
  }
}
