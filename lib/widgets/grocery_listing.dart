import 'package:bazar_shodai/models/grocery_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroceryListing extends StatelessWidget {
  const GroceryListing({super.key, required this.gItem});
  final GroceryItem gItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: gItem.category.color,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Text(gItem.name),
          const Spacer(),
          Text('${gItem.quantity}'),
        ],
      ),
    );
  }
}
