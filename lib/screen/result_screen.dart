import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int _score;
  final int _total;

  const ResultScreen({
    super.key,
    required int score,
    required int total,
  }) : _total = total, _score = score;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;
  late Color _scoreColor;
  late String _message;

  @override
  void initState() {
    super.initState();

    final double ratio = widget._score / widget._total;

    if (ratio >= 0.8) {
      _scoreColor = Colors.green.shade400;
      _message = 'Amazing! 🎉';
    } else if (ratio >= 0.5) {
      _scoreColor = Colors.orange.shade400;
      _message = 'Not bad! 👍';
    } else {
      _scoreColor = Colors.red.shade400;
      _message = 'Keep practicing! 💪';
    }

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ratio = widget._score / widget._total;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _scoreColor,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '${widget._score}/${widget._total}',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: _scoreColor,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: ratio,
                  backgroundColor: Colors.grey.shade300,
                  color: _scoreColor,
                  minHeight: 10,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _scoreColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: widget._score < 3 ? 2 : widget._score < 6 ? 10 : widget._score < 8 ? 20 : 50,
              maxBlastForce: 10,
              emissionFrequency: 0.05,
              gravity: 0.1,
              colors: const <Color>[
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
