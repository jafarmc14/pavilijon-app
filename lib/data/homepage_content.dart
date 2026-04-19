import 'package:pavilijon_app/config/api_config.dart';

class HomepageContentStore {
  HomepageContentStore._();

  static final HomepageContentStore instance = HomepageContentStore._();

  HomepageContent? _content;

  HomepageContent? get content => _content;

  void replaceFromJson(Map<String, dynamic> json) {
    _content = HomepageContent.fromJson(json);
  }

  void clear() {
    _content = null;
  }
}

class HomepageContent {
  HomepageContent({
    required this.heroImages,
    required this.storyImages,
    required this.signatureMenu,
  });

  factory HomepageContent.fromJson(Map<String, dynamic> json) {
    return HomepageContent(
      heroImages: _extractImages(json['hero']),
      storyImages: _extractImages(json['story']),
      signatureMenu: _extractSignatureMenu(json['signatureMenu']),
    );
  }

  final List<String> heroImages;
  final List<String> storyImages;
  final List<HomepageSignatureMenuItem> signatureMenu;

  static List<String> _extractImages(Object? section) {
    if (section is! Map<String, dynamic>) {
      return const [];
    }

    final images = section['images'];
    if (images is! List) {
      return const [];
    }

    return images
        .whereType<String>()
        .map(_normalizeLocalImageUrl)
        .where((value) => value.isNotEmpty)
        .toList(growable: false);
  }

  static List<HomepageSignatureMenuItem> _extractSignatureMenu(
    Object? section,
  ) {
    if (section is! List) {
      return const [];
    }

    return section
        .whereType<Map<String, dynamic>>()
        .map(HomepageSignatureMenuItem.fromJson)
        .toList(growable: false);
  }

  static String _normalizeLocalImageUrl(String value) {
    return value
        .replaceFirst('http://localhost:3002', baseUrl)
        .replaceFirst('http://127.0.0.1:3002', baseUrl);
  }
}

class HomepageSignatureMenuItem {
  const HomepageSignatureMenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.priceGross,
    required this.imageUrl,
  });

  factory HomepageSignatureMenuItem.fromJson(Map<String, dynamic> json) {
    return HomepageSignatureMenuItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String? ?? '').trim(),
      description: (json['description'] as String? ?? '').trim(),
      priceGross: (json['priceGross'] as num?)?.toDouble() ?? 0,
      imageUrl: HomepageContent._normalizeLocalImageUrl(
        (json['imageUrl'] as String? ?? '').trim(),
      ),
    );
  }

  final int id;
  final String name;
  final String description;
  final double priceGross;
  final String imageUrl;

  String get formattedPriceGross {
    if (priceGross == priceGross.roundToDouble()) {
      return 'PLN ${priceGross.toStringAsFixed(0)}';
    }

    return 'PLN ${priceGross.toStringAsFixed(2)}';
  }

  String get displayDescription {
    if (description.isNotEmpty) {
      return description;
    }

    return 'Signature item #$id';
  }
}
