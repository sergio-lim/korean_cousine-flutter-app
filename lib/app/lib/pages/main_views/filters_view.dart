import 'package:cocina_coreana/app/lib/domain/data/meals_data.dart';
import 'package:cocina_coreana/app/lib/domain/models/meal.dart';
import 'package:cocina_coreana/app/lib/pages/meal_views/meal_detail_screen.dart';
import 'package:cocina_coreana/app/lib/widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FiltersView extends StatefulWidget {
  const FiltersView({super.key});

  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  bool isSpicy = false;
  bool isCheap = false;
  bool isSimple = false;
  bool isFast = false;
  int mealIx = 0;
  bool anyFilterOn = false;
  String? mealId = '';
  List<Meal> _filteredMeals() {
    return meals.where((meal) {
      return (!isSpicy || meal.isSpicy!) &&
          (!isCheap || meal.isCheap!) &&
          (!isSimple || meal.isSimple!) &&
          (!isFast || meal.isFast!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheap || isFast || isSimple || isSpicy) {
      anyFilterOn = true;
    }
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            'Filtros',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Text('Filtros'),
              ),
              ListTile(
                title: Text('Picante'),
                trailing: Checkbox(
                  value: isSpicy,
                  onChanged: (value) {
                    setState(() {
                      isSpicy = value ?? false;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Barato'),
                trailing: Checkbox(
                  value: isCheap,
                  onChanged: (value) {
                    setState(() {
                      isCheap = value ?? false;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Simple'),
                trailing: Checkbox(
                  value: isSimple,
                  onChanged: (value) {
                    setState(() {
                      isSimple = value ?? false;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Rápido'),
                trailing: Checkbox(
                  value: isFast,
                  onChanged: (value) {
                    setState(() {
                      isFast = value ?? false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: anyFilterOn
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                padding: const EdgeInsets.all(12),
                itemCount: _filteredMeals().length,
                itemBuilder: (context, index) {
                  final meal = _filteredMeals()[index];
                  return TextButton(
                    onPressed: () {
                      mealId = meal.id;
                      mealIx =
                          meals.indexWhere((element) => element.id == mealId);
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
              )
            : Center(
                child: Column(
                  children: [
                    const FittedBox(
                        child: Text(
                      'Seleccione los filtros en el menu de la izquierda',
                      style: TextStyle(fontSize: 22),
                    )),
                    LottieBuilder.asset(
                      'assets/animations/filters.zip',
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ],
                ),
              ));
  }
}
