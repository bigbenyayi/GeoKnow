import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/flashcard.dart';

class AddFlashcardScreen extends StatelessWidget {
  final Territory _territory;

  const AddFlashcardScreen({super.key, required Territory territory}) : _territory = territory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _territory.name),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Flashcard(
          flag: _territory.flag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: const Radius.circular(16.0),
                    borderPadding: const EdgeInsets.all(8.0),
                    color: Colors.grey.shade400,
                    dashPattern: const <double>[8.0, 8.0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add_a_photo, color: Colors.grey.shade400, size: 40.0),
                        Text('Add image', style: TextStyle(color: Colors.grey.shade400)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      maxLines: null,
                      minLines: 3,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}