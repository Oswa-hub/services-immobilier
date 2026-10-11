import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// Cloudinary account settings.
///
/// SECURITY: the app uses an *unsigned upload preset*, so only the cloud name and the
/// preset name live in the app. NEVER put the Cloudinary API secret in Flutter code.
/// In the Cloudinary dashboard (Settings > Upload > Upload presets) make the preset:
///   - Signing mode: Unsigned
///   - Asset folder: fixed (e.g. `users`), so uploads cannot go anywhere else
///   - Allowed formats: jpg, jpeg, png, webp   - and a maximum file size
class CloudinaryConfig {
  const CloudinaryConfig._();

  static const cloudName = 'YOUR_CLOUD_NAME'; // TODO: replace
  static const uploadPreset = 'YOUR_UNSIGNED_PRESET'; // TODO: replace

  static bool get isConfigured =>
      !cloudName.startsWith('YOUR_') && !uploadPreset.startsWith('YOUR_');
}

class CloudinaryUploadException implements Exception {
  const CloudinaryUploadException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Uploads an image to Cloudinary and returns its `secure_url`
/// (`https://res.cloudinary.com/CLOUD/image/upload/v123/FOLDER/ID.jpg`),
/// the same format `CloudinaryUrl` (core/utils) already knows how to resize.
class CloudinaryService {
  CloudinaryService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const maxBytes = 5 * 1024 * 1024; // 5 MB

  Future<String> uploadImage(
    Uint8List bytes, {
    required String filename,
    String? folder,
    String? publicId,
  }) async {
    if (!CloudinaryConfig.isConfigured) {
      throw const CloudinaryUploadException('Cloudinary is not configured yet.');
    }
    if (bytes.isEmpty) {
      throw const CloudinaryUploadException('The selected image is empty.');
    }
    if (bytes.length > maxBytes) {
      throw const CloudinaryUploadException('The image is too large (max 5 MB).');
    }

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = CloudinaryConfig.uploadPreset
      ..files.add(http.MultipartFile.fromBytes('file', bytes, filename: filename));
    if (folder != null) request.fields['folder'] = folder;
    // Unsigned presets may set public_id only if the preset allows it; if you want
    // one photo per user that is replaced on every upload, enable overwrite in the preset.
    if (publicId != null) request.fields['public_id'] = publicId;

    try {
      final streamed = await _client.send(request).timeout(const Duration(seconds: 45));
      final response = await http.Response.fromStream(streamed);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body is Map && body['secure_url'] is String) {
        return body['secure_url'] as String;
      }
      final apiMessage = body is Map && body['error'] is Map ? (body['error']['message'] ?? '') : '';
      throw CloudinaryUploadException(
        apiMessage.toString().isEmpty ? 'Upload failed (${response.statusCode}).' : apiMessage.toString(),
      );
    } on CloudinaryUploadException {
      rethrow;
    } catch (_) {
      throw const CloudinaryUploadException('Upload failed. Check your connection and try again.');
    }
  }
}
