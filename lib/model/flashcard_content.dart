class FlashcardContent {
  final String _image;
  final String _text;
  final String? _blurHash;

  const FlashcardContent({
    required String image,
    required String text,
    String? blurHash,
  })  : _image = image,
        _text = text,
        _blurHash = blurHash;

  String get text {
    return '<div style="text-align: center">$_text</div>';
  }

  String get image => _image;

  String get blurHash => _blurHash!;
}