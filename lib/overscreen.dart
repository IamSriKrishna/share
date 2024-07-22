import 'package:flutter/material.dart';

class Overscreen extends StatefulWidget {
  const Overscreen({super.key});

  @override
  State<Overscreen> createState() => _OverscreenState();
}

class _OverscreenState extends State<Overscreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }
}

List<Widget> screens = [
  Container(
    child: Text(
      'screen 1',
      style: TextStyle(color: Colors.black),
    ),
  ),
  Container(
    child: Text('screen 2', style: TextStyle(color: Colors.black)),
  ),
  Container(
    child: Text('screen 3', style: TextStyle(color: Colors.black)),
  ),
  Container(
    child: Text('screen 4', style: TextStyle(color: Colors.black)),
  ),
];
