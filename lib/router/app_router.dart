import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';
import 'package:psico_educativa_app/router/app_router_notifier.dart';
import 'package:psico_educativa_app/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: '/splash',
      /* initialLocation: '/games/keyboard_sign_page', */
      refreshListenable: goRouterNotifier,
      routes: [
        ///* Primera pantalla
        /* GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: ':phrase',
            builder: (context, state) => HomePage(
              phrase: state.params['phrase'],
            ),
          ),
        ]), */
        /* GoRoute(
      path: SplashScreenPage.routeName,
      builder: (context, state) => SplashScreenPage(),
    ), */
        GoRoute(
          path: RegisterScreen.routeName,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: CheckOutStatusScreen.routeName,
          builder: (context, state) => CheckOutStatusScreen(),
        ),
        GoRoute(
          path: SignInScreen.routeName,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),

        /* GoRoute(
      path: WelcomePage.routeName,
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
        path: LetterAndNumbersPage.routeName,
        builder: (context, state) => LetterAndNumbersPage(),
        routes: [
          GoRoute(
              path: ':letter',
              builder: (context, state) {
                final letter = state.params['letter'];
                return LetterAndNumbersPageDetail(signChar: letter!);
              }),
        ]),

    GoRoute(
        path: SendMessageWithSignPage.routeName,
        builder: (_, __) => const SendMessageWithSignPage(),
        routes: [
          GoRoute(
            path: ':phrase',
            builder: (_, state) {
              final phrase = state.params['phrase'];
              return SendMessageWithSignPage();
            },
          ),
        ]),
    GoRoute(
      path: SelectGameMenuPage.routeName,
      builder: (_, __) => SelectGameMenuPage(),
    ),
    GoRoute(
        path: '/select_level_page/:gameTitle/:gameDestinty',
        builder: (_, state) {
          final gameTitle = state.params['gameTitle'];
          final gameDestinty = state.params['gameDestinty'];
          final iconGame = state.extra as IconData;
          return SelectLevelPage(
            gameTitle: gameTitle!,
            gameRouteDestinyPage: gameDestinty,
            iconGame: iconGame,
          );
        }),
    GoRoute(
      path: SettingsPage.routeName,
      builder: (_, __) => const SettingsPage(),
    ),

    GoRoute(
      path: '/games',
      builder: (_, __) => const SelectGameMenuPage(),
      routes: [
        GoRoute(
          path: 'test_your_memory_page',
          builder: (_, state) {
            final level = state.extra as Level;
            return TestYourMemoryPage(
              level: level,
            );
          },
        ),
        GoRoute(
          path: 'word_in_sight_page',
          builder: (_, __) => const WordInSightPage(),
        ),
        GoRoute(
          path: 'guess_the_word_page',
          builder: (_, __) => const GuessTheWordPage(),
        ),
        GoRoute(
          path: 'flipping_cards_page',
          builder: (_, state) {
            final level = state.extra as Level;
            return FlippingCardGame(
              level: level,
            );
          },
        ),
        GoRoute(
          path: 'drag_and_drop_game',
          builder: (_, state) => MatchImageGame(),
        ),
        GoRoute(
          path: 'keyboard_page',
          builder: (_, state) => KeyboardLettersPage(),
        ),
        GoRoute(
          path: 'guess_the_word_keyboard',
          builder: (_, state) => GuessTheWordKeyboard(),
        ),
        GoRoute(
          path: 'keyboard_sign_page',
          builder: (_, state) => KeyboardSignPage(),
        ),
      ],
    ),
    GoRoute(
      path: KeyboardLettersPage.routeName,
      builder: (_, state) => KeyboardLettersPage(),
    ),
  */
      ],
      redirect: (context, state) {
        final login = SignInScreen.routeName;
        final register = RegisterScreen.routeName;
        final checkOutStatus = CheckOutStatusScreen.routeName;
        

        final isGoingTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;

        if (authStatus == AuthStatus.noAuthenticated &&
            authStatus == AuthStatus.checking) return null;

        if (authStatus == AuthStatus.noAuthenticated) {
          if (isGoingTo == login || isGoingTo == register) return null;

          return login;
        }
        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == login ||
              isGoingTo == register ||
              isGoingTo == checkOutStatus) return HomeScreen.routeName;
        }
        return null;
      });
});
