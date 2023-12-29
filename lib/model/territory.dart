class Territory {
  final String _isoCode;
  final String _name;

  const Territory({
    required String isoCode,
    required String name,
  })  : _isoCode = isoCode,
        _name = name;

  String get isoCode => _isoCode;

  String get isoCodeCircleFlag {
    if (_isoCode == 'us-al') {
      return 'us';
    }
    return _isoCode;
  }

  String get name => _name;

  String get asset {
    return 'assets/images/state_outlines/$_isoCode.png';
  }

  String get flag {
    return 'assets/images/flags/$_isoCode.svg';
  }
}