// lib/shared/providers/listing_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/mock_data.dart';

class ListingProvider with ChangeNotifier {
  List<Listing> _listings = [];
  bool _isLoading = false;
  String? _error;

  List<Listing> get listings => List.unmodifiable(_listings);
  bool get isLoading => _isLoading;
  String? get error => _error;

  ListingProvider() {
    _initializeData();
  }

  void _initializeData() {
    _listings = List.from(MockData.sampleListings);
    notifyListeners();
  }

  // Get all listings (for admin dashboard)
  List<Listing> getAllListings() {
    return _listings;
  }

  // Get listings by seller
  List<Listing> getListingsBySeller(String sellerId) {
    return _listings.where((listing) => listing.sellerId == sellerId).toList();
  }

  // Get user listings (alias for getListingsBySeller for consistency)
  List<Listing> getUserListings(String userId) {
    return getListingsBySeller(userId);
  }

  // Get listings by status
  List<Listing> getListingsByStatus(ListingStatus status) {
    return _listings.where((listing) => listing.status == status).toList();
  }

  // Get listings by crop
  List<Listing> getListingsByCrop(String cropId) {
    return _listings.where((listing) => listing.cropId == cropId).toList();
  }

  // Get recent listings (for dashboard)
  List<Listing> getRecentListings({int limit = 10}) {
    final sortedListings = List<Listing>.from(_listings)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedListings.take(limit).toList();
  }

  // Search listings
  List<Listing> searchListings(String query) {
    if (query.isEmpty) return _listings;

    final lowercaseQuery = query.toLowerCase();
    return _listings.where((listing) {
      final crop = MockData.getCropById(listing.cropId);
      return crop?.nameEn.toLowerCase().contains(lowercaseQuery) == true ||
             crop?.nameBn.contains(query) == true ||
             listing.location.toLowerCase().contains(lowercaseQuery) ||
             listing.quantity.toLowerCase().contains(lowercaseQuery) ||
             (listing.qualityNotes?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  // Add new listing
  Future<bool> addListing({
    required String sellerId,
    required String cropId,
    required String quantity,
    String? qualityNotes,
    String? pricePerUnit,
    required List<String> imageUrls,
    required List<DeliveryOption> deliveryOptions,
    required String location,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      final newListing = Listing(
        id: 'listing_${DateTime.now().millisecondsSinceEpoch}',
        sellerId: sellerId,
        cropId: cropId,
        quantity: quantity,
        qualityNotes: qualityNotes,
        pricePerUnit: pricePerUnit,
        imageUrls: imageUrls,
        deliveryOptions: deliveryOptions,
        location: location,
        status: ListingStatus.posted,
        createdAt: DateTime.now(),
      );

      _listings.insert(0, newListing);
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = 'Failed to create listing: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update listing
  Future<bool> updateListing(String listingId, {
    String? quantity,
    String? qualityNotes,
    String? pricePerUnit,
    List<String>? imageUrls,
    List<DeliveryOption>? deliveryOptions,
    String? location,
    ListingStatus? status,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 500));

      final index = _listings.indexWhere((listing) => listing.id == listingId);
      if (index == -1) {
        throw Exception('Listing not found');
      }

      final existingListing = _listings[index];
      final updatedListing = Listing(
        id: existingListing.id,
        sellerId: existingListing.sellerId,
        cropId: existingListing.cropId,
        quantity: quantity ?? existingListing.quantity,
        qualityNotes: qualityNotes ?? existingListing.qualityNotes,
        pricePerUnit: pricePerUnit ?? existingListing.pricePerUnit,
        imageUrls: imageUrls ?? existingListing.imageUrls,
        deliveryOptions: deliveryOptions ?? existingListing.deliveryOptions,
        location: location ?? existingListing.location,
        status: status ?? existingListing.status,
        createdAt: existingListing.createdAt,
        updatedAt: DateTime.now(),
      );

      _listings[index] = updatedListing;
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = 'Failed to update listing: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete listing
  Future<bool> deleteListing(String listingId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 500));
      
      _listings.removeWhere((listing) => listing.id == listingId);
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = 'Failed to delete listing: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Change listing status (for admin)
  Future<bool> updateListingStatus(String listingId, ListingStatus newStatus) async {
    return updateListing(listingId, status: newStatus);
  }

  // Get listing by ID
  Listing? getListingById(String listingId) {
    try {
      return _listings.firstWhere((listing) => listing.id == listingId);
    } catch (e) {
      return null;
    }
  }

  // Get statistics for admin dashboard
  Map<String, dynamic> getListingStatistics() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisWeek = now.subtract(Duration(days: 7));
    final thisMonth = DateTime(now.year, now.month, 1);

    return {
      'total': _listings.length,
      'posted': _listings.where((l) => l.status == ListingStatus.posted).length,
      'matched': _listings.where((l) => l.status == ListingStatus.matched).length,
      'completed': _listings.where((l) => l.status == ListingStatus.completed).length,
      'today': _listings.where((l) => l.createdAt.isAfter(today)).length,
      'thisWeek': _listings.where((l) => l.createdAt.isAfter(thisWeek)).length,
      'thisMonth': _listings.where((l) => l.createdAt.isAfter(thisMonth)).length,
    };
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshListings() async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate API refresh
    await Future.delayed(Duration(seconds: 1));
    
    _initializeData();
    _isLoading = false;
    notifyListeners();
  }
}