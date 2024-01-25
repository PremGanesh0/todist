import 'package:flutter/material.dart';
import 'package:todist/screens/browse_page.dart';
import 'package:todist/screens/inbox_page.dart';
import 'package:todist/screens/searching_page.dart';
import 'package:todist/screens/today_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color backgroundColor = theme.colorScheme.background;

    return Scaffold(
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.secondary,
        // fixedColor: theme.colorScheme.primary,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined,
                color:
                    _currentIndex == 0 ? theme.colorScheme.primary : theme.colorScheme.secondary),
            label: 'Today',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined,
                color:
                    _currentIndex == 1 ? theme.colorScheme.primary : theme.colorScheme.secondary),
            label: 'Inbox',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined,
                color:
                    _currentIndex == 2 ? theme.colorScheme.primary : theme.colorScheme.secondary),
            label: 'Search',
            backgroundColor: backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.browser_updated_outlined,
                color:
                    _currentIndex == 3 ? theme.colorScheme.primary : theme.colorScheme.secondary),
            label: 'Browse',
            backgroundColor: backgroundColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const TodayPage();
      case 1:
        return const InboxPage();
      case 2:
        return SearchingPage();
      case 3:
        return const BrowsePage();
      default:
        return Container();
    }
  }
}
