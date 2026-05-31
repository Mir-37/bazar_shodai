import 'dart:convert';

import 'package:bazar_shodai/data/categories.dart';
import 'package:bazar_shodai/models/grocery_item.dart';
import 'package:bazar_shodai/screens/new_item_screen.dart';
import 'package:bazar_shodai/widgets/grocery_listing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GroceryListing(
        groceryItems: _groceryItems,
        isLoading: _isLoading,
        errorMessage: _error,
      ),
    );
  }

  void _loadItems() async {
    final url = Uri.https(
      'bazarshodai-952ad-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(
      url,
    );
    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data, please try again later';
      });
    }

    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> listData = json.decode(
      response.body,
    );

    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (cItem) => cItem.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );
    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }
}
