import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
import 'watch_screen.dart';
import 'more_screen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationBarState(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Your Movie App'),
          ),
          body: Consumer<BottomNavigationBarState>(
            builder: (context, state, child) {
              return state.currentScreen;
            },
          ),
          bottomNavigationBar: Consumer<BottomNavigationBarState>(
            builder: (context, state, child) {
              return BottomNavigationBar(
                backgroundColor: Colors.black87,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                currentIndex: state.currentIndex,
                onTap: (index) {
                  state.changeScreen(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.play_circle_filled),
                    label: 'Watch',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_books),
                    label: 'Media Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz),
                    label: 'More',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarState with ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    WatchScreen(),
    MoreScreen(),
  ];

  int get currentIndex => _currentIndex;

  Widget get currentScreen => _screens[_currentIndex];

  void changeScreen(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
