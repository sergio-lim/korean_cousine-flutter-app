import 'package:cocina_coreana/app/lib/domain/data/meals_data.dart';
import 'package:cocina_coreana/app/lib/widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealDetailScreenView extends StatefulWidget {
  final int mealIndex;
  const MealDetailScreenView({super.key, required this.mealIndex});

  static const routeName = '/meal_detail_screen';

  @override
  State<MealDetailScreenView> createState() => _MealDetailScreenViewState();
}

class _MealDetailScreenViewState extends State<MealDetailScreenView> {
  bool isFavorite = false;
  List<String> favoriteMeals = [];
  @override
  void initState() {
    super.initState();
    loadFavoritesList().then((value) {
      setState(() {
        favoriteMeals = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool esPicante = false;

    List<String> ingredientsList = [];
    List<String> stepsList = [];
    if (meals[widget.mealIndex] == true) {
      esPicante = true;
    }
    ingredientsList = meals[widget.mealIndex].ingredients!;
    stepsList = meals[widget.mealIndex].steps!;

    if (favoriteMeals.contains(meals[widget.mealIndex].id)) {
      isFavorite = true;
    }
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.black),
        foregroundColor: Colors.black,
        title: Text(
          meals[widget.mealIndex].title!,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isFavorite == false) {
              isFavorite = true;
              favoriteMeals.add(meals[widget.mealIndex].id!);
            } else {
              isFavorite = false;
              favoriteMeals.remove(meals[widget.mealIndex].id!);
            }
            saveFavoritesList(favoriteMeals);
          });
        },
        backgroundColor: Colors.grey[300],
        child: Icon(
          Icons.favorite,
          color: isFavorite ? Colors.red : Colors.black,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(32),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(meals[widget.mealIndex].imageUrl!,
                  height: MediaQuery.of(context).size.height * 0.8),
            ),
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120,
                  width: 180,
                  decoration: minimalistDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        size: 35,
                        color: Colors.blue,
                      ),
                      const Text('Tiempo de preparación:'),
                      Text(meals[widget.mealIndex].duration!),
                    ],
                  ),
                ),
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.fireplace,
                          size: 35,
                          color: Colors.red,
                        ),
                        const Text('Es picante:'),
                        Text(esPicante ? 'Si' : 'No'),
                      ],
                    )),
              ],
            ),
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.bar_chart,
                          size: 35,
                          color: Colors.green,
                        ),
                        const Text('Complejidad'),
                        Text(meals[widget.mealIndex].complexity!),
                      ],
                    )),
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.price_change,
                          size: 35,
                          color: Colors.cyan,
                        ),
                        const Text('Afordabilidad:'),
                        Text(meals[widget.mealIndex].affordability!),
                      ],
                    )),
              ],
            ),
            Container(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50),
              height: 400,
              decoration: minimalistDecoration,
              child: ListView(
                children: [
                  for (var item in ingredientsList)
                    ListTile(
                      title: Text(item),
                    ),
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
              height: 400,
              decoration: minimalistDecoration,
              child: ListView(
                children: [
                  for (var item in stepsList)
                    ListTile(
                      title: Text(item),
                    ),
                ],
              ),
            ),
          ],
        ),
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
