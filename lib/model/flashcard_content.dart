class FlashcardContent {
  String _imageUrl;
  String _body;
  String? _locationUrl;
  bool _isFavorite;
  String _isoCode;

  FlashcardContent({
    required String imageUrl,
    required String body,
    required String isoCode,
    String? locationUrl,
    bool isFavorite = false,
  }) : _body = body, _imageUrl = imageUrl, _locationUrl = locationUrl, _isFavorite = isFavorite, _isoCode = isoCode;

  factory FlashcardContent.fromJson(Map<String, dynamic> json, String isoCode) => FlashcardContent(
    locationUrl: json['locationUrl'],
    imageUrl: json['imageUrl'],
    body: json['body'],
    isoCode: isoCode,
  );

  String get body => '<div style="text-align: center">$_body</div>';

  bool get hasBody => _body.isNotEmpty;

  String? get locationUrl => _locationUrl;

  String get imageUrl => _imageUrl;

  bool get isFavorite => _isFavorite;

  String get isoCode => _isoCode;

  FlashcardContent copyWith({
    String? imageUrl,
    String? body,
    String? locationUrl,
    bool? isFavorite,
    String? isoCode,
  }) {
    return FlashcardContent(
      imageUrl: imageUrl ?? _imageUrl,
      body: body ?? _body,
      locationUrl: locationUrl ?? _locationUrl,
      isFavorite: isFavorite ?? _isFavorite,
      isoCode: isoCode ?? _isoCode,
    );
  }
}