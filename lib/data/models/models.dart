// lib/data/models/models.dart

enum UserRole { seller, buyer, admin }

enum ListingStatus { draft, posted, matched, inTransaction, completed, cancelled }

enum DemandStatus { draft, posted, matched, inTransaction, completed, cancelled }

enum DeliveryOption { pickup, delivery }

enum UrgencyLevel { urgent, week, flexible }

class User {
  final String id;
  final String name;
  final String phone;
  final UserRole role;
  final String location;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.location,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role.toString(),
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: UserRole.values.firstWhere((e) => e.toString() == json['role']),
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Crop {
  final String id;
  final String nameEn;
  final String nameBn;
  final String category;
  final List<String> searchTerms;
  final String? imageUrl;

  Crop({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.category,
    required this.searchTerms,
    this.imageUrl,
  });

  String get displayName => '$nameEn ($nameBn)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameBn': nameBn,
      'category': category,
      'searchTerms': searchTerms,
      'imageUrl': imageUrl,
    };
  }

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      nameEn: json['nameEn'],
      nameBn: json['nameBn'],
      category: json['category'],
      searchTerms: List<String>.from(json['searchTerms']),
      imageUrl: json['imageUrl'],
    );
  }
}

class Listing {
  final String id;
  final String sellerId;
  final String cropId;
  final String quantity;
  final String? qualityNotes;
  final String? pricePerUnit;
  final List<String> imageUrls;
  final List<DeliveryOption> deliveryOptions;
  final String location;
  final ListingStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Listing({
    required this.id,
    required this.sellerId,
    required this.cropId,
    required this.quantity,
    this.qualityNotes,
    this.pricePerUnit,
    required this.imageUrls,
    required this.deliveryOptions,
    required this.location,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'cropId': cropId,
      'quantity': quantity,
      'qualityNotes': qualityNotes,
      'pricePerUnit': pricePerUnit,
      'imageUrls': imageUrls,
      'deliveryOptions': deliveryOptions.map((e) => e.toString()).toList(),
      'location': location,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'],
      sellerId: json['sellerId'],
      cropId: json['cropId'],
      quantity: json['quantity'],
      qualityNotes: json['qualityNotes'],
      pricePerUnit: json['pricePerUnit'],
      imageUrls: List<String>.from(json['imageUrls']),
      deliveryOptions: (json['deliveryOptions'] as List)
          .map((e) => DeliveryOption.values.firstWhere((v) => v.toString() == e))
          .toList(),
      location: json['location'],
      status: ListingStatus.values.firstWhere((e) => e.toString() == json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class Demand {
  final String id;
  final String buyerId;
  final String cropId;
  final String quantityNeeded;
  final String? qualitySpecs;
  final String? budgetRange;
  final UrgencyLevel urgency;
  final List<DeliveryOption> deliveryPreferences;
  final String location;
  final DemandStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Demand({
    required this.id,
    required this.buyerId,
    required this.cropId,
    required this.quantityNeeded,
    this.qualitySpecs,
    this.budgetRange,
    required this.urgency,
    required this.deliveryPreferences,
    required this.location,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'cropId': cropId,
      'quantityNeeded': quantityNeeded,
      'qualitySpecs': qualitySpecs,
      'budgetRange': budgetRange,
      'urgency': urgency.toString(),
      'deliveryPreferences': deliveryPreferences.map((e) => e.toString()).toList(),
      'location': location,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Demand.fromJson(Map<String, dynamic> json) {
    return Demand(
      id: json['id'],
      buyerId: json['buyerId'],
      cropId: json['cropId'],
      quantityNeeded: json['quantityNeeded'],
      qualitySpecs: json['qualitySpecs'],
      budgetRange: json['budgetRange'],
      urgency: UrgencyLevel.values.firstWhere((e) => e.toString() == json['urgency']),
      deliveryPreferences: (json['deliveryPreferences'] as List)
          .map((e) => DeliveryOption.values.firstWhere((v) => v.toString() == e))
          .toList(),
      location: json['location'],
      status: DemandStatus.values.firstWhere((e) => e.toString() == json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class Match {
  final String id;
  final String listingId;
  final String demandId;
  final String sellerId;
  final String buyerId;
  final String adminId;
  final String? adminNotes;
  final MatchStatus status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;

  Match({
    required this.id,
    required this.listingId,
    required this.demandId,
    required this.sellerId,
    required this.buyerId,
    required this.adminId,
    this.adminNotes,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'demandId': demandId,
      'sellerId': sellerId,
      'buyerId': buyerId,
      'adminId': adminId,
      'adminNotes': adminNotes,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      listingId: json['listingId'],
      demandId: json['demandId'],
      sellerId: json['sellerId'],
      buyerId: json['buyerId'],
      adminId: json['adminId'],
      adminNotes: json['adminNotes'],
      status: MatchStatus.values.firstWhere((e) => e.toString() == json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      acceptedAt: json['acceptedAt'] != null ? DateTime.parse(json['acceptedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    );
  }
}

enum MatchStatus { 
  created,        // Admin just created the match
  notificationsSent, // Notifications sent to both parties
  sellerAccepted, // Seller accepted
  buyerAccepted,  // Buyer accepted
  bothAccepted,   // Both accepted, transaction can begin
  inProgress,     // Transaction in progress
  completed,      // Successfully completed
  cancelled       // Either party or admin cancelled
}