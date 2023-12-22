class FlashcardContent {
  final String _image;
  final String _text;

  const FlashcardContent({
    required String image,
    required String text,
  })  : _image = image,
        _text = text;

  String get text {
    return '<div style="text-align: center">$_text</div>';
  }

  String get image => _image;
}