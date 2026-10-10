
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/profile_repository.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _repository = ProfileRepository();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGovernorate;

  bool _loading = true;
  bool _saving = false;
  String? _error;

  static const navy = Color(0xFF10244A);
  static const blue = Color(0xFF1769F4);

  // All 24 governorates of Tunisia.
  static const List<String> tunisianGovernorates = [
    'Ariana',
    'Béja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'Le Kef',
    'Mahdia',
    'La Manouba',
    'Médenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await _repository.getProfile();

      if (!mounted) return;

      _nameController.text = (data['name'] ?? '').toString();
      _emailController.text = (data['email'] ?? '').toString();
      _phoneController.text = (data['phone'] ?? '').toString();

      final savedCity =
          (data['preferredCity'] ?? '').toString().trim();

      // Accept the saved value even if its capitalization differs.
      String? matchingGovernorate;

      for (final governorate in tunisianGovernorates) {
        if (governorate.toLowerCase() ==
            savedCity.toLowerCase()) {
          matchingGovernorate = governorate;
          break;
        }
      }

      setState(() {
        _selectedGovernorate = matchingGovernorate;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error =
            'Unable to load your profile. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_saving || !_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedGovernorate == null) {
      return;
    }

    setState(() => _saving = true);

    try {
      final name = _nameController.text.trim();

      await _repository.updateProfile(
        name: name,
        phone: _phoneController.text,
        preferredCity: _selectedGovernorate!,
      );

      // Synchronize the display name with Firebase Authentication.
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(name);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to save your changes. Please try again.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: blue),
        filled: true,
        fillColor: readOnly
            ? const Color(0xFFF0F2F6)
            : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        foregroundColor: navy,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      _error!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 560),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            const CircleAvatar(
                              radius: 44,
                              backgroundColor:
                                  Color(0xFFE1EAFF),
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: blue,
                              ),
                            ),

                            const SizedBox(height: 28),

                            _input(
                              label: 'Full Name',
                              controller: _nameController,
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            _input(
                              label: 'Email Address',
                              controller: _emailController,
                              icon: Icons.email_outlined,
                              readOnly: true,
                            ),

                            const SizedBox(height: 16),

                            _input(
                              label: 'Phone Number',
                              controller: _phoneController,
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),

                            const SizedBox(height: 16),

                            DropdownButtonFormField<String>(
                              initialValue: _selectedGovernorate,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: 'Preferred Governorate',
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  color: blue,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              hint: const Text(
                                'Select your governorate',
                              ),
                              items: tunisianGovernorates
                                  .map(
                                    (governorate) =>
                                        DropdownMenuItem<String>(
                                      value: governorate,
                                      child: Text(governorate),
                                    ),
                                  )
                                  .toList(),
                              onChanged: _saving
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedGovernorate = value;
                                      });
                                    },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Please select a governorate';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            FilledButton.icon(
                              onPressed:
                                  _saving ? null : _saveProfile,
                              style: FilledButton.styleFrom(
                                backgroundColor: blue,
                                padding:
                                    const EdgeInsets.all(16),
                              ),
                              icon: _saving
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.save_outlined,
                                    ),
                              label: Text(
                                _saving
                                    ? 'Saving...'
                                    : 'Save Changes',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
