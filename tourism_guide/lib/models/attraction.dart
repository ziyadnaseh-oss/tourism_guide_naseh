class Attraction {
  final String title;
  final String location;
  final String description;
  final String image;
  bool isFavorite;

  Attraction({
    required this.title,
    required this.location,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attraction &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          location == other.location;

  @override
  int get hashCode => title.hashCode ^ location.hashCode;
}
