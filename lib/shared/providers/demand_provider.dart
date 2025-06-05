// lib/shared/providers/demand_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/mock_data.dart';

class DemandProvider with ChangeNotifier {
  List<Demand> _demands = [];
  bool _isLoading = false;
  String? _error;

  List<Demand> get demands => List.unmodifiable(_demands);
  bool get isLoading => _isLoading;
  String? get error => _error;

  DemandProvider() {
    _initializeData();
  }

  void _initializeData() {
    _demands = List.from(MockData.sampleDemands);
    notifyListeners();
  }

  // Get all demands (for admin dashboard)
  List<Demand> getAllDemands() {
    return _demands;
  }

  // Get demands by buyer
  List<Demand> getDemandsByBuyer(String buyerId) {
    return _demands.where((demand) => demand.buyerId == buyerId).toList();
  }

  // Get demands by status
  List<Demand> getDemandsByStatus(DemandStatus status) {
    return _demands.where((demand) => demand.status == status).toList();
  }

  // Get recent demands (for dashboard)
  List<Demand> getRecentDemands({int limit = 10}) {
    final sortedDemands = List<Demand>.from(_demands)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedDemands.take(limit).toList();
  }

  // Add new demand
  Future<bool> addDemand({
    required String buyerId,
    required String cropId,
    required String quantityNeeded,
    String? qualitySpecs,
    String? budgetRange,
    required UrgencyLevel urgency,
    required List<DeliveryOption> deliveryPreferences,
    required String location,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 1));

      final newDemand = Demand(
        id: 'demand_${DateTime.now().millisecondsSinceEpoch}',
        buyerId: buyerId,
        cropId: cropId,
        quantityNeeded: quantityNeeded,
        qualitySpecs: qualitySpecs,
        budgetRange: budgetRange,
        urgency: urgency,
        deliveryPreferences: deliveryPreferences,
        location: location,
        status: DemandStatus.posted,
        createdAt: DateTime.now(),
      );

      _demands.insert(0, newDemand);
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = 'Failed to create demand: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshDemands() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(Duration(seconds: 1));
    
    _initializeData();
    _isLoading = false;
    notifyListeners();
  }
}