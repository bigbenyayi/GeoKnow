class FlashcardContent {
  String _imageUrl;
  String _body;
  String? _locationUrl;
  bool _isFavorite;

  FlashcardContent({
    required String imageUrl,
    required String body,
    String? locationUrl,
    bool isFavorite = false,
  }) : _body = body, _imageUrl = imageUrl, _locationUrl = locationUrl, _isFavorite = isFavorite;

  factory FlashcardContent.fromJson(Map<String, dynamic> json) => FlashcardContent(
    locationUrl: json['locationUrl'],
    imageUrl: json['imageUrl'],
    body: json['body'],
  );

  String get body => '<div style="text-align: center">$_body</div>';

  bool get hasBody => _body.isNotEmpty;

  String? get locationUrl => _locationUrl;

  String get imageUrl => _imageUrl;

  bool get isFavorite => _isFavorite;

  FlashcardContent copyWith({
    String? imageUrl,
    String? body,
    String? locationUrl,
    bool? isFavorite,
  }) {
    return FlashcardContent(
      imageUrl: imageUrl ?? _imageUrl,
      body: body ?? _body,
      locationUrl: locationUrl ?? _locationUrl,
      isFavorite: isFavorite ?? _isFavorite,
    );
  }
}