import '../search_criteria.dart';

/// A search criteria to define a results limit in api response.
class LimitCriteria implements SearchCriteria {
  final int limit;

  const LimitCriteria({
    required this.limit,
  });

  /// Returns a search criteria as a query parameter for a http request.
  ///
  /// This query parameter corresponds to a limit for elements in 200 responses.
  @override
  String get() => "limit=$limit";
}
