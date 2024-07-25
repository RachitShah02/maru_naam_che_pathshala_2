import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/splash/splashscreen.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final Color _bgcolor = Colors.white;
  @override
  void initState() {
    super.initState();
    statusBarColor(
        barcolor: _bgcolor,
        navigationBarColor: AppColors.primaryColor,
        navBarBright: Brightness.light);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgcolor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: const [
              BoxShadow(offset: Offset(0, 10), blurRadius: 10, spreadRadius: 4)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        height: 50,
        child: (_currentPage != 2)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btns("SKIP", 2),
                  const Spacer(),
                  cirle(0),
                  20.hs(),
                  cirle(1),
                  20.hs(),
                  cirle(2),
                  const Spacer(),
                  btns("NEXT", _currentPage + 1),
                ],
              )
            : TextButton(
                onPressed: () {
                  Get.to(() => const SplashScreen());
                },
                child: "GET STARTED".text.white.bold.make()),
      ),
      body: PageView.builder(
          onPageChanged: (page) {
            _currentPage = page;
            setState(() {});
          },
          controller: _controller,
          itemCount: 3,
          itemBuilder: (context, i) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Center(
                        child: SizedBox(
                      width: constraints.maxWidth * .8,
                      height: constraints.maxHeight * .7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            filterQuality: FilterQuality.high,
                            'assets/images/logo.png',
                            width: Get.width * .65,
                          ),
                          "મારૂ નામ છે પાઠશાળા".text.bold.xl3.make()
                        ],
                      ),
                    )));
              },
            );
          }),
    );
  }

  TextButton btns(String title, int page) {
    return TextButton(
        onPressed: () {
          if (_currentPage != 2) {
            _controller.animateToPage(page,
                duration: Durations.medium1, curve: Curves.linear);
            setState(() {});
          }
        },
        child: title.text.white.make());
  }

  Widget cirle(int page) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (page == _currentPage) ? Colors.white : Colors.blueGrey),
      ).onTap(() {
        _controller.jumpToPage(page);
        setState(() {});
      });
}
