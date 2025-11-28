class ReleaseDates {
  final String? certification;
  final DateTime? releaseDate;
  final int type;

  ReleaseDates({
    required this.certification,
    required this.releaseDate,
    required this.type,
  });

  factory ReleaseDates.empty() {
    return ReleaseDates(certification: null, releaseDate: null, type: 0);
  }
}
