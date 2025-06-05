// lib/shared/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/mock_data.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  // For demo purposes - in real app this would be more secure
  bool get isAdmin => _currentUser?.role == UserRole.admin;
  bool get isSeller => _currentUser?.role == UserRole.seller;
  bool get isBuyer => _currentUser?.role == UserRole.buyer;

  // Enhanced crop search with Bengali support
  List<Crop> searchCropsEnhanced(String query) {
    if (query.isEmpty) return MockData.crops;

    final lowercaseQuery = query.toLowerCase();
    List<Crop> results = [];

    // Exact matches first
    results.addAll(MockData.crops.where((crop) =>
        crop.nameEn.toLowerCase() == lowercaseQuery));

    // Then prefix matches
    results.addAll(MockData.crops.where((crop) =>
        crop.nameEn.toLowerCase().startsWith(lowercaseQuery) ||
        crop.searchTerms.any((term) => term.toLowerCase().startsWith(lowercaseQuery))));

    // Finally contains matches
    results.addAll(MockData.crops.where((crop) =>
        crop.nameEn.toLowerCase().contains(lowercaseQuery) ||
        crop.searchTerms.any((term) => term.toLowerCase().contains(lowercaseQuery))));

    // Remove duplicates and return
    return results.toSet().toList();
  }

  // Mock authentication - in real app would use proper auth
  Future<bool> loginWithPhone(String phoneNumber, String otp) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Demo login - any phone number works
    if (phoneNumber.isNotEmpty && otp == '1234') {
      // Check if user exists in mock data
      User? existingUser;
      try {
        existingUser = MockData.sampleUsers.firstWhere(
          (user) => user.phone == phoneNumber,
        );
      } catch (e) {
        existingUser = User(
          id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
          name: 'New User',
          phone: phoneNumber,
          role: UserRole.seller, // Default role
          location: 'Dhaka, Bangladesh',
          createdAt: DateTime.now(),
        );
      }

      _currentUser = existingUser;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Admin login for web dashboard
  Future<bool> adminLogin(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    // Demo admin login
    if (username == 'admin' && password == 'admin123') {
      _currentUser = MockData.sampleUsers.firstWhere(
        (user) => user.role == UserRole.admin,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  UserRole _getRoleFromString(String roleString) {
    switch (roleString.toLowerCase()) {
      case 'seller':
        return UserRole.seller;
      case 'buyer':
        return UserRole.buyer;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.seller;
    }
  }

  void setUserRole(UserRole role, String name, String location) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        phone: _currentUser!.phone,
        role: role,
        location: location,
        createdAt: _currentUser!.createdAt,
      );
      notifyListeners();
    }
  }

  void updateUserProfile(String name, String location) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        phone: _currentUser!.phone,
        role: _currentUser!.role,
        location: location,
        createdAt: _currentUser!.createdAt,
      );
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Check if phone number exists in system
  Future<User?> checkExistingUser(String phoneNumber) async {
    await Future.delayed(Duration(milliseconds: 500));
    
    try {
      return MockData.sampleUsers.firstWhere(
        (user) => user.phone == phoneNumber,
      );
    } catch (e) {
      return null;
    }
  }

  // For demo - auto login as different user types
  void demoLoginAs(UserRole role) {
    switch (role) {
      case UserRole.admin:
        _currentUser = MockData.sampleUsers.firstWhere((u) => u.role == UserRole.admin);
        break;
      case UserRole.seller:
        _currentUser = MockData.sampleUsers.firstWhere((u) => u.role == UserRole.seller);
        break;
      case UserRole.buyer:
        _currentUser = MockData.sampleUsers.firstWhere((u) => u.role == UserRole.buyer);
        break;
    }
    notifyListeners();
  }
}