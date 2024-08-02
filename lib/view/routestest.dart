import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? 'Unknown';
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/details/1'),
                child: const Text('Go to details of item 1'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => context.go('/details/2'),
                child: const Text('Go to details of item 2'),
              ),
            ],
          ),
        ),
      );
}

class DetailsScreen extends StatelessWidget {
  final String id;

  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Details")),
        body: Center(child: Text('Details of item $id')),
      );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Center(child: Text('Login Page')),
      );
}


//  context.go(
//                               '/details/${state.counter},  ${state.selectedvalue}',
//                             );


// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   final GoRouter _router = GoRouter(
//     routes: <GoRoute>[
//       GoRoute(
//         path: '/',
//         builder: (BuildContext context, GoRouterState state) =>
//             const HomeScreen(),
//       ),
//       GoRoute(
//         path: '/details/:id',
//         builder: (BuildContext context, GoRouterState state) {
//           final String id = state.pathParameters['id'] ?? '';
//           final String name = state.uri.queryParameters['name'] ?? 'Unknown';
//           return DetailsScreen(id: id, name: name);
//         },
//       ),
//       GoRoute(
//         path: '/login',
//         builder: (BuildContext context, GoRouterState state) =>
//             const LoginScreen(),
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate: _router.routerDelegate,
//       routeInformationParser: _router.routeInformationParser,
//       routeInformationProvider: _router.routeInformationProvider,
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text("Home")),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   Random random = Random();
//                   int randomNumber = random.nextInt(100);
//                   context.go('/details/$randomNumber?name=Item1');
//                 },
//                 child: const Text('Go to details of item 1'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () => context.go('/details/2?name=Item2'),
//                 child: const Text('Go to details of item 2'),
//               ),
//             ],
//           ),
//         ),
//       );
// }

// class DetailsScreen extends StatelessWidget {
//   final String id;
//   final String name;

//   const DetailsScreen({Key? key, required this.id, required this.name})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text("Details")),
//         body: Center(child: Text('Details of $name with ID: $id')),
//       );
// }

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text("Login")),
//         body: Center(child: const Text('Login Page')),
//       );
// }
