import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smily/constants.dart';
import 'package:smily/utils/notification_service.dart';

import 'data/questions_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedOption;
  int score = 0;

  final List<int> wrongAnswerIndices = [];

  void _onOptionSelected(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  void _onNext() async {
    final isCorrect = selectedOption ==
        quizQuestions[currentQuestionIndex].correctAnswerIndex;

    if (isCorrect) {
      score++;
    } else {
      wrongAnswerIndices.add(currentQuestionIndex);
      NotificationService.scheduleWrongAnswerNotifications(
        [currentQuestionIndex],
        testing: true,
      );
    }

    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('quizDate', DateTime.now().toIso8601String());
      prefs.setStringList(
        'wrongChallenges',
        wrongAnswerIndices.map((i) => i.toString()).toList(),
      );

      if (wrongAnswerIndices.isNotEmpty) {
        NotificationService.scheduleWrongAnswerNotifications(
          wrongAnswerIndices,
          testing: false,
        );
      }

      Navigator.pushReplacementNamed(
        context,
        '/result',
        arguments: {
          'score': score,
          'wrongIndices': wrongAnswerIndices,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentQuestionIndex];
    final size = MediaQuery.of(context).size;
    final double textScale = size.width / 375; // base width for scaling

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.04,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height * 0.85),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${currentQuestionIndex + 1} /${quizQuestions.length}',
                    style: TextStyle(
                      fontSize: 18 * textScale,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    question.questionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24 * textScale,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  ...List.generate(question.options.length, (index) {
                    final isSelected = selectedOption == index;
                    return GestureDetector(
                      onTap: () => _onOptionSelected(index),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        padding: EdgeInsets.all(size.width * 0.04),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          question.options[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18 * textScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: selectedOption == null ? null : _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      fixedSize: Size(size.width * 0.6, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      'التالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * textScale,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  TextButton(
                    onPressed: () {
                      if (currentQuestionIndex > 0) {
                        setState(() {
                          currentQuestionIndex--;
                          selectedOption = null;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      fixedSize: Size(size.width * 0.6, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      'رجوع',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * textScale,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
