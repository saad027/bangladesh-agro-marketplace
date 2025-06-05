// lib/data/mock_data.dart

import 'models/models.dart';

class MockData {
  static List<Crop> crops = [
    // Grains & Cereals
    Crop(id: 'rice', nameEn: 'Rice', nameBn: 'চাল', category: 'Grains & Cereals', searchTerms: ['rice', 'chal', 'ধান', 'dhan', 'ris', 'rys']),
    Crop(id: 'wheat', nameEn: 'Wheat', nameBn: 'গম', category: 'Grains & Cereals', searchTerms: ['wheat', 'gom', 'wheet', 'whit']),
    Crop(id: 'corn', nameEn: 'Corn', nameBn: 'ভুট্টা', category: 'Grains & Cereals', searchTerms: ['corn', 'bhutta', 'maize', 'corn', 'korn']),
    Crop(id: 'barley', nameEn: 'Barley', nameBn: 'যব', category: 'Grains & Cereals', searchTerms: ['barley', 'job', 'borley', 'barly']),
    Crop(id: 'oats', nameEn: 'Oats', nameBn: 'ওটস', category: 'Grains & Cereals', searchTerms: ['oats', 'ots', 'oat']),
    
    // Root & Tubers
    Crop(id: 'potato', nameEn: 'Potato', nameBn: 'আলু', category: 'Root & Tubers', searchTerms: ['potato', 'alu', 'aloo', 'poteto', 'patato']),
    Crop(id: 'sweet_potato', nameEn: 'Sweet Potato', nameBn: 'মিষ্টি আলু', category: 'Root & Tubers', searchTerms: ['sweet potato', 'mishti alu', 'swet potato']),
    Crop(id: 'cassava', nameEn: 'Cassava', nameBn: 'কাসাভা', category: 'Root & Tubers', searchTerms: ['cassava', 'kasava', 'casava']),
    Crop(id: 'turnip', nameEn: 'Turnip', nameBn: 'শালগম', category: 'Root & Tubers', searchTerms: ['turnip', 'shalgom', 'turnep']),
    Crop(id: 'radish', nameEn: 'Radish', nameBn: 'মুলা', category: 'Root & Tubers', searchTerms: ['radish', 'mula', 'radesh']),
    
    // Vegetables
    Crop(id: 'onion', nameEn: 'Onion', nameBn: 'পেঁয়াজ', category: 'Vegetables', searchTerms: ['onion', 'peyaj', 'piyaj', 'onyon']),
    Crop(id: 'tomato', nameEn: 'Tomato', nameBn: 'টমেটো', category: 'Vegetables', searchTerms: ['tomato', 'tometo', 'tamato']),
    Crop(id: 'cabbage', nameEn: 'Cabbage', nameBn: 'বাঁধাকপি', category: 'Vegetables', searchTerms: ['cabbage', 'bandhakopi', 'cabej']),
    Crop(id: 'cauliflower', nameEn: 'Cauliflower', nameBn: 'ফুলকপি', category: 'Vegetables', searchTerms: ['cauliflower', 'fulkopi', 'coliflower']),
    Crop(id: 'carrot', nameEn: 'Carrot', nameBn: 'গাজর', category: 'Vegetables', searchTerms: ['carrot', 'gajor', 'carot']),
    Crop(id: 'brinjal', nameEn: 'Brinjal', nameBn: 'বেগুন', category: 'Vegetables', searchTerms: ['brinjal', 'begun', 'eggplant', 'brinjel']),
    Crop(id: 'okra', nameEn: 'Okra', nameBn: 'ঢেঁড়স', category: 'Vegetables', searchTerms: ['okra', 'dheros', 'lady finger', 'okro']),
    Crop(id: 'cucumber', nameEn: 'Cucumber', nameBn: 'শসা', category: 'Vegetables', searchTerms: ['cucumber', 'shasha', 'cucamber']),
    Crop(id: 'bitter_gourd', nameEn: 'Bitter Gourd', nameBn: 'করলা', category: 'Vegetables', searchTerms: ['bitter gourd', 'korola', 'biter gord']),
    Crop(id: 'bottle_gourd', nameEn: 'Bottle Gourd', nameBn: 'লাউ', category: 'Vegetables', searchTerms: ['bottle gourd', 'lau', 'botel gord']),
    Crop(id: 'pumpkin', nameEn: 'Pumpkin', nameBn: 'কুমড়া', category: 'Vegetables', searchTerms: ['pumpkin', 'kumra', 'pampkin']),
    Crop(id: 'spinach', nameEn: 'Spinach', nameBn: 'পালং শাক', category: 'Vegetables', searchTerms: ['spinach', 'palong shak', 'spinech']),
    
    // Fruits
    Crop(id: 'mango', nameEn: 'Mango', nameBn: 'আম', category: 'Fruits', searchTerms: ['mango', 'aam', 'mango']),
    Crop(id: 'banana', nameEn: 'Banana', nameBn: 'কলা', category: 'Fruits', searchTerms: ['banana', 'kola', 'banena']),
    Crop(id: 'jackfruit', nameEn: 'Jackfruit', nameBn: 'কাঁঠাল', category: 'Fruits', searchTerms: ['jackfruit', 'kanthal', 'jakfruit']),
    Crop(id: 'litchi', nameEn: 'Litchi', nameBn: 'লিচু', category: 'Fruits', searchTerms: ['litchi', 'lichu', 'lichi']),
    Crop(id: 'guava', nameEn: 'Guava', nameBn: 'পেয়ারা', category: 'Fruits', searchTerms: ['guava', 'peyara', 'guwa']),
    Crop(id: 'papaya', nameEn: 'Papaya', nameBn: 'পেঁপে', category: 'Fruits', searchTerms: ['papaya', 'pepe', 'papya']),
    Crop(id: 'watermelon', nameEn: 'Watermelon', nameBn: 'তরমুজ', category: 'Fruits', searchTerms: ['watermelon', 'tormuj', 'watermelen']),
    Crop(id: 'orange', nameEn: 'Orange', nameBn: 'কমলা', category: 'Fruits', searchTerms: ['orange', 'komola', 'orenge']),
    Crop(id: 'lemon', nameEn: 'Lemon', nameBn: 'লেবু', category: 'Fruits', searchTerms: ['lemon', 'lebu', 'lemun']),
    
    // Pulses & Legumes
    Crop(id: 'lentil', nameEn: 'Lentil', nameBn: 'মসুর ডাল', category: 'Pulses & Legumes', searchTerms: ['lentil', 'masur', 'dal', 'lentol']),
    Crop(id: 'chickpea', nameEn: 'Chickpea', nameBn: 'ছোলা', category: 'Pulses & Legumes', searchTerms: ['chickpea', 'chola', 'boot', 'chikpea']),
    Crop(id: 'black_gram', nameEn: 'Black Gram', nameBn: 'কালো ডাল', category: 'Pulses & Legumes', searchTerms: ['black gram', 'kalo dal', 'blak gram']),
    Crop(id: 'green_gram', nameEn: 'Green Gram', nameBn: 'মুগ ডাল', category: 'Pulses & Legumes', searchTerms: ['green gram', 'mug dal', 'gren gram']),
    Crop(id: 'field_pea', nameEn: 'Field Pea', nameBn: 'মটর', category: 'Pulses & Legumes', searchTerms: ['field pea', 'motor', 'feld pea']),
    
    // Spices
    Crop(id: 'chili', nameEn: 'Chili', nameBn: 'মরিচ', category: 'Spices', searchTerms: ['chili', 'morich', 'pepper', 'chilli']),
    Crop(id: 'garlic', nameEn: 'Garlic', nameBn: 'রসুন', category: 'Spices', searchTerms: ['garlic', 'rosun', 'garlek']),
    Crop(id: 'ginger', nameEn: 'Ginger', nameBn: 'আদা', category: 'Spices', searchTerms: ['ginger', 'ada', 'ginjer']),
    Crop(id: 'turmeric', nameEn: 'Turmeric', nameBn: 'হলুদ', category: 'Spices', searchTerms: ['turmeric', 'holud', 'turmaric']),
    Crop(id: 'coriander', nameEn: 'Coriander', nameBn: 'ধনিয়া', category: 'Spices', searchTerms: ['coriander', 'dhoniya', 'coriender']),
    
    // Oilseeds
    Crop(id: 'mustard', nameEn: 'Mustard', nameBn: 'সরিষা', category: 'Oilseeds', searchTerms: ['mustard', 'shorisha', 'musterd']),
    Crop(id: 'sesame', nameEn: 'Sesame', nameBn: 'তিল', category: 'Oilseeds', searchTerms: ['sesame', 'til', 'seseme']),
    Crop(id: 'sunflower', nameEn: 'Sunflower', nameBn: 'সূর্যমুখী', category: 'Oilseeds', searchTerms: ['sunflower', 'surjomukhi', 'sunflowr']),
    Crop(id: 'groundnut', nameEn: 'Groundnut', nameBn: 'চিনাবাদাম', category: 'Oilseeds', searchTerms: ['groundnut', 'chinabadam', 'peanut', 'groundnet']),
  ];

