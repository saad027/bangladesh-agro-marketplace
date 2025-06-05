// lib/shared/providers/admin_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/mock_data.dart';

class AdminProvider with ChangeNotifier {
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _error;

  List<Match> get matches => List.unmodifiable(_matches);
  bool get isLoading => _isLoading;
  String? get error => _error;

  AdminProvider() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize with empty matches for demo
    _matches = [];
    notifyListeners();
  }

  // Create a new match between listing and demand
  Future<bool> createMatch({
    required String listingId,
    required String demandId,
    required String adminId,
    String? adminNotes,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 1));

      // Get listing and demand details to extract seller and buyer IDs
      final listing = MockData.sampleListings.firstWhere((l) => l.id == listingId);
      final demand = MockData.sampleDemands.firstWhere((d) => d.id == demandId);

      final newMatch = Match(
        id: 'match_${DateTime.now().millisecondsSinceEpoch}',
        listingId: listingId,
        demandId: demandId,
        sellerId: listing.sellerId,
        buyerId: demand.buyerId,
        adminId: adminId,
        adminNotes: adminNotes,
        status: MatchStatus.created,
        createdAt: DateTime.now(),
      );

      _matches.insert(0, newMatch);
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _error = 'Failed to create match: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update match status
  Future<bool> updateMatchStatus(String matchId, MatchStatus newStatus) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 500));

      final index = _matches.indexWhere((match) => match.id == matchId);
      if (index == -1) {
        throw Exception('Match not found');
      }

      final existingMatch = _matches[index];
      final updatedMatch = Match(
        id: existingMatch.id,
        listingId: existingMatch.listingId,
        demandId: existingMatch.demandId,
        sellerId: existingMatch.sellerId,
        buyerId: existingMatch.buyerId,
        adminId: existingMatch.adminId,
        adminNotes: existingMatch.adminNotes,
        status: newStatus,
        createdAt: existingMatch.createdAt,
        acceptedAt: newStatus == MatchStatus.bothAccepted ? DateTime.now() : existingMatch.acceptedAt,
        completedAt: newStatus == MatchStatus.completed ? DateTime.now() : existingMatch.completedAt,
      );

      _matches[index] = updatedMatch;
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _error = 'Failed to update match status: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get dashboard statistics
  Map<String, dynamic> getAdminStatistics(List<Listing> listings, List<Demand> demands) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisWeek = now.subtract(Duration(days: 7));

    final users = MockData.sampleUsers;

    return {
      'users': {
        'totalSellers': users.where((u) => u.role == UserRole.seller).length,
        'totalBuyers': users.where((u) => u.role == UserRole.buyer).length,
        'totalUsers': users.length,
      },
      'listings': {
        'total': listings.length,
        'posted': listings.where((l) => l.status == ListingStatus.posted).length,
        'today': listings.where((l) => l.createdAt.isAfter(today)).length,
      },
      'demands': {
        'total': demands.length,
        'posted': demands.where((d) => d.status == DemandStatus.posted).length,
        'urgent': demands.where((d) => d.urgency == UrgencyLevel.urgent).length,
      },
      'matches': {
        'total': _matches.length,
        'pending': _matches.where((m) => m.status == MatchStatus.created).length,
        'completed': _matches.where((m) => m.status == MatchStatus.completed).length,
      },
    };
  }

  // Find potential matches between listings and demands
  List<Map<String, dynamic>> findPotentialMatches(List<Listing> listings, List<Demand> demands) {
    List<Map<String, dynamic>> potentialMatches = [];

    for (var demand in demands.where((d) => d.status == DemandStatus.posted)) {
      for (var listing in listings.where((l) => l.status == ListingStatus.posted)) {
        // Check if they match
        if (listing.cropId == demand.cropId) {
          // Check delivery compatibility
          final hasCompatibleDelivery = demand.deliveryPreferences.any(
            (demandPref) => listing.deliveryOptions.contains(demandPref)
          );
          
          if (hasCompatibleDelivery) {
            // Calculate compatibility score
            int score = 100;
            
            // Urgency bonus
            if (demand.urgency == UrgencyLevel.urgent) {
              score += 15;
            }
            
            // Recent listings get priority
            if (listing.createdAt.isAfter(DateTime.now().subtract(Duration(hours: 24)))) {
              score += 10;
            }

            potentialMatches.add({
              'listing': listing,
              'demand': demand,
              'score': score,
              'crop': MockData.getCropById(listing.cropId),
              'seller': MockData.getUserById(listing.sellerId),
              'buyer': MockData.getUserById(demand.buyerId),
            });
          }
        }
      }
    }

    // Sort by score (highest first)
    potentialMatches.sort((a, b) => b['score'].compareTo(a['score']));
    
    return potentialMatches;
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}