import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreenMainPage extends StatefulWidget {
  const IntroductionScreenMainPage({super.key});
  static const routeName = '/intro';

  @override
  State<IntroductionScreenMainPage> createState() =>
      _IntroductionScreenMainPageState();
}

class _IntroductionScreenMainPageState
    extends State<IntroductionScreenMainPage> {
  PageController controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: OrientationBuilder(builder: (BuildContext context, orientation) {
          return Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 4);
                  });
                },
                children: const [],
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
                        count: 5,
                        effect: const WormEffect(),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: onLastPage
                            ? IconButton(
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     // return XmlListViewPage();
                                  //   },
                                  // )
                                  // );
                                },
                                icon: const Icon(
                                  Icons.done,
                                  size: 30,
                                ))
                            : IconButton(
                                onPressed: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                icon: const Icon(
                                  Icons.arrow_right_alt_sharp,
                                  size: 30,
                                )),
                      ),
                    ],
                  )),
            ],
          );
        }));
  }
}
