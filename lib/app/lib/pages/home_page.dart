import 'package:cocina_coreana/app/lib/pages/main_views/categories_view.dart';
import 'package:cocina_coreana/app/lib/pages/main_views/favorites_view.dart';
import 'package:cocina_coreana/app/lib/pages/main_views/filters_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 1);
  bool onLastPage = false;
  List homeIndex = ['Filtros', 'Categorias', 'Favoritos'];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      snackBar: const SnackBar(content: Text('Toca dos veces para salir')),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              homeIndex[currentIndex],
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body:
              OrientationBuilder(builder: (BuildContext context, orientation) {
            return Stack(
              children: [
                PageView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: const [
                    FiltersView(),
                    CategoriesView(),
                    FavoritesView(),
                  ],
                ),
                Container(
                    alignment: orientation == Orientation.portrait
                        ? const Alignment(0, 1.0)
                        : const Alignment(0, 1.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 100,
                          width: 100,
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: const WormEffect(),
                        ),
                        const SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ],
                    )),
              ],
            );
          })),
    );
  }
}
