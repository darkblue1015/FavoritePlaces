import 'package:favorite_places/screens/places.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

// A StatefulWidget that manages user authentication (login or sign up).
class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == true) {
      _formKey.currentState?.save();
      _submitAuthForm(_userEmail.trim(), _userPassword.trim(), _isLogin);
    }
  }

  void _submitAuthForm(String email, String password, bool isLogin) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      setState(() {
        _isLoading = false;
        if (isLogin) {
          _userEmail = '';
          _userPassword = '';
        }
      });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PlacesScreen()));
    } on FirebaseAuthException catch (e) {
      var message = 'An error occurred, please check your credentials!';

      if (e.message != null) {
        message = e.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            key: const ValueKey('email'),
                            validator: (value) {
                              if (value == null || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userEmail = value ?? '';
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          ),
                          TextFormField(
                            key: const ValueKey('password'),
                            validator: (value) {
                              if (value == null || value.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userPassword = value ?? '';
                            },
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          const SizedBox(height: 12),
                          if (_isLoading) CircularProgressIndicator(),
                          if (!_isLoading)
                            ElevatedButton(
                              onPressed: _trySubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                          if (!_isLoading)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
