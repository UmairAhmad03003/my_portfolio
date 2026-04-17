import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool _isLoading = false;
  bool _isSent = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSent => _isSent;
  String? get errorMessage => _errorMessage;

  bool validateForm() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || messageController.text.isEmpty) {
      _errorMessage = 'Please fill all fields';
      notifyListeners();
      return false;
    }
    if (!emailController.text.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<void> submitContact() async {
    if (!validateForm()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      _isSent = true;
      resetForm();
    } catch (e) {
      _errorMessage = 'Failed to send message. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
