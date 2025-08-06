import 'package:app_flutter_the_movie/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';



final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    // Define your app routes here
  ],
);
