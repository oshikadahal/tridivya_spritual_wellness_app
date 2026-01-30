import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class TestAssetBundle extends CachingAssetBundle {
  static final Uint8List _transparentImage = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.json') {
      final bytes = utf8.encode(jsonEncode(<String, dynamic>{}));
      return ByteData.view(Uint8List.fromList(bytes).buffer);
    }

    if (key == 'AssetManifest.bin') {
      final encoded = const StandardMessageCodec().encodeMessage(
        <String, Object?>{},
      )!;
      return encoded;
    }

    if (key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.jpeg')) {
      return ByteData.view(_transparentImage.buffer);
    }

    return ByteData.view(Uint8List(0).buffer);
  }
}
