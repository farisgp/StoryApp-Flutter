import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/api/api_service.dart';
import 'data/preferences/auth_preferences.dart';
import 'provider/auth_provider.dart';
import 'provider/story_provider.dart';
import 'provider/upload_provider.dart';
import 'provider/add_story_provider.dart';
import 'router/router_delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider authProvider;
  late MyRouterDelegate myRouterDelegate;

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await authProvider.isLoggedIn();
    myRouterDelegate.setLoggedIn(isLoggedIn);
  }

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
    authProvider = AuthProvider(
      authPreferences: AuthPreferences(),
      apiService: ApiService(),
    );

    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(
          create: (_) => StoryProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => UploadProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => AddStoryProvider()),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerDelegate: myRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
