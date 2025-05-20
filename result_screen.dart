import 'package:flutter/material.dart';
import 'package:smily/constants.dart';
import 'package:smily/features/Questionnaire/data/answer_data.dart';

import 'data/questions_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int score = args['score'];
    final List<int> wrongIndices = args['wrongIndices'];

    // Determine image and message based on score
    String resultImage = '';
    String resultMessage = '';

    if (score > 12) {
      resultImage = 'assets/characters/char1-removed.png';
      resultMessage = 'أداء ممتاز! استمر على هذا النمط الصحي 🎉';
    } else if (score > 9) {
      resultImage = 'assets/characters/char2-removed.png';
      resultMessage = 'محارب 💪';
    } else if (score > 6) {
      resultImage = 'assets/characters/char3-removed.png';
      resultMessage = 'نص نص✨';
    } else if (score > 3) {
      resultImage = 'assets/characters/char4-removed.png';
      resultMessage = ' حاول لسا فيه احسن💡';
    } else {
      resultImage = 'assets/characters/char5-removed.png';
      resultMessage = ' محتاج update جديد 💥';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('النتيجة'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'نتيجتك يا بطل: ${quizQuestions.length} / $score',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                resultImage,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              resultMessage,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            if (wrongIndices.isNotEmpty) ...[
              const Text(
                'نصائح لتحسين نمط حياتك:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 12),
              ...wrongIndices.map((index) {
                final tip = tips[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip['title']!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tip['content']!,
                            style: const TextStyle(fontSize: 16),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
