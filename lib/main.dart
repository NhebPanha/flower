import 'package:flower/core/utils/app_notification.dart';
import 'package:flower/features/user/presentation/pages/plash_screen/plash_screen.dart';
import 'package:flower/features/user_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase
  await Supabase.initialize(
    url: "https://wpbpkkupyuregujtenjk.supabase.co",
    anonKey: "sb_publishable_Y1XSbGUlQGgMGBG70jWmwg_POtKQ6aF",
  );
  await initUser();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<UserBloc>())],
      child: MaterialApp(
        navigatorKey: AppNotification.navigatorKey, // 🔥 IMPORTANT
        debugShowCheckedModeBanner: false,
        home: PlashScreen(),
      ),
    );
  }
}
