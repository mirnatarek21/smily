import 'package:flutter/material.dart';
import 'package:smily/constants.dart';
import '../data/onboarding_model.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key, required this.model});

  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // Left ellipse
          Positioned(
            left: -size.width * 0.3,
            bottom: -size.height * 0.02,
            child: Image.asset(
              'assets/icons/ellipse-left.png',
              width: size.width * 1.2,
              height: size.width * 1.2,
              fit: BoxFit.contain,
            ),
          ),

          // Right ellipse
          Positioned(
            right: -size.width * 0.3,
            bottom: size.height * 0.05,
            child: Image.asset(
              'assets/icons/ellipse-right.png',
              width: size.width * 1.2,
              height: size.width * 1.2,
              fit: BoxFit.contain,
            ),
          ),

          // Bottom ellipse
          // Positioned(
          //   right: -size.width * 0.3,
          //   bottom: -size.height * 0.15,
          //   child: Image.asset(
          //     'assets/icons/ellipse-bottom.png',
          //     width: size.width * 1.2,
          //     height: size.width * 1.2,
          //     fit: BoxFit.contain,
          //   ),
          // ),

          // Main content
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: size.height * 0.1,
              start: size.width * 0.08,
              end: size.width * 0.08,
              bottom: size.height * 0.05,
            ),
            child: Column(
              children: [
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  model.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Flexible(
                  child: Image.asset(
                    model.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
