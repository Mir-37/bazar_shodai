import 'package:bazar_shodai/data/dummy_items.dart';
import 'package:flutter/material.dart';

class GroceryListing extends StatelessWidget {
  const GroceryListing({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
  }
}
