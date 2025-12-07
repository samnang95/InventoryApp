import 'dart:convert';

import 'package:flutter/material.dart';

class Base64Helper {
  /// Extracts only the base64 part from a Data URL
  static String extractBase64(String dataUrl) {
    if (dataUrl.contains(',')) {
      return dataUrl.split(',').last;
    }
    return dataUrl;
  }

  /// Returns the image type (png, jpeg, etc.)
  static String? getImageType(String dataUrl) {
    if (dataUrl.startsWith('data:image/')) {
      final typePart = dataUrl.split(';').first;
      return typePart.replaceFirst('data:image/', '');
    }
    return null; // unknown
  }

  /// Converts base64 Data URL to Image widget
  static Image imageFromBase64(String dataUrl, {BoxFit fit = BoxFit.cover}) {
    final base64Str = extractBase64(dataUrl);
    final bytes = base64Decode(base64Str);
    return Image.memory(bytes, fit: fit);
  }
}