import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/profile/view/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../core/widget/custom_buttons.dart';
import '../../../../data/model/profile_item_model.dart';
import '../../../../data/model/user.dart';
import '../../../../data/repository/favorite_repository.dart';
import '../../../../data/repository/user_repository.dart';
class ProfileBody extends StatefulWidget {

  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final UserRepository _userRepo = UserRepository();
  final FavoriteRepository _favoriteRepo = FavoriteRepository();

  late Future<User?> _userFuture;
  late Future<int> _favoritesCountFuture;

  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();


  bool _isUpdating = false;

  late int? userId;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    userId = await _userRepo.getUserId();
    _userFuture = _userRepo.getUserById(userId!);
    _favoritesCountFuture = _favoriteRepo.getFavoriteCount(userId!);
    setState(() {});
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected! (Upload feature coming soon)'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _updateProfile(User user) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      final updatedUser = user.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        updatedAt: DateTime.now(),
      );

      if (_passwordController.text.trim().isNotEmpty) {
        if (_passwordController.text.trim().length >= 6) {
          await _userRepo.updatePassword(userId!, _passwordController.text.trim());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password must be at least 6 characters'),
              backgroundColor: Colors.orange,
            ),
          );
          setState(() {
            _isUpdating = false;
          });
          return;
        }
      }

      final result = await _userRepo.updateUser(updatedUser);

      if (result > 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          setState(() {
            _isEditing = false;
            _passwordController.clear();
          });

          _loadUserData();
        }
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          backgroundColor: MyColor.secondaryColor,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _userRepo.logout();

                Navigator.pop(context);
                // Navigate back to auth screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/auth',
                      (route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileContent(User user) {
    final items = [
      ProfileItemModel(
        label: "Name",
        value: user.name,
        icon: Icons.person,
        isEditable: true,
      ),
      ProfileItemModel(
        label: "Email",
        value: user.email,
        icon: Icons.email,
        isEditable: true,
      ),
      ProfileItemModel(
        label: "Mobile Number",
        value: user.phone ?? "Not provided",
        icon: Icons.phone,
        isEditable: true,
      ),
      ProfileItemModel(
        label: "Password",
        value: "********",
        icon: Icons.lock,
        isEditable: true,
      ),
      ProfileItemModel(
        label: "Settings",
        value: "",
        icon: Icons.settings,
        isEditable: false,
      ),
    ];

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColor.backgroundColor,
                    MyColor.mainColor.withAlpha(25),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: MyColor.gray77),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: MyColor.white,
                    ),
                  ),
                  const Spacer(),
                  if (!_isEditing)
                    TextButton(
                      onPressed: () {
                        _nameController.text = user.name;
                        _emailController.text = user.email;
                        _phoneController.text = user.phone ?? '';
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: MyColor.mainColor),
                      ),
                    ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 80),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(18),
                itemCount: items.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    profileItem(
                      items[index],
                      context,
                      isEditing: _isEditing,
                      controller: _getControllerForItem(items[index].label),
                      onValueChanged: (value) {
                        _updateControllerForItem(items[index].label, value);
                      },
                    ),
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: MyColor.gray77),
              ),
            ),
          ],
        ),

        Positioned(
          top: 100,
          left: 160,
          child: Column(
            children: [
              GestureDetector(
                onTap: _isEditing ? _pickImage : null,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: MyColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                        _selectedImage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                          : user.imageUrl != null
                          ? Image.network(
                        user.imageUrl!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AssetsManager.profile,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                          : Image.asset(
                        AssetsManager.profile,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (!_isEditing)
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: MyColor.white,
                  ),
                ),
              if (_isEditing)
                const Text(
                  'Tap avatar to change',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColor.gray77,
                  ),
                ),
            ],
          ),
        ),

        if (_isEditing)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    onTap: () {
                      setState(() {
                        _isEditing = false;
                        _passwordController.clear();
                      });
                    },
                    editWidth: double.infinity,
                    color: MyColor.gray77,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: _isUpdating ? "Saving..." : "Save Changes",
                    onTap: () => _updateProfile(user),
                    editWidth: double.infinity,
                  ),
                ),
              ],
            ),
          ),

        // Logout button
        if (!_isEditing)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: CustomButton(
              text: "Logout",
              onTap: _logout,
              editWidth: double.infinity,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
      ],
    );
  }

  TextEditingController? _getControllerForItem(String label) {
    switch (label) {
      case "Name":
        return _nameController;
      case "Email":
        return _emailController;
      case "Mobile Number":
        return _phoneController;
      case "Password":
        return _passwordController;
      default:
        return null;
    }
  }

  void _updateControllerForItem(String label, String value) {
    switch (label) {
      case "Name":
        _nameController.text = value;
        break;
      case "Email":
        _emailController.text = value;
        break;
      case "Mobile Number":
        _phoneController.text = value;
        break;
      case "Password":
        _passwordController.text = value;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: MyColor.gray77),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading profile',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: MyColor.gray77),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadUserData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'User not found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: MyColor.backgroundColor,
          body: _buildProfileContent(user),
        );
      },
    );
  }
}
