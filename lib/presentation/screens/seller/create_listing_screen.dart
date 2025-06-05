import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/providers/listing_provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../data/models/models.dart';
import '../../../data/mock_data.dart';

class CreateListingScreen extends StatefulWidget {
  @override
  _CreateListingScreenState createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _qualityController = TextEditingController();
  final _locationController = TextEditingController();
  
  Crop? _selectedCrop;
  List<DeliveryOption> _deliveryOptions = [];
  List<String> _imageUrls = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _locationController.text = user?.location ?? 'Dhaka, Bangladesh';
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _qualityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Listing'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Crop Selection
            Text('Select Crop', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            DropdownButtonFormField<Crop>(
              value: _selectedCrop,
              decoration: InputDecoration(
                hintText: 'Choose a crop',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: MockData.crops.map((crop) {
                return DropdownMenuItem(
                  value: crop,
                  child: Text(crop.displayName),
                );
              }).toList(),
              onChanged: (crop) {
                setState(() {
                  _selectedCrop = crop;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a crop';
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            // Quantity
            Text('Quantity', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                hintText: 'e.g., 50 kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity';
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            // Price (Optional)
            Text('Price per Unit (Optional)', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                hintText: 'e.g., ৳45/kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Quality Notes (Optional)
            Text('Quality Notes (Optional)', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _qualityController,
              decoration: InputDecoration(
                hintText: 'e.g., Fresh harvest, Grade A quality',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),

            SizedBox(height: 16),

            // Delivery Options
            Text('Delivery Options', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            CheckboxListTile(
              title: Text('I can deliver'),
              value: _deliveryOptions.contains(DeliveryOption.delivery),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _deliveryOptions.add(DeliveryOption.delivery);
                  } else {
                    _deliveryOptions.remove(DeliveryOption.delivery);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Pickup only'),
              value: _deliveryOptions.contains(DeliveryOption.pickup),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _deliveryOptions.add(DeliveryOption.pickup);
                  } else {
                    _deliveryOptions.remove(DeliveryOption.pickup);
                  }
                });
              },
            ),

            SizedBox(height: 16),

            // Location
            Text('Location', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter location';
                }
                return null;
              },
            ),

            SizedBox(height: 24),

            // Photo Upload Placeholder
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 48, color: AppColors.textSecondary),
                  SizedBox(height: 8),
                  Text('Photo upload coming soon!', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _isLoading ? null : _submitListing,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Publish Listing', style: AppTextStyles.buttonLarge),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_deliveryOptions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one delivery option'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = Provider.of<AuthProvider>(context, listen: false).currentUser!;
      final listingProvider = Provider.of<ListingProvider>(context, listen: false);

      final success = await listingProvider.addListing(
        sellerId: user.id,
        cropId: _selectedCrop!.id,
        quantity: _quantityController.text.trim(),
        qualityNotes: _qualityController.text.trim().isNotEmpty ? _qualityController.text.trim() : null,
        pricePerUnit: _priceController.text.trim().isNotEmpty ? _priceController.text.trim() : null,
        imageUrls: _imageUrls.isNotEmpty ? _imageUrls : ['placeholder_image.jpg'],
        deliveryOptions: _deliveryOptions,
        location: _locationController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Listing created successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create listing'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}