  static List<User> sampleUsers = [
    User(
      id: 'admin_1',
      name: 'Admin User',
      phone: '+8801700000000',
      role: UserRole.admin,
      location: 'Dhaka, Bangladesh',
      createdAt: DateTime.now().subtract(Duration(days: 30)),
    ),
    User(
      id: 'seller_1',
      name: 'Rahman Farmer',
      phone: '+8801711111111',
      role: UserRole.seller,
      location: 'Bogura, Rajshahi',
      createdAt: DateTime.now().subtract(Duration(days: 15)),
    ),
    User(
      id: 'seller_2',
      name: 'Karim Agriculture',
      phone: '+8801722222222',
      role: UserRole.seller,
      location: 'Munshiganj, Dhaka',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
    ),
    User(
      id: 'seller_3',
      name: 'Fatema Begum',
      phone: '+8801733333333',
      role: UserRole.seller,
      location: 'Jessore, Khulna',
      createdAt: DateTime.now().subtract(Duration(hours: 6)),
    ),
    User(
      id: 'buyer_1',
      name: 'Dhaka Traders',
      phone: '+8801744444444',
      role: UserRole.buyer,
      location: 'Dhanmondi, Dhaka',
      createdAt: DateTime.now().subtract(Duration(days: 8)),
    ),
    User(
      id: 'buyer_2',
      name: 'Port City Foods',
      phone: '+8801755555555',
      role: UserRole.buyer,
      location: 'Chittagong, Chittagong',
      createdAt: DateTime.now().subtract(Duration(days: 12)),
    ),
  ];

