import 'package:cinemapedia/presentation/screens/screen.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
    // GoRoute(
    //   path: '/cards',
    //   name: CardsScreen.name,
    //   builder: (context, state) => CardsScreen(),
    // ),
  ],
);
