import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<List<String>> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  CategorySelectorState createState() => CategorySelectorState();
}

class CategorySelectorState extends State<CategorySelector> {
  final Set<String> _selectedCategories = {};

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });

    widget.onCategorySelected(_selectedCategories.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = _selectedCategories.contains(category);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ElevatedButton(
              onPressed: () => _toggleCategory(category),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isSelected ? Color(0xFFC8519E).withOpacity(0.6) : Colors.black.withOpacity(0.45),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                category,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
