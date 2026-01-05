import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fudo/injection_container.dart' show sl;
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/features/auth/presentation/provider/registration_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  // Static builder to inject the provider using Service Locator (sl)
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<RegistrationProvider>(
      create: (_) => sl<RegistrationProvider>(),
      child:  RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrationProvider = context.watch<RegistrationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Join Us",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Name Field
                TextField(
                  onChanged: (val) => registrationProvider.setName(val),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                    errorText: registrationProvider.nameError,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
                TextField(
                  onChanged: (val) => registrationProvider.setEmail(val),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    errorText: registrationProvider.emailError,
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  onChanged: (val) => registrationProvider.setPassword(val),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    errorText: registrationProvider.passwordError,
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                TextField(
                  onChanged: (val) => registrationProvider.setConfirmPassword(val),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    errorText: registrationProvider.confirmPasswordError,
                  ),
                ),
                const SizedBox(height: 30),

                // Register Button
                ElevatedButton(
                  onPressed: registrationProvider.isLoading
                      ? null
                      : () async {
                           registrationProvider.register();
                       
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: registrationProvider.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("REGISTER", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),

                // Navigate back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginScreen); // Go back to Login
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}