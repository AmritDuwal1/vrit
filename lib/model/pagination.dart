class Pagination {
  final int count;
  final String? next;
  final String? previous;

  Pagination({
    required this.count,
    this.next,
    this.previous,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
    );
  }
}
