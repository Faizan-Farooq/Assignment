import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimationHorizontal;
  late Animation<double> _fillAnimationVertical;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fillAnimationHorizontal = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _fillAnimationVertical = Tween<double>(begin: 0, end: 0.425).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start position (off-screen below)
      end: Offset(0, 0), // End position (on-screen)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation when the widget is built
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: _fillAnimationHorizontal.value,
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, color: Colors.brown),
                                  SizedBox(width: 8),
                                  Text(
                                    'Saint Petersburg',
                                    style: TextStyle(
                                        color: Colors.brown, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('Assets/avatar.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Hi, Marina',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "let's select your perfect place",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _fillAnimationVertical,
                      builder: (context, child) {
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.425,
                          height: MediaQuery.sizeOf(context).width *
                              _fillAnimationVertical.value,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'BUY',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AnimatedDigitWidget(
                                value: 1034,
                                duration: Duration(seconds: 3),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Offers',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AnimatedBuilder(
                      animation: _fillAnimationVertical,
                      builder: (context, child) {
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.425,
                          height: MediaQuery.sizeOf(context).width *
                              _fillAnimationVertical.value,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'RENT',
                                style: TextStyle(
                                    color: Colors.brown, fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AnimatedDigitWidget(
                                value: 2212,
                                duration: Duration(seconds: 3),
                                textStyle: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Offers',
                                style: TextStyle(
                                    color: Colors.brown, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1,
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'Assets/room1.jpeg', // Make sure to add your image to the assets folder and update pubspec.yaml
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedBuilder(
                                animation: _fillAnimationHorizontal,
                                builder: (context, child) {
                                  return FractionallySizedBox(
                                    widthFactor: _fillAnimationHorizontal.value,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Gladkova St., 43',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.46,
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'Assets/room2.jpeg', // Make sure to add your image to the assets folder and update pubspec.yaml
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AnimatedBuilder(
                                    animation: _fillAnimationHorizontal,
                                    builder: (context, child) {
                                      return FractionallySizedBox(
                                        widthFactor:
                                            _fillAnimationHorizontal.value,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Trefoleva St., 23',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.46,
                            height: MediaQuery.sizeOf(context).height * 0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'Assets/room3.jpeg', // Make sure to add your image to the assets folder and update pubspec.yaml
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedBuilder(
                                        animation: _fillAnimationHorizontal,
                                        builder: (context, child) {
                                          return FractionallySizedBox(
                                            widthFactor:
                                                _fillAnimationHorizontal.value,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Pintolava St., 33',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.46,
                            height: MediaQuery.sizeOf(context).height * 0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'Assets/room4.jpeg', // Make sure to add your image to the assets folder and update pubspec.yaml
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedBuilder(
                                        animation: _fillAnimationHorizontal,
                                        builder: (context, child) {
                                          return FractionallySizedBox(
                                            widthFactor:
                                                _fillAnimationHorizontal.value,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Frehtlava St., 63',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, Utils.mapScreenRoute);
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.message,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.heart_broken,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
