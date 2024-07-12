import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
        3,
        (index) => AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)));
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)))
        .toList();
    _startAnimations();
  }

  void _startAnimations() {
    for (var controller in _controllers) {
      controller.forward();
    }
  }

  void _showLayerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Cosy areas'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your layer selection logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.orange),
                title: Text('Price'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your layer selection logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Infrastructure'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your layer selection logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.layers),
                title: Text('Without any layer'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your layer selection logic here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: <Widget>[
          // Replace GoogleMap widget with an Image widget for the background
          Image.asset(
            'Assets/map.jpg', // Make sure to add your image to the assets folder and update pubspec.yaml
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: 50.0,
            left: 15.0,
            right: 15.0,
            child: Container(
              height: 50.0,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Saint Petersburg',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.tune, color: Colors.grey),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 15.0,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _showLayerOptions(context);
                  },
                  mini: true,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.layers, color: Colors.black),
                ),
                SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.black),
                ),
              ],
            ),
          ),
          ..._buildPriceMarkers(),
        ],
      ),
      bottomNavigationBar: Padding(
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
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: IconButton(
                      onPressed: () {},
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, Utils.homeScreenRoute);
                      },
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
    );
  }

  List<Widget> _buildPriceMarkers() {
    // Example positions and prices
    final List<Map<String, dynamic>> priceMarkers = [
      {
        'position': Offset(150, 200),
        'price': '10.3 mn ₽',
        'controller': _animations[0]
      },
      {
        'position': Offset(250, 300),
        'price': '11 mn ₽',
        'controller': _animations[1]
      },
      {
        'position': Offset(150, 450),
        'price': '7.8 mn ₽',
        'controller': _animations[2]
      },
    ];

    return priceMarkers.map((marker) {
      return AnimatedBuilder(
        animation: marker['controller'],
        builder: (context, child) {
          return Positioned(
            left: marker['position'].dx,
            top: marker['position'].dy,
            child: Transform.scale(
              scale: marker['controller'].value,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  marker['price'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
