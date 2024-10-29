import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkingwork/widgets/custom_bottom_nav_bar.dart';
import 'package:checkingwork/services/auth_service.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // import dart:io to work with files

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; // Variable to store the image
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // User authorization check
    if (!authService.isLoggedIn()) {
      // If the user is not authorized, redirect him to the login screen
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading indicator while redirecting
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(
              _image!,
              height: 150, // Setting the image height
              width: 150, // Setting the image width
              fit: BoxFit.cover, // Scaling
            )
                : Container(
              height: 150, //Setting the height of the container
              width: 150, // Setting the width of the container
              color: Colors.grey[300], //Container color
              child: Center(child: Text('Нет изображения')), // Message if there is no image
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage, // Method for selecting an image
              child: Text('Сделать фото или выбрать из галереи'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authService.logout(); // Logout
                Navigator.pushReplacementNamed(context, '/login'); // Redirect to login screen
              },
              child: Text('Выйти'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }

  // Method for selecting an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera); // Select from camera
    // Or you can choose from the gallery
    // final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Saving the selected image
      });
    } else {
      print('Не удалось выбрать изображение.');
    }
  }
}