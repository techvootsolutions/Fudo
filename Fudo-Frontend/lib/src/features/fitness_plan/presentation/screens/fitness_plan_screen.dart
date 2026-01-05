import 'package:flutter/material.dart';
import 'package:fudo/injection_container.dart' show sl;
import 'package:fudo/src/features/fitness_plan/presentation/provider/fitness_plan_provider.dart';
import 'package:provider/provider.dart';

class FitnessPlanScreen extends StatelessWidget {
  const FitnessPlanScreen({super.key});

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<FitnessPlanProvider>(
      create: (_) => sl<FitnessPlanProvider>()..init(),
      child: Builder(builder: (context) => const FitnessPlanScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fitnessProvider = context.watch<FitnessPlanProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Plan"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Create Your Fitness Plan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Date of Birth Field
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: fitnessProvider.dateOfBirth ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  helpText: "Select Date of Birth",
                );
                if (picked != null) {
                  fitnessProvider.setDateOfBirth(picked);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  hintText: "Select your date of birth",
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(),
                  errorText: fitnessProvider.dateOfBirthError,
                ),
                child: Text(
                  fitnessProvider.getDateOfBirthDisplay() ?? "Select date of birth",
                  style: TextStyle(
                    color: fitnessProvider.dateOfBirth == null
                        ? Theme.of(context).hintColor
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Weight Field
            TextField(
              onChanged: (val) => fitnessProvider.setWeight(val),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                hintText: "Enter your weight",
                prefixIcon: const Icon(Icons.monitor_weight),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.weightError,
              ),
            ),
            const SizedBox(height: 20),

            // Height Field
            TextField(
              onChanged: (val) => fitnessProvider.setHeight(val),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Height (cm)",
                hintText: "Enter your height",
                prefixIcon: const Icon(Icons.height),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.heightError,
              ),
            ),
            const SizedBox(height: 20),

            // Fitness Plan Dropdown
            DropdownButtonFormField<String>(
              value: fitnessProvider.fitnessPlan,
              decoration: InputDecoration(
                labelText: "Fitness Plan",
                prefixIcon: const Icon(Icons.fitness_center),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.fitnessPlanError,
              ),
              items: fitnessProvider.fitnessPlanOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (val) => fitnessProvider.setFitnessPlan(val),
            ),
            const SizedBox(height: 20),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: fitnessProvider.gender,
              decoration: InputDecoration(
                labelText: "Gender",
                prefixIcon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.genderError,
              ),
              items: fitnessProvider.genderOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (val) => fitnessProvider.setGender(val),
            ),
            const SizedBox(height: 20),

            // Disease Text Field
            TextField(
              onChanged: (val) => fitnessProvider.setDisease(val),
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Disease (Optional)",
                hintText: "Enter any medical conditions or diseases",
                prefixIcon: Icon(Icons.medical_services),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Lifestyle Text Field
            TextField(
              onChanged: (val) => fitnessProvider.setLifestyle(val),
              decoration: const InputDecoration(
                labelText: "Lifestyle",
                hintText: "Describe your lifestyle (e.g., Sedentary, Active)",
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Allergies Text Field
            TextField(
              onChanged: (val) => fitnessProvider.setAllergies(val),
              decoration: const InputDecoration(
                labelText: "Allergies (Optional)",
                hintText: "Enter any allergies (e.g., Peanuts)",
                prefixIcon: Icon(Icons.warning),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Workout Type Dropdown
            DropdownButtonFormField<String>(
              value: fitnessProvider.workoutType,
              decoration: InputDecoration(
                labelText: "Workout Type",
                prefixIcon: const Icon(Icons.sports_gymnastics),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.workoutTypeError,
              ),
              items: fitnessProvider.workoutTypeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (val) => fitnessProvider.setWorkoutType(val),
            ),
            const SizedBox(height: 20),

            // Workout Intense Type Field
            TextField(
              onChanged: (val) => fitnessProvider.setWorkoutIntenseType(val),
              decoration: InputDecoration(
                labelText: "Workout Intense Type",
                hintText: "Enter workout intensity (e.g., Low, Medium, High)",
                prefixIcon: const Icon(Icons.speed),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.workoutIntenseTypeError,
              ),
            ),
            const SizedBox(height: 20),

            // Workout Time Dropdown
            DropdownButtonFormField<String>(
              value: fitnessProvider.workoutTime,
              decoration: InputDecoration(
                labelText: "Workout Time",
                prefixIcon: const Icon(Icons.access_time),
                border: const OutlineInputBorder(),
                errorText: fitnessProvider.workoutTimeError,
              ),
              items: fitnessProvider.workoutTimeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (val) => fitnessProvider.setWorkoutTime(val),
            ),
            const SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: fitnessProvider.isLoading
                  ? null
                  : () {
                      fitnessProvider.submitForm();
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: fitnessProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

