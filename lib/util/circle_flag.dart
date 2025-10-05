import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A flag of a country, rounded by default.
///
/// First positional argument is iso code of the country - can be used string
/// or [Flags] helper.
class CircleFlag extends StatelessWidget {
  static final _FlagCache cache = _FlagCache();
  final BytesLoader _loader;
  final double _size;

  /// [Clip] option for widget [ClipPath].
  ///
  /// This option have no effect if [_shape] == null.
  final Clip _clipBehavior;

  /// Clip the flag by [ShapeBorder], default: [CircleBorder].
  ///
  /// If null, return square flag.
  final ShapeBorder? _shape;

  CircleFlag(
      String isoCode, {
        super.key,
        double size = 48,
        ShapeBorder? shape = const CircleBorder(),
        Clip clipBehavior = Clip.antiAlias,
      }) : _shape = shape, _clipBehavior = clipBehavior, _size = size, _loader = _createLoader(isoCode);

  /// check if a flag has been preloaded if so, returns its byteloader
  static BytesLoader _createLoader(String isoCode) {
    final SvgBytesLoader? cacheEntry = cache._loaders[isoCode];
    if (cacheEntry != null) {
      return cacheEntry;
    }
    return _FlagAssetLoader(isoCode);
  }

  /// preload a list of flags in memory
  static Future<void> preload(Iterable<String> isoCodes) {
    return cache.preload(isoCodes);
  }

  @override
  Widget build(BuildContext context) {
    final SvgPicture svg = SvgPicture(
      _loader,
      width: _size,
      height: _size,
    );

    final Widget clipped = _shape == null
        ? svg
        : ClipPath(
      clipper: ShapeBorderClipper(
        shape: _shape!,
        textDirection: Directionality.maybeOf(context),
      ),
      clipBehavior: _clipBehavior,
      child: svg,
    );
    return ExcludeSemantics(
      child: clipped,
    );
  }
}

/// create an SvgAssetLoader that points to circle flag svg file
/// it will resolve to the "?" flag if the normal asset is not found
class _FlagAssetLoader extends SvgAssetLoader {
  final String isoCode;

  _FlagAssetLoader(this.isoCode) : super(computeAssetName(isoCode));

  static String computeAssetName(String isoCode) {
    return 'assets/images/flags/${isoCode.toLowerCase()}.svg';
  }

  static Future<ByteData> loadAsset(String assetName,
      [BuildContext? context, AssetBundle? assetBundle]) {
    final AssetBundle bundle = _FlagAssetLoader._resolveBundle(assetBundle, context);
    return bundle
        .load(assetName)
    // if any error loading a flag try to show the "?" flag
        .catchError((dynamic e) => rootBundle.load(_FlagAssetLoader.computeAssetName('xx')));
  }

  static AssetBundle _resolveBundle(
      AssetBundle? assetBundle, BuildContext? context) {
    if (assetBundle != null) {
      return assetBundle;
    }
    if (context != null) {
      return DefaultAssetBundle.of(context);
    }
    return rootBundle;
  }

  @override
  Future<ByteData?> prepareMessage(BuildContext? context) {
    final AssetBundle bundle = _resolveBundle(assetBundle, context);
    return bundle
        .load(computeAssetName(isoCode))
    // load "?" on error
        .catchError((dynamic e) => bundle.load(computeAssetName('xx')));
  }

  @override
  String provideSvg(ByteData? message) =>
      utf8.decode(message!.buffer.asUint8List(), allowMalformed: true);

  @override
  SvgCacheKey cacheKey(BuildContext? context) {
    return SvgCacheKey(
        keyData: isoCode, theme: theme, colorMapper: colorMapper);
  }
}

/// a flag loader cache that allows for preloading
/// svg bytes.
/// Currently only caches preloaded items
class _FlagCache {
  final Map<String, SvgBytesLoader> _loaders = <String, SvgBytesLoader>{};

  /// preloads flag data into svg cache
  Future<void> preload(
      Iterable<String> isoCodes, [
        BuildContext? context,
        AssetBundle? assetBundle,
      ]) async {
    final List<Future<void>> tasks = <Future<void>>[];
    for (final String isoCode in isoCodes) {
      final Future<void> task = _createLoader(isoCode, context, assetBundle)
          .then((SvgBytesLoader loader) => _addLoaderToCache(isoCode, loader));
      tasks.add(task);
    }
    await Future.wait(tasks);
  }

  Future<SvgBytesLoader> _createLoader(
      String isoCode, BuildContext? context, AssetBundle? assetBundle) async {
    final String assetName = _FlagAssetLoader.computeAssetName(isoCode);
    final ByteData byteData =
    await _FlagAssetLoader.loadAsset(assetName, context, assetBundle);
    final SvgBytesLoader loader = SvgBytesLoader(Uint8List.sublistView(byteData));
    // add it to svg cache
    svg.cache
        .putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(context));
    return loader;
  }

  void _addLoaderToCache(
      String isoCode,
      SvgBytesLoader loader,
      ) {
    _loaders[isoCode] = loader;
  }
}
