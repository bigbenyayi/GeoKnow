class FlashcardContent {
  String _imageUrl;
  String _body;
  String? _locationUrl;

  FlashcardContent({
    required String imageUrl,
    required String body,
    String? locationUrl,
  }) : _body = body, _imageUrl = imageUrl, _locationUrl = locationUrl;

  factory FlashcardContent.fromJson(Map<String, dynamic> json) => FlashcardContent(
    locationUrl: json['locationUrl'],
    imageUrl: json['imageUrl'],
    body: json['body'],
  );

  String get body => '<div style="text-align: center">$_body</div>';

  String? get locationUrl => _locationUrl;

  String get imageUrl => _imageUrl;
}