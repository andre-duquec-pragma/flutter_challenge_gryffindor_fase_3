import '../search_criteria.dart';

/// A search criteria to define the elements order in api request.
final class OrderCriteria implements SearchCriteria {
  final FilterOrder order;

  const OrderCriteria({
    required this.order,
  });

  /// Returns a search criteria as a query parameter for a http request.
  ///
  /// This query parameter corresponds to a sort for elements in 200 responses.
  /// It could be asc or desc.
  @override
  String get() => "sort=${order.value}";
}

enum FilterOrder {
  desc(value: "desc"),
  asc(value: "asc");

  final String value;

  const FilterOrder({required this.value});
}
