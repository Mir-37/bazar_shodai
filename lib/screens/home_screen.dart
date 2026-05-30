import 'package:bazar_shodai/data/dummy_items.dart';
import 'package:bazar_shodai/widgets/grocery_listing.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: Column(
        children: [
          for (final gItem in groceryItems) GroceryListing(gItem: gItem),
        ],
      ),
    );
  }
}
