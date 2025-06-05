import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared/providers/auth_provider.dart';
import 'shared/providers/listing_provider.dart';
import 'shared/providers/demand_provider.dart';
import 'shared/providers/admin_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/role_selection_screen.dart';
import 'presentation/screens/seller/seller_dashboard.dart';
import 'presentation/screens/buyer/buyer_dashboard.dart';
import 'shared/theme/app_colors.dart';
import 'data/models/models.dart';

void main() {
  runApp(AgroMobileApp());
}

class AgroMobileApp extends StatelessWidget {
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
        title: 'AgroBD Marketplace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primary,
            secondary: AppColors.accent,
          ),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: MobileAppRouter(),
        routes: {
          '/role-selection': (context) => RoleSelectionScreen(),
          '/seller-dashboard': (context) => SellerDashboard(),
          '/buyer-dashboard': (context) => BuyerDashboard(),
        },
      ),
    );
  }
}

class MobileAppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (!auth.isLoggedIn) {
          return LoginScreen();
        }
        
        // Route to appropriate dashboard based on user role
        switch (auth.currentUser!.role) {
          case UserRole.seller:
            return SellerDashboard();
          case UserRole.buyer:
            return BuyerDashboard();
          case UserRole.admin:
            // Admin users should use web dashboard, redirect to login
            return LoginScreen();
          default:
            return LoginScreen();
        }
      },
    );
  }
}