  static List<Listing> sampleListings = [
    Listing(
      id: 'listing_1',
      sellerId: 'seller_1',
      cropId: 'rice',
      quantity: '50 kg',
      qualityNotes: 'Fresh harvest, Grade A quality',
      pricePerUnit: '৳45/kg',
      imageUrls: ['https://example.com/rice1.jpg', 'https://example.com/rice2.jpg'],
      deliveryOptions: [DeliveryOption.delivery, DeliveryOption.pickup],
      location: 'Bogura, Rajshahi',
      status: ListingStatus.posted,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Listing(
      id: 'listing_2',
      sellerId: 'seller_2',
      cropId: 'potato',
      quantity: '100 kg',
      qualityNotes: 'Medium size, good for cooking',
      pricePerUnit: '৳25/kg',
      imageUrls: ['https://example.com/potato1.jpg'],
      deliveryOptions: [DeliveryOption.pickup],
      location: 'Munshiganj, Dhaka',
      status: ListingStatus.posted,
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
    ),
    Listing(
      id: 'listing_3',
      sellerId: 'seller_3',
      cropId: 'tomato',
      quantity: '30 kg',
      qualityNotes: 'Ripe red tomatoes, perfect for market',
      pricePerUnit: '৳60/kg',
      imageUrls: ['https://example.com/tomato1.jpg', 'https://example.com/tomato2.jpg'],
      deliveryOptions: [DeliveryOption.delivery],
      location: 'Jessore, Khulna',
      status: ListingStatus.posted,
      createdAt: DateTime.now().subtract(Duration(minutes: 30)),
    ),
  ];

  static List<Demand> sampleDemands = [
    Demand(
      id: 'demand_1',
      buyerId: 'buyer_1',
      cropId: 'rice',
      quantityNeeded: '200 kg',
      qualitySpecs: 'Parboiled rice, medium grain',
      budgetRange: '৳40-45/kg',
      urgency: UrgencyLevel.urgent,
      deliveryPreferences: [DeliveryOption.pickup],
      location: 'Dhanmondi, Dhaka',
      status: DemandStatus.posted,
      createdAt: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Demand(
      id: 'demand_2',
      buyerId: 'buyer_2',
      cropId: 'onion',
      quantityNeeded: '80 kg',
      qualitySpecs: 'Fresh onions, medium to large size',
      budgetRange: '৳35-40/kg',
      urgency: UrgencyLevel.week,
      deliveryPreferences: [DeliveryOption.delivery],
      location: 'Chittagong, Chittagong',
      status: DemandStatus.posted,
      createdAt: DateTime.now().subtract(Duration(hours: 3)),
    ),
  ];

  // Helper methods
  static Crop? getCropById(String id) {
    try {
      return crops.firstWhere((crop) => crop.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Crop> getCropsByCategory(String category) {
    return crops.where((crop) => crop.category == category).toList();
  }

  static List<Crop> searchCrops(String query) {
    if (query.isEmpty) return crops;
    
    final lowercaseQuery = query.toLowerCase();
    return crops.where((crop) {
      return crop.nameEn.toLowerCase().contains(lowercaseQuery) ||
             crop.nameBn.contains(query) ||
             crop.searchTerms.any((term) => term.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  static User? getUserById(String id) {
    try {
      return sampleUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Listing> getListingsBySeller(String sellerId) {
    return sampleListings.where((listing) => listing.sellerId == sellerId).toList();
  }

  static List<Demand> getDemandsByBuyer(String buyerId) {
    return sampleDemands.where((demand) => demand.buyerId == buyerId).toList();
  }

  static List<String> getCropCategories() {
    return crops.map((crop) => crop.category).toSet().toList()..sort();
  }

  // Generate some real-time data for demo
  static void addNewListing(Listing listing) {
    sampleListings.insert(0, listing);
  }

  static void addNewDemand(Demand demand) {
    sampleDemands.insert(0, demand);
  }

  // Admin dashboard stats
  static Map<String, int> getDashboardStats() {
    return {
      'totalSellers': sampleUsers.where((u) => u.role == UserRole.seller).length,
      'totalBuyers': sampleUsers.where((u) => u.role == UserRole.buyer).length,
      'activeListings': sampleListings.where((l) => l.status == ListingStatus.posted).length,
      'activeDemands': sampleDemands.where((d) => d.status == DemandStatus.posted).length,
      'totalCrops': crops.length,
    };
  }
}