// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   MyApp({Key? key}) : super(key: key);

// //   final GoRouter _router = GoRouter(
// //     errorBuilder: (context, state) => ErrorScreen(error: state.error),
// //     routes: <GoRoute>[
// //       GoRoute(
// //         routes: <GoRoute>[
// //           GoRoute(
// //             path: 'page2',
// //             builder: (BuildContext context, GoRouterState state) =>
// //                 const Page2Screen(),
// //           ),
// //           GoRoute(
// //             path: 'page3',
// //             builder: (BuildContext context, GoRouterState state) =>
// //                 const Page3Screen(),
// //           ),
// //           GoRoute(
// //             path: 'page4',
// //             builder: (BuildContext context, GoRouterState state) =>
// //                 const Page4Screen(),
// //           ),
// //         ],
// //         path: '/',
// //         builder: (BuildContext context, GoRouterState state) =>
// //             const Page1Screen(),
// //       ),
// //     ],
// //   );

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp.router(
// //       routerDelegate: _router.routerDelegate,
// //       routeInformationParser: _router.routeInformationParser,
// //       routeInformationProvider: _router.routeInformationProvider,
// //     );
// //   }
// // }

// // class Page1Screen extends StatelessWidget {
// //   const Page1Screen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(title: const Text("App.title")),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               ElevatedButton(
// //                 onPressed: () => context.go('/page2'),
// //                 child: const Text('Go to page 2'),
// //               ),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               ElevatedButton(
// //                 onPressed: () => context.go('/page3'),
// //                 child: const Text('Go to page 3'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// // }

// // class Page2Screen extends StatelessWidget {
// //   const Page2Screen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(title: const Text("Page 2")),
// //         body: Center(child: const Text("This is Page 2")),
// //       );
// // }

// // class Page3Screen extends StatelessWidget {
// //   const Page3Screen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(title: const Text("Page 3")),
// //         body: Center(child: const Text("This is Page 3")),
// //       );
// // }

// // class Page4Screen extends StatelessWidget {
// //   const Page4Screen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(title: const Text("Page 4")),
// //         body: Center(child: const Text("This is Page 4")),
// //       );
// // }

// // class ErrorScreen extends StatelessWidget {
// //   final Exception? error;
// //   const ErrorScreen({Key? key, this.error}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(title: const Text("Error")),
// //         body: Center(child: Text(error.toString())),
// //       );
// // }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:route_authentication/auth_service.dart';

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
//           final String id = state.params['id']!;
//           return DetailsScreen(id: id);
//         },
//         redirect: (BuildContext context, GoRouterState state) async {
//           return await authService.isAuthenticated ? null : '/login';
//         },
//       ),
//       GoRoute(
//         path: '/login',
//         builder: (BuildContext context, GoRouterState state) =>
//             const DetailsScreen(
//           id: '100',
//         ),
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
//                 onPressed: () => context.go('/details/1'),
//                 child: const Text('Go to details of item 1'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () => context.go('/details/2'),
//                 child: const Text('Go to details of item 2'),
//               ),
//             ],
//           ),
//         ),
//       );
// }

// class DetailsScreen extends StatelessWidget {
//   final String id;

//   const DetailsScreen({Key? key, required this.id}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text("Details")),
//         body: Center(child: Text('Details of item $id')),
//       );
// }
