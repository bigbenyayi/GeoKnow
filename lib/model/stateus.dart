class StateUS {
  final String isoCode;
  final String name;


  const StateUS({
    required this.isoCode,
    required this.name,
  });

  String get asset {
    return 'assets/images/state_outlines/$isoCode.png';
  }

  String get flag {
    return 'assets/images/flags/$isoCode.svg';
  }
}