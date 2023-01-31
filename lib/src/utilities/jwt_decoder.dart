import 'dart:convert';

class JwtDecoder {
  JwtDecoder._();
  static TokenPayload decode(String jwtToken) {
    final parts = jwtToken.split('.');
    if (parts.length != 3) {
      throw Exception('JwtDecoder: Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception("JwtDecoder: Invalid payload. Payload isn't a Map");
    }

    return TokenPayload.fromMap(payloadMap);
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('JwtDecoder: Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

class TokenPayload {
  final DateTime? createdDate;
  final DateTime? expiredDate;
  final Map<String, dynamic>? data;
  TokenPayload({this.createdDate, required this.expiredDate, this.data});

  factory TokenPayload.fromMap(Map<String, dynamic> payloadMap) {
    return TokenPayload(
      createdDate: payloadMap["iat"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(payloadMap["iat"] * 1000),
      expiredDate: payloadMap["exp"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(payloadMap["exp"] * 1000),
      data: payloadMap,
    );
  }

  bool get isExpired =>
      expiredDate != null ? DateTime.now().isAfter(expiredDate!) : false;

  @override
  String toString() {
    return "Token payload: ${data.toString()}, Created date: $createdDate, Expired date: $expiredDate";
  }
}
