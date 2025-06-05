
flutter run for testing on phone (usb debugging on)

flutter run -d chrome lib/main_admin.dart for testing on chrome (admin dashboard)

Sorry for the AI slop below!
---------------------------------------------------------
# 🌾 Bangladesh Agro Marketplace

An agricultural marketplace Flutter app connecting farmers, buyers, and administrators in Bangladesh. This is a prototype demonstrating real-time crop listing management and matching system.

## 🚀 Features

### 📱 Mobile App (Sellers & Buyers)
- **Authentication**: Phone number + OTP verification
- **Role Selection**: Choose between Seller or Buyer
- **Create Listings**: Sellers can post crops with photos, quantities, and prices
- **Create Demands**: Buyers can post their crop requirements
- **Bilingual Support**: English and Bengali crop names
- **Real-time Updates**: Instant visibility to admin dashboard

### 🖥️ Web Admin Dashboard
- **Live Matching Interface**: Real-time view of all listings and demands
- **Smart Matching**: Automated suggestions for matching buyers with sellers
- **Statistics Dashboard**: User counts, listing stats, transaction metrics
- **Professional UI**: Optimized for desktop admin workflow

## 🛠️ Tech Stack

- **Framework**: Flutter (Mobile + Web)
- **State Management**: Provider
- **UI Theme**: Custom agricultural theme with green colors
- **Authentication**: Mock phone + OTP (demo ready)
- **Data**: Mock data with 40+ Bangladesh crops

## 🎯 Demo Flow

1. **📱 Mobile Seller**: Login (1234) → Create Listing → Upload rice photo → Publish
2. **🖥️ Web Admin**: `flutter run -d chrome` → See rice listing appear instantly
3. **📱 Mobile Buyer**: Login (other number) → Role selection → Create demand
4. **🖥️ Admin**: Match seller rice with buyer demand → Send notifications
5. **📱 Both**: Receive match notifications → Complete transaction

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Chrome browser (for web admin dashboard)
- Android device/emulator (for mobile app)

### Installation

```bash
# Clone the repository
git clone https://github.com/saad027/bangladesh-agro-marketplace.git
cd bangladesh-agro-marketplace

# Install dependencies
flutter pub get

# Run mobile app
flutter run

# Run web admin dashboard
flutter run -d chrome
```

## 📱 Demo Accounts

### Mobile App Login
- **Existing Seller**: Phone `1234`, OTP `1234`
- **New User**: Any other phone number, OTP `1234`
- **Admin**: Use web dashboard directly (no mobile login)

### Web Admin Dashboard
- Direct access via `flutter run -d chrome`
- No login required for demo

## 🏗️ Project Structure

```
lib/
├── data/
│   ├── models/models.dart          # Data models (User, Crop, Listing, etc.)
│   └── mock_data.dart              # Sample data with Bangladesh crops
├── shared/
│   ├── providers/                  # State management
│   │   ├── auth_provider.dart      # Authentication logic
│   │   ├── listing_provider.dart   # Crop listings management
│   │   ├── demand_provider.dart    # Buyer demands management
│   │   └── admin_provider.dart     # Admin matching logic
│   └── theme/                      # App styling
│       ├── app_colors.dart         # Color scheme
│       └── app_text_styles.dart    # Typography
├── presentation/screens/
│   ├── auth/                       # Authentication screens
│   ├── seller/                     # Seller-specific screens
│   ├── buyer/                      # Buyer-specific screens
│   └── admin/                      # Admin dashboard
└── main.dart                       # App entry point
```

## 🌾 Supported Crops

The app includes 40+ common Bangladesh crops with bilingual support:

**Categories:**
- 🌾 Grains & Cereals (Rice, Wheat, Corn, etc.)
- 🥔 Root & Tubers (Potato, Sweet Potato, etc.)
- 🥬 Vegetables (Onion, Tomato, Cabbage, etc.)
- 🍎 Fruits (Mango, Banana, Jackfruit, etc.)
- 🫘 Pulses & Legumes (Lentil, Chickpea, etc.)
- 🌶️ Spices (Chili, Garlic, Ginger, etc.)
- 🌻 Oilseeds (Mustard, Sesame, etc.)

## 🔧 Development

### Adding New Features

1. **Models**: Add new data models in `lib/data/models/`
2. **Providers**: Add state management in `lib/shared/providers/`
3. **Screens**: Add UI screens in `lib/presentation/screens/`
4. **Mock Data**: Update sample data in `lib/data/mock_data.dart`

### Building for Production

```bash
# Build mobile APK
flutter build apk --release

# Build web app
flutter build web --release

# Build iOS (requires macOS)
flutter build ios --release
```

## 🎨 Design System

### Colors
- **Primary**: Green theme appropriate for agriculture
- **Secondary**: Orange accents for highlights
- **Background**: Light green tints
- **Text**: High contrast for readability

### Typography
- **Roboto** font family
- Responsive text sizes
- Bengali text support

## 📊 Current Status

✅ **Complete (80%)**
- Authentication flow
- Data models and providers
- Seller listing creation
- Admin dashboard UI
- Role-based navigation
- Bilingual crop search

🔧 **In Progress (20%)**
- Buyer dashboard completion
- Real-time data synchronization
- Push notifications
- Advanced matching algorithms

## 🔮 Future Enhancements

- **Backend Integration**: Replace mock data with real API
- **Real Authentication**: Implement actual phone verification
- **Push Notifications**: FCM integration
- **Payment System**: bKash/Nagad integration
- **Geolocation**: GPS-based farmer location
- **Image Recognition**: AI crop identification
- **Offline Support**: Local data caching
- **Multi-language**: Full Bengali localization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Developer**: Built for agricultural marketplace demonstration
- **Target Users**: Farmers, Buyers, Market Administrators in Bangladesh

## 📞 Support

For questions or support:
- Create an issue in this repository
- Contact the development team

---

**🌾 Connecting Bangladesh's farmers with buyers, one crop at a time! 🌾**
