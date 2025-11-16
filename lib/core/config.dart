import 'package:flutter_riverpod/flutter_riverpod.dart';

class Config {
  final String baseUrl;
  final bool isTestMode;
  const Config({
    required this.baseUrl,
    required this.isTestMode,
  });
}

// 기본값: 테스트 모드 활성화하여 MockRepository 사용
final configProvider = Provider<Config>((ref) {
  return const Config(
    baseUrl: 'https://example.com',
    isTestMode: false,
  );
});


