import 'package:bazar_shodai/models/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryListing extends StatefulWidget {
  GroceryListing({
    super.key,
    required this.groceryItems,
    required this.isLoading,
    this.errorMessage,
  });

  final List<GroceryItem> groceryItems;

  final bool isLoading;
  String? errorMessage;

  @override
  State<GroceryListing> createState() => _GroceryListingState();
}

class _GroceryListingState extends State<GroceryListing> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (widget.errorMessage != null) {
      return Center(
        child: Text(
          widget.errorMessage!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    final content = widget.groceryItems.isEmpty
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
            itemCount: widget.groceryItems.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(widget.groceryItems[index].id),
              onDismissed: (direction) {
                _removeItem(widget.groceryItems[index]);
              },
              child: ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  color: widget.groceryItems[index].category.color,
                ),
                title: Text(widget.groceryItems[index].name),
                trailing: Text(
                  widget.groceryItems[index].quantity.toString(),
                  style:
                      Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          );
    return content;
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      widget.groceryItems.remove(item);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: const Text(
            'Item removed!',
          ),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.onTertiaryContainer,
          duration: const Duration(
            milliseconds: 1200,
          ),
          showCloseIcon: true,
        ),
      );
    });
  }
}
