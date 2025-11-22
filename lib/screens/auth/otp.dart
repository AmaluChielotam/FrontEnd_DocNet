import 'package:flutter/material.dart';
import 'package:flutterprojects/service/auth_service.dart';


class VerifyOtpScreen extends StatefulWidget {
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  String? _email;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (!_focusNodes[i].hasFocus && _otpControllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      setState(() {
        _email = args?['email'];
      });
    });
  }

  @override
  void dispose() {
    _otpControllers.forEach((c) => c.dispose());
    _focusNodes.forEach((n) => n.dispose());
    super.dispose();
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty && index < 5) _focusNodes[index + 1].requestFocus();
    if (value.isEmpty && index > 0) _focusNodes[index - 1].requestFocus();
  }

  Future<void> _verifyOtp() async {
    String otp = _otpControllers.map((c) => c.text).join();
    if (_email == null || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid OTP')));
      return;
    }

    setState(() => _isLoading = true);

    final auth = AuthService();
    final result = await auth.verifyOtp(email: _email!, otp: otp);

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      Navigator.pushReplacementNamed(context, '/choose-specialty');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'OTP verification failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Color(0xFF2D5B8F)),
              ),
              SizedBox(height: 40),
              Text('Verify OTP', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2D5B8F))),
              SizedBox(height: 8),
              Text('We sent a 6-digit code to ${_email ?? 'your email'}', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(counterText: ''),
                        onChanged: (value) => _handleOtpInput(value, index),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D5B8F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Verify OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
