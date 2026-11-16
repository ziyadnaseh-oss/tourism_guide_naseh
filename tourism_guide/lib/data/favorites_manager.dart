import 'package:flutter/foundation.dart';
import '../models/attraction.dart';

class FavoritesManager with ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Attraction> _favorites = [];

  List<Attraction> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Attraction attraction) {
    return _favorites.any(
      (item) => item.title == attraction.title && item.location == attraction.location,
    );
  }

  void toggleFavorite(Attraction attraction) {
    final index = _favorites.indexWhere(
      (item) => item.title == attraction.title && item.location == attraction.location,
    );
    if (index >= 0) {
      _favorites.removeAt(index);
      attraction.isFavorite = false;
    } else {
      _favorites.add(attraction);
      attraction.isFavorite = true;
    }
    notifyListeners();
  }

  void removeFavorite(Attraction attraction) {
    final index = _favorites.indexWhere(
      (item) => item.title == attraction.title && item.location == attraction.location,
    );
    if (index >= 0) {
      _favorites.removeAt(index);
      attraction.isFavorite = false;
      notifyListeners();
    }
  }
}
