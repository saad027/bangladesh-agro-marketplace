import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared/providers/auth_provider.dart';
import 'shared/providers/listing_provider.dart';
import 'shared/providers/demand_provider.dart';
import 'shared/providers/admin_provider.dart';
import 'admin/screens/admin_dashboard.dart';
import 'shared/theme/app_colors.dart';

void main() {
  runApp(AgroAdminApp());
}

class AgroAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListingProvider()),
        ChangeNotifierProvider(create: (_) => DemandProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'AgroBD Admin Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.info,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.info,
            secondary: AppColors.accent,
          ),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.info,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        home: AdminDashboard(),
      ),
    );
  }
}