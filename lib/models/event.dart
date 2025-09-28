class Event {
  String title;
  String description;
  String category;
  bool isPublic;
  DateTime dateTime;
  String location;

  Event({
    required this.title,
    required this.description,
    required this.category,
    required this.isPublic,
    required this.dateTime,
    required this.location,
  });

  /// Static list of allowed categories
  static const List<String> categories = [
    'Book Club',
    'Workshop',
    'Study Group',
    'Hobby Meetup',
    'Other',
  ];

  /// Convert Event to Map (for backend or local storage)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'isPublic': isPublic,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
    };
  }
}
