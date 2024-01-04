import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ImagePlaceholder extends StatelessWidget {
  final String _blurHash;

  const ImagePlaceholder({super.key, required String blurHash}) : _blurHash = blurHash;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: BlurHash(hash: _blurHash, color: Colors.white),
    );
  }
}