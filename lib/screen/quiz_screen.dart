import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/model/quiz.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/image_error_widget.dart';
import 'package:geo_know/screen/result_screen.dart';
import 'package:geo_know/values/countries.dart';
import 'package:octo_image/octo_image.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Quiz>> _quizFuture;
  final Random _random = Random();

  int _index = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  List<CountryEnum>? _currentOptions;
  CountryEnum? _correctAnswer;

  @override
  void initState() {
    super.initState();
    _quizFuture = Quiz.loadFromAsset(context);
  }

  void _nextQuestion(List<Quiz> quizzes) {
    if (_index < quizzes.length - 1) {
      setState(() {
        _index++;
        _selectedIndex = null;
        _answered = false;
        _prepareQuestion(quizzes[_index]);
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => ResultScreen(
            score: _score,
            total: quizzes.length,
          ),
        ),
      );
    }
  }

  void _prepareQuestion(Quiz quiz) {
    _correctAnswer = _findMatchingEnum(quiz.answer);
    _currentOptions = _generateOptions(_correctAnswer!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bollard Quiz'),
      body: FutureBuilder<List<Quiz>>(
        future: _quizFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Quiz> quizzes = snapshot.data!;
          final Quiz quiz = quizzes[_index];

          // Only generate options once per new question
          if (_currentOptions == null || _correctAnswer == null) {
            _prepareQuestion(quiz);
          }

          return GestureDetector(
            onTap: () {
              _nextQuestion(quizzes);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${_index + 1}/${quizzes.length}',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12.0),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            child: LinearProgressIndicator(
                              value: (_index + 1) / quizzes.length,
                              minHeight: 8.0,
                              color: Colors.grey.shade400,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(16.0),
                          child: OctoImage(
                            image: CachedNetworkImageProvider(quiz.imageUrl),
                            errorBuilder: (BuildContext context, _, __) => const ImageErrorWidget(),
                            placeholderBuilder: (BuildContext context) {
                              return AspectRatio(aspectRatio: 16/9, child: Container(color: Colors.grey[300]));
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...List<Widget>.generate(_currentOptions!.length, (int i) {
                          final CountryEnum option = _currentOptions![i];
                          final bool isSelected = _selectedIndex == i;
                          final bool isCorrect = option == _correctAnswer;

                          Color color = Colors.grey.shade200;
                          if (_answered) {
                            if (isSelected && isCorrect) {
                              color = Colors.green.shade400;
                            } else if (isSelected && !isCorrect) {
                              color = Colors.red.shade400;
                            } else if (isCorrect) {
                              color = Colors.green.shade100;
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                            child: GestureDetector(
                              onTap: !_answered
                                  ? () {
                                if (option == _correctAnswer) {
                                  _score++;
                                }
                                setState(() {
                                  _selectedIndex = i;
                                  _answered = true;
                                });
                              }
                                  : null,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  option.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CountryEnum _findMatchingEnum(String name) {
    return CountryEnum.values.firstWhere(
          (CountryEnum c) => c.name.toLowerCase() == name.toLowerCase(),
    );
  }

  List<CountryEnum> _generateOptions(CountryEnum correct) {
    final List<CountryEnum> list = CountryEnum.values.toList()..remove(correct)..shuffle(_random);
    final List<CountryEnum> randomOptions = list.take(3).toList();
    final List<CountryEnum> options = <CountryEnum>[correct, ...randomOptions]..shuffle(_random);
    return options;
  }
}
