import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'models/product.dart';
import 'screens/account/account_screen.dart';
import 'screens/ask/ask_screen.dart';
import 'screens/buy/buy_screen.dart';
import 'screens/buy/product_detail_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/learn/learn_screen.dart';
import 'services/app_state.dart';
import 'widgets/app_bottom_navigation.dart';
import 'widgets/voice_search_button.dart';

class KrishiSetuApp extends StatefulWidget {
  const KrishiSetuApp({super.key});

  @override
  State<KrishiSetuApp> createState() => _KrishiSetuAppState();
}

class _KrishiSetuAppState extends State<KrishiSetuApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    BuyScreen(),
    AskScreen(),
    LearnScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KrishiSetu',
          theme: buildAppTheme(),
          locale: state.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: (settings) {
            if (settings.name == ProductDetailScreen.routeName && settings.arguments is Product) {
              return ProductDetailScreen.route(settings.arguments as Product);
            }
            return null;
          },
          home: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: AppBottomNavigation(
              currentIndex: _currentIndex,
              onSelected: (index) => setState(() => _currentIndex = index),
            ),
            floatingActionButton: _currentIndex == 0
                ? VoiceSearchButton(
                    onTap: () {
                      // TODO: Integrate with speech-to-text API.
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}

