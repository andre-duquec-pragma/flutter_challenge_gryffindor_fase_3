import 'package:dartz/dartz.dart';

import '../../models/request/login_request.dart';
import '../../models/responses/categories_response.dart';
import '../../models/responses/login_response.dart';
import '../../models/responses/product_response.dart';
import '../../models/responses/user_response.dart';
import '../../utils/errors/data_error.dart';
import '../../utils/search_criteria/filter_criteria.dart';
import '../../utils/search_criteria/search_criteria.dart';
import '../auth_repository.dart';
import '../categories_repository.dart';
import '../implementation/auth_repository_impl.dart';
import '../implementation/categories_repository_impl.dart';
import '../implementation/products_repository_impl.dart';
import '../implementation/users_repository_impl.dart';
import '../products_repository.dart';
import '../users_repository.dart';

/// To perform a login request.
///
/// [request] the data model that encapsulates login data.
///
/// Returns a [Either] value.
/// Left side corresponds to possible errors.
/// Right side corresponds to login response object.
Future<Either<DataError, LoginResponse>> login({
  required LoginRequest request,
}) async {
  const AuthRepository repository = AuthRepositoryImpl();

  return await repository.login(request: request);
}

/// To get all categories
///
/// Returns a [Either] value.
/// Left side corresponds to possible errors.
/// Right side corresponds to a categories object..
Future<Either<DataError, CategoriesResponse>> getCategories() async {
  const CategoriesRepository repository = CategoriesRepositoryImpl();

  return await repository.get();
}

/// To get all products
///
/// [criteria] the search criteria to sort the request data.
/// [filter] the filter criteria to filter the request data.
///
/// Returns a [Either] value.
/// Left side corresponds to possible errors.
/// Right side corresponds to a list of products.
Future<Either<DataError, List<ProductResponse>>> getProducts({
  Criteria? criteria,
  Filters? filters,
}) async {
  const ProductsRepository repository = ProductsRepositoryImpl();

  return await repository.get(
    criteria: criteria,
    filters: filters,
  );
}

/// To get a single product by id.
///
/// [id] the identification of the product to search.
///
/// Returns a [Either] value.
/// Left side corresponds to possible errors.
/// Right side corresponds to a single product.
Future<Either<DataError, ProductResponse>> getProductById({
  required int id,
}) async {
  const ProductsRepository repository = ProductsRepositoryImpl();

  return await repository.getById(id: id);
}

/// To get all users
///
/// [criteria] the search criteria to sort the request data.
///
/// Returns a [Either] value.
/// Left side corresponds to possible errors.
/// Right side corresponds to a list of users.
Future<Either<DataError, List<UserResponse>>> getUsers({
  Criteria? criteria,
}) async {
  const UsersRepository repository = UsersRepositoryImpl();

  return await repository.get(criteria: criteria);
}
