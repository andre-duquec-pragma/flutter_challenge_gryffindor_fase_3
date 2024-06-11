library fake_store_repository;

/// Models

export './models/request/login_request.dart' show LoginRequest;

export './models/responses/address_response.dart' show AddressResponse;
export './models/responses/categories_response.dart' show CategoriesResponse;
export './models/responses/geo_location_response.dart' show GeoLocationResponse;
export './models/responses/login_response.dart' show LoginResponse;
export './models/responses/name_response.dart' show NameResponse;
export './models/responses/product_response.dart' show ProductResponse;
export './models/responses/rating_response.dart' show RatingResponse;
export './models/responses/user_response.dart' show UserResponse;

/// Repositories

export './repositories/main/main_repository.dart' show login, getCategories, getProducts, getProductById, getUsers;

/// Search Criteria

export './utils/search_criteria/implementation/limit_criteria.dart' show LimitCriteria;
export './utils/search_criteria/implementation/order_criteria.dart' show OrderCriteria;

/// Filter Criteria

export './utils/search_criteria/implementation/filter_by_category_criteria.dart' show FilterByCategoryCriteria;

/// Errors

export './utils/errors/data_error.dart' show DataError;
