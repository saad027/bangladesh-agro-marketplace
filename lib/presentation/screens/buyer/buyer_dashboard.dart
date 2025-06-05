import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../seller/seller_dashboard.dart';
import 'create_demand_screen.dart';

class BuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('🛒 AgroBD - Buyer'),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.info,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'switch_seller',
                child: Row(
                  children: [
                    Icon(Icons.agriculture, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('Switch to Seller Mode'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Text('Profile Settings'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.error),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.info, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user.name}!',
                    style: AppTextStyles.heading.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find fresh crops from local farmers',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Active\nDemands', '2', AppColors.info),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('Total\nPurchases', '8', AppColors.success),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Main Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateDemandScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add_shopping_cart, size: 28),
                label: Text(
                  'Post New Demand',
                  style: AppTextStyles.buttonLarge,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.info,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Recent Demands Section
            Text(
              'Your Recent Demands',
              style: AppTextStyles.title,
            ),
            SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _buildDemandCard('Rice', '200 kg', '৳40-45/kg', 'Urgent', AppColors.error),
                  _buildDemandCard('Onion', '80 kg', '৳35-40/kg', 'This Week', AppColors.accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'switch_seller':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SellerDashboard()),
        );
        break;
      case 'profile':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile settings coming soon!')),
        );
        break;
      case 'logout':
        Provider.of<AuthProvider>(context, listen: false).logout();
        break;
    }
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.statNumber.copyWith(color: color),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.statLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDemandCard(String crop, String quantity, String budget, String urgency, Color urgencyColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_cart,
              color: AppColors.info,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(crop, style: AppTextStyles.cropName),
                Text('Need $quantity • $budget', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: urgencyColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              urgency,
              style: AppTextStyles.status,
            ),
          ),
        ],
      ),
    );
  }
}