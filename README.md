# 🌾 Bangladesh Agro Marketplace

Agricultural marketplace connecting farmers (sellers) and buyers in Bangladesh through admin-mediated matching.

## 🚀 Current Status - Version 1

**✅ Working Demo Features:**
- 📱 **Mobile App**: Login flow, Seller/Buyer dashboards with role switching
- 🖥️ **Admin Web Dashboard**: Live matching interface with real-time view
- 🔄 **State Management**: Shared providers across mobile and web
- 🇧🇩 **Bangladesh Focus**: Bengali crop names, local currency (৳), regional data

## 📱 Mobile App Features

### Authentication Flow
- Phone number + OTP login (demo OTP: 1234)
- Role-based routing to appropriate dashboard
- Seamless switching between Seller ↔ Buyer modes

### Seller Dashboard
- Welcome screen with user stats
- "Create New Listing" button (placeholder)
- Recent listings display
- Top-right menu: Switch to Buyer, Profile, Logout

### Buyer Dashboard  
- Welcome screen with demand stats
- "Post New Demand" button (placeholder)
- Recent demands display
- Top-right menu: Switch to Seller, Profile, Logout

## 🖥️ Admin Web Dashboard Features

### Live Matching Interface
- **Left Panel**: Active sellers with crop listings
- **Right Panel**: Buyer demands and requirements
- **Real-time Updates**: Instant visibility of new posts
- **Bangladesh Data**: Rice, Potato, Tomato, Onion, etc. with Bengali names

### Admin Login
- Username: `admin`
- Password: `admin123`
- Separate web interface for admin operations

## 🛠️ Technical Architecture

### Core Structure
```
lib/
├── main.dart                 # Mobile app entry point
├── main_admin.dart          # Admin web dashboard entry point
├── data/
│   ├── models/models.dart   # User, Crop, Listing, Demand, Match classes
│   └── mock_data.dart       # Sample Bangladesh agricultural data
├── shared/
│   ├── providers/           # State management (Auth, Listing, Demand, Admin)
│   └── theme/              # Colors and text styles
├── presentation/screens/    # Mobile UI screens
└── admin/screens/          # Admin web UI screens
```

### State Management
- **Provider Pattern** for state management
- **Shared Providers** between mobile and admin interfaces
- **Mock Data** with 12 Bangladesh crops (Rice, Potato, etc.)

## 🚀 How to Run

### Mobile App (Sellers & Buyers)
```bash
flutter run
```

### Admin Web Dashboard
```bash
flutter run -d chrome -t lib/main_admin.dart
```

## 🎯 Demo Flow

1. **Mobile Login**: Enter any phone number → OTP: 1234
2. **Role Selection**: Choose Seller or Buyer mode  
3. **Dashboard**: Use top-right menu to switch modes
4. **Admin**: Login to web dashboard to see live user activity
5. **Matching**: Admin can view sellers and buyers for manual matching

## 📋 Next Features (Version 2)

**High Priority:**
- 📷 **Create Listing Screen** - Camera, crop selection, details
- 📝 **Create Demand Screen** - Search crops, set requirements  
- 🔄 **Real-time Sync** - Mobile posts appear instantly in admin
- 🤝 **Actual Matching** - Admin can connect sellers to buyers
- 📲 **Notifications** - Match alerts sent to both parties

**Future Enhancements:**
- Image upload and storage
- Push notification system
- Transaction tracking
- User profiles and ratings
- Advanced search and filters

## 🇧🇩 Bangladesh Agricultural Data

**Included Crops:**
- ধান/Rice (চাল) - Grains & Cereals
- আলু/Potato - Root & Tubers  
- পেঁয়াজ/Onion - Vegetables
- টমেটো/Tomato - Vegetables
- গম/Wheat - Grains & Cereals
- ভুট্টা/Corn - Grains & Cereals
- মসুর ডাল/Lentil - Pulses & Legumes
- And more...

**Features:**
- Bilingual search (English + Bengali)
- Regional location data
- Local currency (৳) pricing
- Bangladesh-specific delivery options

---

*Built with Flutter • State Management with Provider • Responsive Design*