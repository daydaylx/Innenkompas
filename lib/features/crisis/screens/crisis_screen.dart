import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../application/controllers/crisis_controller.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_crisis_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/navigation/app_main_navigation.dart';
import '../widgets/crisis_widgets.dart';

/// Main crisis screen — always accessible, even without onboarding.
class CrisisScreen extends ConsumerWidget {
  const CrisisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final crisisState = ref.watch(crisisControllerProvider);
    final plan = crisisState.crisisPlan;

    return AppScaffold(
      title: 'Krisenhilfe',
      backgroundVariant: AppBackgroundVariant.crisis,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => context.push(AppRoutes.crisisEdit),
          tooltip: 'Krisenplan bearbeiten',
        ),
      ],
      header: AppCard(
        variant: AppCardVariant.crisis,
        margin: EdgeInsets.zero,
        child: _SafetyHeader(theme: theme),
      ),
      bottomNavigationBar: const AppMainNavigationBar(
        currentRoute: AppRoutes.crisis,
      ),
      body: crisisState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingMedium,
                0,
                AppConstants.spacingMedium,
                AppConstants.spacingXLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notfallkontakte',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),

                  // Static crisis hotlines
                  CrisisContactCard(
                    name: 'Telefonseelsorge',
                    phoneNumber: '0800 111 0 111',
                    subtitle: '24 Stunden, kostenlos & anonym',
                    onTap: () => _callNumber('08001110111'),
                  ),
                  CrisisContactCard(
                    name: 'Telefonseelsorge (alternativ)',
                    phoneNumber: '0800 111 0 222',
                    onTap: () => _callNumber('08001110222'),
                  ),
                  CrisisContactCard(
                    name: 'Notruf',
                    phoneNumber: '112',
                    subtitle: 'Bei akuter Lebensgefahr',
                    onTap: () => _callNumber('112'),
                  ),

                  // User's emergency contacts
                  if (crisisState.emergencyContacts.isNotEmpty) ...[
                    const SizedBox(height: AppConstants.spacingMedium),
                    ...crisisState.emergencyContacts.map(
                      (contact) => CrisisContactCard(
                        name: contact.name,
                        phoneNumber: contact.phoneNumber,
                        subtitle: contact.relationship,
                        onTap: () => _callNumber(
                          contact.phoneNumber.replaceAll(' ', ''),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Quick actions
                  Text(
                    'Sofort-Hilfe',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),

                  Row(
                    children: [
                      Expanded(
                        child: CrisisQuickAction(
                          icon: Icons.air,
                          label: 'Atemübung',
                          description: 'Beruhige dein Nervensystem',
                          color: AppColors.primary,
                          onTap: () {
                            context.push(AppRoutes.intervention, extra: {
                              'interventionId': 'regulation_4_6_breathing',
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingMedium),
                      Expanded(
                        child: CrisisQuickAction(
                          icon: Icons.landscape_outlined,
                          label: 'Erdung',
                          description: 'Finde Halt im Moment',
                          color: AppColors.success,
                          onTap: () {
                            context.push(AppRoutes.intervention, extra: {
                              'interventionId': 'grounding_5_4_3_2_1',
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),

                  // Crisis plan preview
                  if (plan != null) ...[
                    Text(
                      'Dein Krisenplan',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),

                    if (plan.warningSigns.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Warnzeichen',
                        icon: Icons.warning_amber_outlined,
                        items: plan.warningSigns,
                      ),

                    if (plan.copingStrategies.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Was mir hilft',
                        icon: Icons.favorite_outline,
                        items: plan.copingStrategies,
                      ),

                    if (plan.safeEnvironment != null &&
                        plan.safeEnvironment!.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Sicherer Ort',
                        icon: Icons.shield_outlined,
                        items: [plan.safeEnvironment!],
                      ),

                    if (plan.socialSupport.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.spacingSmall,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.people_outline,
                              size: 20,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppConstants.spacingSmall),
                            Text(
                              'Menschen, die mich begleiten',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...plan.socialSupport.map(
                        (contact) => CrisisContactCard(
                          name: contact.name,
                          phoneNumber: contact.phoneNumber,
                          subtitle: contact.relationship,
                          onTap: () => _callNumber(
                            contact.phoneNumber.replaceAll(' ', ''),
                          ),
                        ),
                      ),
                    ],

                    if (plan.professionalResources
                        .any((r) => (r.phoneNumber ?? '').isNotEmpty)) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.spacingSmall,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_hospital_outlined,
                              size: 20,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppConstants.spacingSmall),
                            Text(
                              'Professionelle Hilfen',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...plan.professionalResources
                          .where((r) => (r.phoneNumber ?? '').isNotEmpty)
                          .map(
                            (r) => CrisisContactCard(
                              name: r.name,
                              phoneNumber: r.phoneNumber!,
                              subtitle: r.type,
                              onTap: () => _callNumber(
                                r.phoneNumber!.replaceAll(' ', ''),
                              ),
                            ),
                          ),
                    ] else if (plan.professionalResources.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Professionelle Hilfen',
                        icon: Icons.local_hospital_outlined,
                        items: plan.professionalResources
                            .map(
                              (r) => [
                                r.name,
                                if ((r.type ?? '').isNotEmpty) r.type!,
                              ].join(' · '),
                            )
                            .toList(),
                      ),

                    if (plan.localResources.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Lokale Hilfen',
                        icon: Icons.place_outlined,
                        items: plan.localResources
                            .map(
                              (resource) => [
                                resource.name,
                                if ((resource.description ?? '').isNotEmpty)
                                  resource.description!,
                                if ((resource.phoneNumber ?? '').isNotEmpty)
                                  resource.phoneNumber!,
                              ].join(' · '),
                            )
                            .toList(),
                      ),

                    if (plan.personalMotivation != null &&
                        plan.personalMotivation!.isNotEmpty)
                      CrisisPlanPreviewSection(
                        title: 'Meine Gründe',
                        icon: Icons.lightbulb_outline,
                        items: [plan.personalMotivation!],
                      ),

                    const SizedBox(height: AppConstants.spacingMedium),

                    // Edit full plan button
                    SizedBox(
                      width: double.infinity,
                      child: AppSecondaryButton(
                        onPressed: () => context.push(AppRoutes.crisisEdit),
                        icon: Icons.edit_note,
                        label: 'Krisenplan bearbeiten',
                      ),
                    ),
                  ] else ...[
                    AppCard(
                      variant: AppCardVariant.soft,
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 48,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(
                            'Noch kein Krisenplan vorhanden',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(
                            'Erstelle deinen persönlichen Krisenplan, um im Ernstfall vorbereitet zu sein.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppConstants.spacingMedium),
                          AppCrisisButton(
                            onPressed: () => context.push(AppRoutes.crisisEdit),
                            icon: Icons.add,
                            label: 'Krisenplan erstellen',
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: AppConstants.spacingXLarge),
                ],
              ),
            ),
    );
  }

  void _callNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

/// Safety header with reassuring message.
class _SafetyHeader extends StatelessWidget {
  const _SafetyHeader({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.errorSoft,
            AppColors.crisisSurface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppColors.errorLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 24,
              color: AppColors.crisis,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            'Du bist nicht allein',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.crisis,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            'Es ist okay, Hilfe zu brauchen. '
            'Hier findest du sofortige Unterstützung.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
