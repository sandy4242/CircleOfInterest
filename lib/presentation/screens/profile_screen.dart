import 'package:flutter/material.dart';
import '../widget/profile/past_events_widget.dart';
import '../widget/profile/profile_image_widget.dart';
import '../widget/profile/user_info_form_widget.dart';
import '../../constants/profile_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;

  String _profileImageUrl = '';
  final List<String> _pastEvents = [
    'Book Club Meeting - Oct 04, 2025',
    'Photography Workshop - Oct 06, 2025',
    'Coding Bootcamp - Oct 10, 2025',
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    _nameController.text = 'ABC';
    _emailController.text = 'abc123@gmail.com';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(imageUrl: _profileImageUrl, isEditing: _isEditing, onImageTap: _showImagePicker),
            const SizedBox(height: 24),
            UserInfoFormWidget(
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              isEditing: _isEditing,
            ),
            const SizedBox(height: 32),
            PastEventsWidget(pastEvents: _pastEvents, onEventTap: _showEventDetails),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(ProfileConstants.profileTitle),
      actions: [IconButton(icon: Icon(_isEditing ? Icons.save : Icons.edit), onPressed: _toggleEdit)],
    );
  }

  void _toggleEdit() {
    if (_isEditing && _formKey.currentState!.validate()) {
      _saveProfile();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(ProfileConstants.profileUpdatedMessage), backgroundColor: Colors.green),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(ProfileConstants.cameraOption),
                onTap: () {
                  Navigator.pop(context);
                  // Implement camera functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(ProfileConstants.galleryOption),
                onTap: () {
                  Navigator.pop(context);
                  // Implement gallery functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEventDetails(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(ProfileConstants.eventDetailsTitle),
          content: Text(_pastEvents[index]),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(ProfileConstants.closeButton)),
          ],
        );
      },
    );
  }
}
