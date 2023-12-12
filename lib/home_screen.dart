import 'package:flutter/material.dart';
import 'package:movie_app/navBar/dashboard.dart';
import 'package:movie_app/navBar/media_libraryScreen.dart';
import 'package:movie_app/navBar/more_screen.dart';
import 'package:movie_app/navBar/watch_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationProvider(),
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: IndexedStack(
        index: bottomNavigationProvider.currentIndex,
        children: [
          DashboardScreen(),
          WatchScreen(),
          MediaLibraryScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: bottomNavigationProvider.currentIndex,
        onTap: (index) {
          bottomNavigationProvider.setIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'DashBoard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_half),
            label: 'Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'Media Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
