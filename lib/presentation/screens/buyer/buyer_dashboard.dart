import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/providers/demand_provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../data/models/models.dart';
import '../../../data/mock_data.dart';
import '../seller/seller_dashboard.dart';
import 'create_demand_screen.dart';
import 'package:intl/intl.dart';

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

            // Your Demands Section
            Text(
              'Your Demands',
              style: AppTextStyles.title,
            ),
            SizedBox(height: 12),

            Expanded(
              child: Consumer<DemandProvider>(
                builder: (context, demandProvider, child) {
                  final userDemands = demandProvider.getDemandsByBuyer(user.id);
                  
                  if (userDemands.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No demands yet',
                            style: AppTextStyles.title.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Create your first demand to find crops',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Sort demands: Active first, then by date
                  final sortedDemands = List<Demand>.from(userDemands);
                  sortedDemands.sort((a, b) {
                    // Active demands first
                    if (a.status == DemandStatus.posted && b.status != DemandStatus.posted) {
                      return -1;
                    }
                    if (a.status != DemandStatus.posted && b.status == DemandStatus.posted) {
                      return 1;
                    }
                    
                    // Within same status, sort by date (newest first)
                    return b.createdAt.compareTo(a.createdAt);
                  });
                  
                  return ListView.builder(
                    itemCount: sortedDemands.length,
                    itemBuilder: (context, index) {
                      final demand = sortedDemands[index];
                      final crop = MockData.getCropById(demand.cropId);
                      final isCompleted = demand.status == DemandStatus.completed;
                      
                      return _buildDemandCard(
                        crop?.displayName ?? 'Unknown Crop',
                        demand.quantityNeeded,
                        demand.budgetRange ?? 'Budget not set',
                        _getUrgencyText(demand.urgency),
                        _getUrgencyColor(demand.urgency),
                        _getStatusText(demand.status),
                        _getStatusColor(demand.status),
                        isCompleted,
                        demand.createdAt,
                      );
                    },
                  );
                },
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

  Widget _buildDemandCard(
    String crop, 
    String quantity, 
    String budget, 
    String urgency, 
    Color urgencyColor,
    String status,
    Color statusColor,
    bool isCompleted,
    DateTime createdAt,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? Colors.grey.shade300 : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isCompleted ? Colors.grey : AppColors.info).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_cart,
              color: isCompleted ? Colors.grey : AppColors.info,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop, 
                  style: AppTextStyles.cropName.copyWith(
                    color: isCompleted ? Colors.grey.shade600 : null,
                  ),
                ),
                Text(
                  'Need $quantity • $budget', 
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isCompleted ? Colors.grey.shade500 : null,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: urgencyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: urgencyColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        urgency,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: urgencyColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _formatDate(createdAt),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: AppTextStyles.status.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUrgencyText(UrgencyLevel urgency) {
    switch (urgency) {
      case UrgencyLevel.urgent:
        return 'Urgent';
      case UrgencyLevel.week:
        return 'This Week';
      case UrgencyLevel.flexible:
        return 'Flexible';
      default:
        return 'Unknown';
    }
  }

  Color _getUrgencyColor(UrgencyLevel urgency) {
    switch (urgency) {
      case UrgencyLevel.urgent:
        return AppColors.error;
      case UrgencyLevel.week:
        return AppColors.accent;
      case UrgencyLevel.flexible:
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(DemandStatus status) {
    switch (status) {
      case DemandStatus.draft:
        return 'Draft';
      case DemandStatus.posted:
        return 'Active';
      case DemandStatus.matched:
        return 'Matched';
      case DemandStatus.inTransaction:
        return 'In Progress';
      case DemandStatus.completed:
        return 'Fulfilled';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(DemandStatus status) {
    switch (status) {
      case DemandStatus.draft:
        return Colors.grey;
      case DemandStatus.posted:
        return AppColors.info;
      case DemandStatus.matched:
        return AppColors.accent;
      case DemandStatus.inTransaction:
        return AppColors.primary;
      case DemandStatus.completed:
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}