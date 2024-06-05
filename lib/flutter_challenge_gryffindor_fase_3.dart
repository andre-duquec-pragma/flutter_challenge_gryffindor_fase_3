library flutter_challenge_gryffindor_fase_3;

// Models

export './models/request/login_request.dart' show LoginRequest;

export './models/responses/address_response.dart' show AddressResponse;
export './models/responses/categories_response.dart' show CategoriesResponse;
export './models/responses/geo_location_response.dart' show GeoLocationResponse;
export './models/responses/login_response.dart' show LoginResponse;
export './models/responses/name_response.dart' show NameResponse;
export './models/responses/product_response.dart' show ProductResponse;
export './models/responses/rating_response.dart' show RatingResponse;
export './models/responses/user_response.dart' show UserResponse;

// Repositories

export './repositories/auth_repository.dart' show AuthRepository;
export './repositories/categories_repository.dart' show CategoriesRepository;
export './repositories/products_repository.dart' show ProductsRepository;
export './repositories/users_repository.dart' show UsersRepository;

export './repositories/implementation/auth_repository_impl.dart' show AuthRepositoryImpl;
export './repositories/implementation/categories_repository_impl.dart' show CategoriesRepositoryImpl;
export './repositories/implementation/products_repository_impl.dart' show ProductsRepositoryImpl;
export './repositories/implementation/users_repository_impl.dart' show UsersRepositoryImpl;

// Search Criteria

export './utils/search_criteria/implementation/limit_criteria.dart' show LimitCriteria;
export './utils/search_criteria/implementation/order_criteria.dart' show OrderCriteria;

// Filter Criteria

export './utils/search_criteria/implementation/filter_by_category_criteria.dart' show FilterByCategoryCriteria;

// Errors

export './utils/errors/data_error.dart' show DataError, GenericDataError;
