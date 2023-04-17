import 'package:cocina_coreana/app/lib/pages/meal_views/selected_category_view.dart';
import 'package:cocina_coreana/app/lib/pages/meal_views/meal_detail_screen.dart';
import 'package:cocina_coreana/app/lib/widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import 'package:flutter/material.dart';
import '../../domain/data/meals_data.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: GridView.builder(
            itemCount: mealsCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            padding: const EdgeInsets.all(12),
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedCategory(
                        selectedCategory: mealsCategories[index].id!,
                        selectedName: mealsCategories[index].title!,
                      ),
                    ),
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
                              mealsCategories[index].image,
                            ),
                          )),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            mealsCategories[index].title!,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
