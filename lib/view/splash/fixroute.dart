import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Rail Example',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainLayout(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case '/rapports':
            return MaterialPageRoute(builder: (context) => RapportsScreen());
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfileScreen());
          case '/settings':
            return MaterialPageRoute(builder: (context) => SettingsScreen());
          default:
            return MaterialPageRoute(builder: (context) => HomeScreen());
        }
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool extended = false;
  int selectedIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
      String route;
      switch (index) {
        case 0:
          route = '/home';
          break;
        case 1:
          route = '/rapports';
          break;
        case 2:
          route = '/profile';
          break;
        case 3:
          route = '/settings';
          break;
        default:
          route = '/home';
      }
      _navigatorKey.currentState!.pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            labelType: extended
                ? NavigationRailLabelType.all
                : NavigationRailLabelType.none,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text('Rapports'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          ),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case '/home':
                    builder = (context) => HomeScreen();
                    break;
                  case '/rapports':
                    builder = (context) => RapportsScreen();
                    break;
                  case '/profile':
                    builder = (context) => ProfileScreen();
                    break;
                  case '/settings':
                    builder = (context) => SettingsScreen();
                    break;
                  default:
                    builder = (context) => HomeScreen();
                    break;
                }
                return MaterialPageRoute(builder: builder);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            extended = !extended;
          });
        },
        child: Icon(Icons.menu),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text("Welcome to the Home Screen")),
    );
  }
}

class RapportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rapports')),
      body: Center(child: Text("Welcome to the Rapports Screen")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text("Welcome to the Profile Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
          child: Container(
              height: 300,
              color: Colors.red,
              child: Text("Welcome to the Settings Screen"))),
    );
  }
}
