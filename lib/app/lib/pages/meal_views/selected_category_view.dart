import 'package:cocina_coreana/app/lib/domain/data/meals_data.dart';
import 'package:cocina_coreana/app/lib/domain/models/meal.dart';
import 'package:cocina_coreana/app/lib/pages/meal_views/meal_detail_screen.dart';
import 'package:cocina_coreana/app/lib/widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import 'package:flutter/material.dart';

class SelectedCategory extends StatefulWidget {
  final String selectedCategory;
  final String selectedName;
  const SelectedCategory(
      {super.key, required this.selectedCategory, required this.selectedName});

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  static late List<Meal> _meals;
  int mealIx = 0;
  String? mealId = '';
  @override
  void initState() {
    _meals = meals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = _meals.where((meal) {
      return meal.categories!.contains(widget.selectedCategory);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.selectedName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        padding: const EdgeInsets.all(12),
        itemCount: filteredMeals.length,
        itemBuilder: (BuildContext context, int index) {
          final meal = filteredMeals[index];
          return TextButton(
            onPressed: () {
              mealId = meal.id;
              mealIx = meals.indexWhere((element) => element.id == mealId);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MealDetailScreenView(mealIndex: mealIx)),
              );
            },
            child: Container(
              decoration: minimalistDecoration,
              child: Stack(
                children: [
                  Opacity(
                      opacity: 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          meal.imageUrl!,
                        ),
                      )),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          meal.title!,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
