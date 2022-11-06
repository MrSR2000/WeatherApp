import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import './home_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() async {
    await Future.delayed(
      Duration(milliseconds: 100000),
      // () => Navigator.pushNamed(context, MyHomePage.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final screenHeight = mediaquery.size.height;
    final screenWidth = mediaquery.size.width;
    final statusBarHeight = mediaquery.padding.top;

    final appbar = AppBar(
      centerTitle: true,
      title: const Text(
        'We show weather for you',
        style: TextStyle(color: Color.fromARGB(255, 200, 196, 161)),
      ),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: Stack(
        children: [
          Container(
            height:
                (screenHeight - appbar.preferredSize.height - statusBarHeight) *
                    .97,
            margin: EdgeInsets.all(5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splashScreen/background1.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 85),
            // height:
            //     (screenHeight - appbar.preferredSize.height - statusBarHeight),
            width: double.infinity,
            margin: const EdgeInsets.all(5),

            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Help!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenWidth * .8,
                    child: const Text(
                        'This is a simple weather application which tells the weather of your location you entered. You can choose your location after you entered the application and reach home screen. Now, let’s see what the weather is like today.'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyHomePage.routeName);
                    },
                    child: Text('SKIP!'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
