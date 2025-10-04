import 'package:auth_koko/components/custom_button.dart';
import 'package:auth_koko/components/custom_texfield.dart';
import 'package:auth_koko/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(); // use as email
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUserIn() async {
    HapticFeedback.lightImpact();

    // Cache these BEFORE any awaits — avoids using BuildContext across async gaps.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);

    // Show blocking progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      ),
    );

    try {
      final email = usernameController.text.trim();
      final pwd = passwordController.text;

      if (email.isEmpty || pwd.isEmpty) {
        throw FirebaseAuthException(
          code: 'empty-fields',
          message: 'Please enter both email and password.',
        );
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Signed in successfully')),
      );
      // navigator.pushReplacement(...);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final msg = switch (e.code) {
        'invalid-email' => 'The email address is badly formatted.',
        'user-not-found' => 'No user found for that email.',
        'wrong-password' => 'Wrong password provided for that user.',
        'user-disabled' => 'This account has been disabled.',
        'empty-fields' => e.message ?? 'Please fill all fields.',
        _ => e.message ?? 'Authentication error (${e.code}).',
      };
      messenger.showSnackBar(
        SnackBar(
          content: Text(msg, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Sign-in failed: $e',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Close the loading dialog safely
      if (mounted && navigator.canPop()) {
        navigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Auth Tutorial',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(
              isDark ? Icons.sunny : Icons.nightlight,
              color: isDark
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 15),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 50),

                // Email textfield (your 'username' acts as email for Firebase)
                CustomTexfield(
                  controller: usernameController,
                  hintText: 'Enter your email',
                  obscureText: false,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 20),

                // Password textfield
                CustomTexfield(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.only(right: 29.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => HapticFeedback.lightImpact(),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Sign in button
                CustomButton(onTap: _signUserIn),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        indent: 25,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        indent: 10,
                        endIndent: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Social buttons (unchanged)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google
                    GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          'lib/images/google_logo.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    // Apple
                    GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          'lib/images/apple_logo.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Not a member? Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
