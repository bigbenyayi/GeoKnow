import 'package:flutter/material.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/screen/quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_QuizItem> quizzes = <_QuizItem>[
      _QuizItem(
        title: 'Bollard Quiz',
        description: 'Can you guess the country from the roadside bollard?',
        imageUrl:
        'https://www.plonkit.net/images/resize/600/80/france/Bollard.png',
        difficulty: QuizDifficulty.medium,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const QuizScreen()),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Quizzes'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quizzes.length,
        itemBuilder: (BuildContext context, int index) {
          final _QuizItem quiz = quizzes[index];
          return _QuizCard(quiz: quiz);
        },
      ),
    );
  }
}

enum QuizDifficulty { easy, medium, hard }

class _QuizItem {
  final String title;
  final String description;
  final String imageUrl;
  final QuizDifficulty difficulty;
  final VoidCallback onTap;

  _QuizItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.difficulty,
    required this.onTap,
  });
}

class _QuizCard extends StatelessWidget {
  final _QuizItem _quiz;

  const _QuizCard({required _QuizItem quiz}) : _quiz = quiz;

  Color get _difficultyColor {
    switch (_quiz.difficulty) {
      case QuizDifficulty.easy:
        return Colors.green.shade400;
      case QuizDifficulty.medium:
        return Colors.orange.shade400;
      case QuizDifficulty.hard:
        return Colors.red.shade400;
    }
  }

  String get _difficultyLabel {
    switch (_quiz.difficulty) {
      case QuizDifficulty.easy:
        return 'Easy';
      case QuizDifficulty.medium:
        return 'Medium';
      case QuizDifficulty.hard:
        return 'Hard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _quiz.onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                _quiz.imageUrl,
                width: 100,
                height: 120,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _quiz.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _quiz.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _difficultyColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _difficultyLabel,
                            style: TextStyle(
                              color: _difficultyColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade400,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
