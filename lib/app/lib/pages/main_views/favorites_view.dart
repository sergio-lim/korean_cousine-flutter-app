import 'package:cocina_coreana/app/lib/domain/data/meals_data.dart';
import 'package:cocina_coreana/app/lib/domain/models/meal.dart';
import 'package:cocina_coreana/app/lib/pages/meal_views/meal_detail_screen.dart';
import 'package:cocina_coreana/app/lib/widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  static late List<Meal> _meals;
  int mealIx = 0;
  bool isListEmpty = false;
  List<String> favoriteMeals = [];
  String mealIdx = '';

  @override
  void initState() {
    _meals = meals;

    super.initState();
    loadFavoritesList().then((value) {
      setState(() {
        favoriteMeals = value ?? [];
        isListEmpty = favoriteMeals.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: isListEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FittedBox(
                    child: Text(
                      'Añade favoritos para que aparezcan aquí',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  LottieBuilder.asset(
                    'assets/animations/favorites.zip',
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
              padding: const EdgeInsets.all(12),
              itemCount: favoriteMeals.length,
              itemBuilder: (BuildContext context, int index) {
                final mealId = favoriteMeals[index];
                final meal = _meals.firstWhere((meal) => meal.id == mealId);
                return TextButton(
                  onPressed: () {
                    mealIdx = meal.id!;
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
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: Colors.black54,
                            child: Text(
                              meal.title!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void saveFavoritesList(List<String> favoriteMeals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteMeals', favoriteMeals);
  }

  Future<List<String>?> loadFavoritesList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? returnedList = prefs.getStringList('favoriteMeals');
    return returnedList;
  }
}
