import 'package:dartz/dartz.dart';

import '../models/responses/categories_response.dart';
import '../utils/errors/data_error.dart';

abstract class CategoriesRepository {
  /// To get all categories
  ///
  /// Returns a [Either] value.
  /// Left side corresponds to possible errors.
  /// Right side corresponds to a categories object..
  Future<Either<DataError, CategoriesResponse>> get();
}
