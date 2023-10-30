import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPasswordVisible = false;

  // Dummy user data
  final String _username = 'john_doe';
  final String _password = '*********';
  final String _fullName = 'John Doe';
  final String _dateOfBirth = '1990-01-01';
  final String _registrationDate = '2023-10-01';
  final String _email = 'johndoe@example.com';

  final TextEditingController _editUsernameController = TextEditingController();
  final TextEditingController _editPasswordController = TextEditingController();
  final TextEditingController _editDateOfBirthController =
      TextEditingController();

  @override
  void initState() {
    _editUsernameController.text = _username;
    _editPasswordController.text = _password;
    _editDateOfBirthController.text = _dateOfBirth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildEditableField('Username', _editUsernameController),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildInfoField('Full Name', _fullName),
            const SizedBox(height: 20),
            _buildEditableField('Date of Birth', _editDateOfBirthController),
            const SizedBox(height: 20),
            _buildInfoField('Registration Date', _registrationDate),
            const SizedBox(height: 20),
            _buildInfoField('Email', _email),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to update the user's profile here
                print('Saving changes');
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 2,
          child: Text(
            'Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: _editPasswordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Enter new password',
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
