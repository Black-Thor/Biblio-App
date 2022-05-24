import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final bool showOnBoard;

  final actualPage = PageController();

  bool isLastPage = false;

  @override
  void dispose() {
    actualPage.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: actualPage,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
                color: Color(0xff0092A2).withOpacity(0.35),
                Title: "Bienvenue sur Bibliotrack",
                subtitle:
                    '''Bibiliotrack, \nest une application pour les passionnées de lecture''',
                image: "assets/onboarding/onboard04.png"),
            buildPage(
                color: Color(0xff0092A2).withOpacity(0.35),
                Title: "Qu'elle livres ? ",
                subtitle:
                    '''Bibiliotrack, \nest une application pour ceux qui oublie qu'elle livres est dans leurs bibliothéque''',
                image: "assets/onboarding/onboard05.png"),
            buildPage(
                color: Color(0xff0092A2).withOpacity(0.35),
                Title: "Liberté",
                subtitle:
                    '''Bibiliotrack,  \nest une application pour vous aidez à ranger vos livres , mangas et même les vinyles''',
                image: "assets/onboarding/onboard06.png"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).backgroundColor,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () async {
                final showOnBoard = await SharedPreferences.getInstance();
                showOnBoard.setBool('showOnBoard', true);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Get Started"))
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => actualPage.jumpToPage(2),
                      child: const Text("SKIP")),
                  Center(
                    child: SmoothPageIndicator(
                      controller: actualPage,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => actualPage.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => actualPage.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text("NEXT"))
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String image,
  required String Title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image.padRight(5),
            // image,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(Title,
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontFamily: "Caveat",
              )),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.teal.shade400,
                fontFamily: "Caveat",
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
