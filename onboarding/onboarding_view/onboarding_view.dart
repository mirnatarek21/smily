import 'package:flutter/material.dart';
import 'package:smily/constants.dart';
import 'package:smily/features/onboarding/onboarding_view/data/onboarding_model.dart';
import 'package:smily/secure_storage.dart';
import 'package:smily/widgets/custom_button.dart';
import 'data/data.dart';
import 'widgets/onboarding_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingModel model = onboardingModels.first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: OnboardingBody(model: model),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomElevatedButton(
                  text: model.buttonTitle,
                  onPressed: () async {
                    await SecureStorage().writeOnboardingData(false);
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  borderRadius: 28,
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  height: 55,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
