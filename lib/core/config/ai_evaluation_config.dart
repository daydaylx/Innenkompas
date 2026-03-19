/// Compile-time configuration for the optional AI evaluation feature.
///
/// Values are supplied through `--dart-define` so no provider credentials need
/// to live in the mobile app bundle.
class AiEvaluationConfig {
  const AiEvaluationConfig({
    required this.baseUrl,
    required this.appToken,
    this.provider = 'openrouter',
    this.model = 'openai/gpt-4.1-mini',
    this.schemaVersion = 1,
  });

  final String? baseUrl;
  final String? appToken;
  final String provider;
  final String model;
  final int schemaVersion;

  bool get isEnabled => (baseUrl ?? '').trim().isNotEmpty;

  factory AiEvaluationConfig.fromEnvironment() {
    const rawBaseUrl = String.fromEnvironment(
      'AI_EVALUATION_BASE_URL',
      defaultValue: '',
    );
    const rawAppToken = String.fromEnvironment(
      'AI_EVALUATION_APP_TOKEN',
      defaultValue: '',
    );

    final trimmedBaseUrl = rawBaseUrl.trim();
    final trimmedAppToken = rawAppToken.trim();

    return AiEvaluationConfig(
      baseUrl: trimmedBaseUrl.isEmpty ? null : trimmedBaseUrl,
      appToken: trimmedAppToken.isEmpty ? null : trimmedAppToken,
    );
  }
}
