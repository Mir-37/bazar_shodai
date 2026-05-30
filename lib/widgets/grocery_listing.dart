import 'package:bazar_shodai/models/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryListing extends StatelessWidget {
  const GroceryListing({super.key, required this.groceryItems});

  final List<GroceryItem> groceryItems;

  @override
  Widget build(BuildContext context) {
    final content = groceryItems.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'No Grocery Items Found!!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Center(
                child: Text(
                  ' Try adding some...',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (ctx, index) => ListTile(
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItems[index].category.color,
              ),
              title: Text(groceryItems[index].name),
              trailing: Text(
                groceryItems[index].quantity.toString(),
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          );
    return content;
  }
}
