import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../data/attractions_data.dart';
import '../data/favorites_manager.dart';
import '../widgets/attraction_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredAttractions = attractions.where((item) {
      final query = _searchQuery.toLowerCase().trim();
      if (query.isEmpty) return true;
      return item.title.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        Container(
          color: AppColors.primary,
          padding: const EdgeInsets.all(15),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search attractions",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: FavoritesManager(),
            builder: (context, _) {
              if (filteredAttractions.isEmpty) {
                return const Center(
                  child: Text(
                    "No attractions found",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredAttractions.length,
                itemBuilder: (context, index) {
                  return AttractionCard(
                    attraction: filteredAttractions[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
