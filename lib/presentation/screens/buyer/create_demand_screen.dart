import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/providers/demand_provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../data/models/models.dart';
import '../../../data/mock_data.dart';

class CreateDemandScreen extends StatefulWidget {
  @override
  _CreateDemandScreenState createState() => _CreateDemandScreenState();
}

class _CreateDemandScreenState extends State<CreateDemandScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _budgetController = TextEditingController();
  final _qualityController = TextEditingController();
  final _locationController = TextEditingController();
  
  Crop? _selectedCrop;
  UrgencyLevel _urgency = UrgencyLevel.flexible;
  List<DeliveryOption> _deliveryPreferences = [];
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
    _budgetController.dispose();
    _qualityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Demand'),
        backgroundColor: AppColors.info,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Crop Selection
            Text('Crop Needed', style: AppTextStyles.inputLabel),
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
            Text('Quantity Needed', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                hintText: 'e.g., 200 kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity needed';
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            // Budget Range (Optional)
            Text('Budget Range (Optional)', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _budgetController,
              decoration: InputDecoration(
                hintText: 'e.g., ৳40-45/kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Quality Specifications (Optional)
            Text('Quality Specifications (Optional)', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            TextFormField(
              controller: _qualityController,
              decoration: InputDecoration(
                hintText: 'e.g., Parboiled rice, medium grain',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),

            SizedBox(height: 16),

            // Urgency Level
            Text('Urgency Level', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            DropdownButtonFormField<UrgencyLevel>(
              value: _urgency,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: UrgencyLevel.urgent,
                  child: Text('Urgent (Today)'),
                ),
                DropdownMenuItem(
                  value: UrgencyLevel.week,
                  child: Text('This Week'),
                ),
                DropdownMenuItem(
                  value: UrgencyLevel.flexible,
                  child: Text('Flexible'),
                ),
              ],
              onChanged: (urgency) {
                setState(() {
                  _urgency = urgency!;
                });
              },
            ),

            SizedBox(height: 16),

            // Delivery Preferences
            Text('Delivery Preferences', style: AppTextStyles.inputLabel),
            SizedBox(height: 8),
            CheckboxListTile(
              title: Text('I can pickup'),
              value: _deliveryPreferences.contains(DeliveryOption.pickup),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _deliveryPreferences.add(DeliveryOption.pickup);
                  } else {
                    _deliveryPreferences.remove(DeliveryOption.pickup);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Need delivery'),
              value: _deliveryPreferences.contains(DeliveryOption.delivery),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _deliveryPreferences.add(DeliveryOption.delivery);
                  } else {
                    _deliveryPreferences.remove(DeliveryOption.delivery);
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

            // Submit Button
            ElevatedButton(
              onPressed: _isLoading ? null : _submitDemand,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Post Demand', style: AppTextStyles.buttonLarge),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitDemand() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_deliveryPreferences.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one delivery preference'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = Provider.of<AuthProvider>(context, listen: false).currentUser!;
      final demandProvider = Provider.of<DemandProvider>(context, listen: false);

      final success = await demandProvider.addDemand(
        buyerId: user.id,
        cropId: _selectedCrop!.id,
        quantityNeeded: _quantityController.text.trim(),
        qualitySpecs: _qualityController.text.trim().isNotEmpty ? _qualityController.text.trim() : null,
        budgetRange: _budgetController.text.trim().isNotEmpty ? _budgetController.text.trim() : null,
        urgency: _urgency,
        deliveryPreferences: _deliveryPreferences,
        location: _locationController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Demand posted successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post demand'),
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