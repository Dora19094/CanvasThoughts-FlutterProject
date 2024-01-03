import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final BuildContext parentContext;
  final int currentIndex;
  const MyBottomNavigationBar({required this.parentContext,required this.currentIndex, Key? key})
      : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.currentIndex;
    print('build function ran');
    print(currentIndex);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        print('the $index icon tapped');
        navigateToPage(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
      ],
    );
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(widget.parentContext, '/lists');
        break;
      case 1:
        Navigator.pushReplacementNamed(widget.parentContext, '/home');
        break;
      case 2:
        Navigator.pushReplacementNamed(widget.parentContext, '/add-painting');
        break;
    }
  }
}