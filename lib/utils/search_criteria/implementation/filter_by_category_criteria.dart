import '../filter_criteria.dart';

/// A criteria to define a category filter in products related requests.
final class FilterByCategoryCriteria implements FilterCriteria {
  final String category;

  const FilterByCategoryCriteria({
    required this.category,
  });

  /// Returns a filter as a path parameter for a http request.
  ///
  /// This filter corresponds to a specific category for a products related request.
  @override
  String get() => "/category/$category";
}
