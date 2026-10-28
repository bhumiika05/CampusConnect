import 'package:flutter/material.dart';
import 'client.dart';
import 'core/services/session_service.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/main_scaffold.dart';
import 'features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  await SessionService.instance.initSession();
  runApp(const CampusConnectApp());
}

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CampusConnectRoot(),
    );
  }
}

class CampusConnectRoot extends StatefulWidget {
  const CampusConnectRoot({super.key});

  @override
  State<CampusConnectRoot> createState() => _CampusConnectRootState();
}

class _CampusConnectRootState extends State<CampusConnectRoot> {
  @override
  void initState() {
    super.initState();
    SessionService.instance.addListener(_onSessionState);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionState);
    super.dispose();
  }

  void _onSessionState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (SessionService.instance.isLoading &&
        SessionService.instance.currentStudent == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (SessionService.instance.isAuthenticated) {
      return const MainScaffold();
    }

    return const WelcomeScreen();
  }
}
