/// Compile-time configuration for the optional AI evaluation feature.
///
/// Values are supplied through `--dart-define`. Private builds can either use
/// a worker endpoint or call OpenRouter directly.
class AiEvaluationConfig {
  const AiEvaluationConfig({
    required this.baseUrl,
    required this.appToken,
    required this.openRouterApiKey,
    this.openRouterHttpReferer,
    this.openRouterAppTitle,
    this.provider = 'openrouter',
    this.model = 'openai/gpt-4.1-mini',
    this.schemaVersion = 1,
  });

  final String? baseUrl;
  final String? appToken;
  final String? openRouterApiKey;
  final String? openRouterHttpReferer;
  final String? openRouterAppTitle;
  final String provider;
  final String model;
  final int schemaVersion;

  bool get hasWorkerProxy => (baseUrl ?? '').trim().isNotEmpty;

  bool get hasDirectOpenRouterAccess =>
      (openRouterApiKey ?? '').trim().isNotEmpty;

  bool get isEnabled => hasWorkerProxy || hasDirectOpenRouterAccess;

  factory AiEvaluationConfig.fromEnvironment() {
    const rawBaseUrl = String.fromEnvironment(
      'AI_EVALUATION_BASE_URL',
      defaultValue: '',
    );
    const rawAppToken = String.fromEnvironment(
      'AI_EVALUATION_APP_TOKEN',
      defaultValue: '',
    );
    const rawOpenRouterApiKey = String.fromEnvironment(
      'AI_EVALUATION_OPENROUTER_API_KEY',
      defaultValue: '',
    );
    const rawOpenRouterHttpReferer = String.fromEnvironment(
      'AI_EVALUATION_OPENROUTER_HTTP_REFERER',
      defaultValue: '',
    );
    const rawOpenRouterAppTitle = String.fromEnvironment(
      'AI_EVALUATION_OPENROUTER_APP_TITLE',
      defaultValue: 'Innenkompass',
    );

    final trimmedBaseUrl = rawBaseUrl.trim();
    final trimmedAppToken = rawAppToken.trim();
    final trimmedOpenRouterApiKey = rawOpenRouterApiKey.trim();
    final trimmedOpenRouterHttpReferer = rawOpenRouterHttpReferer.trim();
    final trimmedOpenRouterAppTitle = rawOpenRouterAppTitle.trim();

    return AiEvaluationConfig(
      baseUrl: trimmedBaseUrl.isEmpty ? null : trimmedBaseUrl,
      appToken: trimmedAppToken.isEmpty ? null : trimmedAppToken,
      openRouterApiKey:
          trimmedOpenRouterApiKey.isEmpty ? null : trimmedOpenRouterApiKey,
      openRouterHttpReferer: trimmedOpenRouterHttpReferer.isEmpty
          ? null
          : trimmedOpenRouterHttpReferer,
      openRouterAppTitle:
          trimmedOpenRouterAppTitle.isEmpty ? null : trimmedOpenRouterAppTitle,
    );
  }
}
