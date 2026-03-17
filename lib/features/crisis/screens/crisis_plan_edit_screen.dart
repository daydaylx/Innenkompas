import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/colors.dart';
import '../../../application/controllers/crisis_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/models/crisis_plan.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';

/// Full editor for the personalized crisis plan.
class CrisisPlanEditScreen extends ConsumerStatefulWidget {
  const CrisisPlanEditScreen({super.key});

  @override
  ConsumerState<CrisisPlanEditScreen> createState() =>
      _CrisisPlanEditScreenState();
}

class _CrisisPlanEditScreenState extends ConsumerState<CrisisPlanEditScreen> {
  final _safeEnvironmentController = TextEditingController();
  final _motivationController = TextEditingController();

  bool _initialized = false;
  bool _isSaving = false;
  List<String> _warningSigns = [];
  List<String> _copingStrategies = [];
  List<EmergencyContact> _socialSupport = [];
  List<EmergencyContact> _emergencyContacts = [];
  List<ProfessionalResource> _professionalResources = [];
  List<LocalResource> _localResources = [];

  @override
  void dispose() {
    _safeEnvironmentController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  void _hydrate(CrisisPlan plan) {
    if (_initialized) return;
    _warningSigns = List<String>.from(plan.warningSigns);
    _copingStrategies = List<String>.from(plan.copingStrategies);
    _socialSupport = List<EmergencyContact>.from(plan.socialSupport);
    _emergencyContacts = List<EmergencyContact>.from(plan.emergencyContacts);
    _professionalResources =
        List<ProfessionalResource>.from(plan.professionalResources);
    _localResources = List<LocalResource>.from(plan.localResources);
    _safeEnvironmentController.text = plan.safeEnvironment ?? '';
    _motivationController.text = plan.personalMotivation ?? '';
    _initialized = true;
  }

  Future<void> _save(CrisisPlan basePlan) async {
    setState(() {
      _isSaving = true;
    });

    final updatedPlan = CrisisPlan(
      id: basePlan.id,
      warningSigns: _warningSigns,
      copingStrategies: _copingStrategies,
      socialSupport: _socialSupport,
      safeEnvironment: _safeEnvironmentController.text.trim().isEmpty
          ? null
          : _safeEnvironmentController.text.trim(),
      professionalResources: _professionalResources,
      emergencyContacts: _emergencyContacts,
      localResources: _localResources,
      personalMotivation: _motivationController.text.trim().isEmpty
          ? null
          : _motivationController.text.trim(),
      createdAt: basePlan.createdAt,
      updatedAt: basePlan.updatedAt,
    );

    await ref
        .read(crisisControllerProvider.notifier)
        .updateCrisisPlan(updatedPlan);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Krisenplan gespeichert')),
    );
    context.pop();
  }

  Future<void> _editContact({
    required bool isEmergencyContact,
    EmergencyContact? initialValue,
    int? index,
  }) async {
    final result = await showDialog<EmergencyContact>(
      context: context,
      builder: (context) => _EmergencyContactDialog(contact: initialValue),
    );

    if (result == null) return;

    setState(() {
      final target = isEmergencyContact ? _emergencyContacts : _socialSupport;
      if (index == null) {
        target.add(result);
      } else {
        target[index] = result;
      }
    });
  }

  Future<void> _editProfessionalResource({
    ProfessionalResource? initialValue,
    int? index,
  }) async {
    final result = await showDialog<ProfessionalResource>(
      context: context,
      builder: (context) => _ProfessionalResourceDialog(resource: initialValue),
    );

    if (result == null) return;

    setState(() {
      if (index == null) {
        _professionalResources.add(result);
      } else {
        _professionalResources[index] = result;
      }
    });
  }

  Future<void> _editLocalResource({
    LocalResource? initialValue,
    int? index,
  }) async {
    final result = await showDialog<LocalResource>(
      context: context,
      builder: (context) => _LocalResourceDialog(resource: initialValue),
    );

    if (result == null) return;

    setState(() {
      if (index == null) {
        _localResources.add(result);
      } else {
        _localResources[index] = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crisisState = ref.watch(crisisControllerProvider);
    final plan = crisisState.crisisPlan ?? const CrisisPlan();

    _hydrate(plan);

    return AppScaffold(
      title: 'Krisenplan bearbeiten',
      backgroundVariant: AppBackgroundVariant.crisis,
      body: crisisState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingMedium,
                AppConstants.spacingSmall,
                AppConstants.spacingMedium,
                AppConstants.spacingXLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCard(
                    variant: AppCardVariant.crisis,
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Persönlicher Krisenplan',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          'Halte fest, woran du Krisen früh erkennst, was dich stabilisiert und wen oder was du schnell erreichen willst.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _StringListSection(
                    icon: Icons.warning_amber_outlined,
                    title: 'Warnzeichen',
                    subtitle:
                        'Welche frühen Signale zeigen dir, dass es kritisch wird?',
                    items: _warningSigns,
                    hintText: 'z.B. Schlafprobleme, Rückzug, innere Unruhe',
                    onChanged: (items) {
                      setState(() {
                        _warningSigns = items;
                      });
                    },
                  ),
                  _StringListSection(
                    icon: Icons.favorite_outline,
                    title: 'Was mir hilft',
                    subtitle:
                        'Welche Strategien helfen dir in belasteten Momenten?',
                    items: _copingStrategies,
                    hintText: 'z.B. kaltes Wasser, atmen, kurze Runde laufen',
                    onChanged: (items) {
                      setState(() {
                        _copingStrategies = items;
                      });
                    },
                  ),
                  _ContactSection(
                    title: 'Menschen, die mich begleiten',
                    subtitle:
                        'Vertrauenspersonen, die dir Stabilität und Nähe geben.',
                    icon: Icons.people_outline,
                    contacts: _socialSupport,
                    addLabel: 'Begleitperson hinzufügen',
                    onAdd: () => _editContact(isEmergencyContact: false),
                    onEdit: (contact, index) => _editContact(
                      isEmergencyContact: false,
                      initialValue: contact,
                      index: index,
                    ),
                    onDelete: (index) {
                      setState(() {
                        _socialSupport.removeAt(index);
                      });
                    },
                  ),
                  _ContactSection(
                    title: 'Notfallkontakte',
                    subtitle:
                        'Personen, die du in akuten Momenten sofort erreichen möchtest.',
                    icon: Icons.call_outlined,
                    contacts: _emergencyContacts,
                    addLabel: 'Notfallkontakt hinzufügen',
                    onAdd: () => _editContact(isEmergencyContact: true),
                    onEdit: (contact, index) => _editContact(
                      isEmergencyContact: true,
                      initialValue: contact,
                      index: index,
                    ),
                    onDelete: (index) {
                      setState(() {
                        _emergencyContacts.removeAt(index);
                      });
                    },
                  ),
                  _ProfessionalResourceSection(
                    resources: _professionalResources,
                    onAdd: () => _editProfessionalResource(),
                    onEdit: (resource, index) => _editProfessionalResource(
                      initialValue: resource,
                      index: index,
                    ),
                    onDelete: (index) {
                      setState(() {
                        _professionalResources.removeAt(index);
                      });
                    },
                  ),
                  _LocalResourceSection(
                    resources: _localResources,
                    onAdd: () => _editLocalResource(),
                    onEdit: (resource, index) => _editLocalResource(
                      initialValue: resource,
                      index: index,
                    ),
                    onDelete: (index) {
                      setState(() {
                        _localResources.removeAt(index);
                      });
                    },
                  ),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sicherer Ort',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          'Wo kannst du dich hinbewegen oder zurückziehen, um wieder sicherer zu werden?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
                        TextField(
                          controller: _safeEnvironmentController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText:
                                'z.B. Schlafzimmer, Balkon, ruhiger Park, Praxisraum',
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppCard(
                    variant: AppCardVariant.soft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Meine Gründe',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          'Was erinnert dich in schweren Momenten daran, weiterzugehen?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
                        TextField(
                          controller: _motivationController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText:
                                'z.B. Menschen, Verantwortung, Vorhaben, Verbundenheit, Zukunft',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXLarge),
                  Row(
                    children: [
                      Expanded(
                        child: AppSecondaryButton(
                          onPressed: _isSaving ? null : () => context.pop(),
                          label: 'Abbrechen',
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingMedium),
                      Expanded(
                        child: AppPrimaryButton(
                          onPressed: _isSaving ? null : () => _save(plan),
                          label: 'Speichern',
                          isLoading: _isSaving,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: AppConstants.spacingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StringListSection extends StatelessWidget {
  const _StringListSection({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> items;
  final String hintText;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle(icon: icon, title: title, subtitle: subtitle),
          const SizedBox(height: AppConstants.spacingMedium),
          _ChipListEditor(
            items: items,
            hintText: hintText,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.contacts,
    required this.addLabel,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<EmergencyContact> contacts;
  final String addLabel;
  final VoidCallback onAdd;
  final void Function(EmergencyContact contact, int index) onEdit;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.soft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle(icon: icon, title: title, subtitle: subtitle),
          const SizedBox(height: AppConstants.spacingMedium),
          _SectionActionButton(
            label: addLabel,
            icon: Icons.add,
            onPressed: onAdd,
          ),
          if (contacts.isEmpty) ...[
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              'Noch nichts hinterlegt.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ] else ...[
            const SizedBox(height: AppConstants.spacingSmall),
            ...contacts.asMap().entries.map(
                  (entry) => _EditableTile(
                    title: entry.value.name,
                    subtitle: [
                      entry.value.phoneNumber,
                      if ((entry.value.relationship ?? '').isNotEmpty)
                        entry.value.relationship!,
                      if ((entry.value.note ?? '').isNotEmpty)
                        entry.value.note!,
                    ].join(' · '),
                    onEdit: () => onEdit(entry.value, entry.key),
                    onDelete: () => onDelete(entry.key),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _ProfessionalResourceSection extends StatelessWidget {
  const _ProfessionalResourceSection({
    required this.resources,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final List<ProfessionalResource> resources;
  final VoidCallback onAdd;
  final void Function(ProfessionalResource resource, int index) onEdit;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionTitle(
            icon: Icons.local_hospital_outlined,
            title: 'Professionelle Hilfen',
            subtitle:
                'Therapie, Praxis, Klinik oder andere professionelle Anlaufstellen.',
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          _SectionActionButton(
            label: 'Professionelle Hilfe hinzufügen',
            icon: Icons.add,
            onPressed: onAdd,
          ),
          if (resources.isEmpty) ...[
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              'Noch nichts hinterlegt.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ] else ...[
            const SizedBox(height: AppConstants.spacingSmall),
            ...resources.asMap().entries.map(
                  (entry) => _EditableTile(
                    title: entry.value.name,
                    subtitle: [
                      if ((entry.value.type ?? '').isNotEmpty)
                        entry.value.type!,
                      if ((entry.value.phoneNumber ?? '').isNotEmpty)
                        entry.value.phoneNumber!,
                      if ((entry.value.address ?? '').isNotEmpty)
                        entry.value.address!,
                    ].join(' · '),
                    onEdit: () => onEdit(entry.value, entry.key),
                    onDelete: () => onDelete(entry.key),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _LocalResourceSection extends StatelessWidget {
  const _LocalResourceSection({
    required this.resources,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final List<LocalResource> resources;
  final VoidCallback onAdd;
  final void Function(LocalResource resource, int index) onEdit;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.soft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionTitle(
            icon: Icons.place_outlined,
            title: 'Lokale Hilfen',
            subtitle: 'Orte, Gruppen oder Angebote in deiner Nähe.',
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          _SectionActionButton(
            label: 'Lokale Hilfe hinzufügen',
            icon: Icons.add,
            onPressed: onAdd,
          ),
          if (resources.isEmpty) ...[
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              'Noch nichts hinterlegt.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ] else ...[
            const SizedBox(height: AppConstants.spacingSmall),
            ...resources.asMap().entries.map(
                  (entry) => _EditableTile(
                    title: entry.value.name,
                    subtitle: [
                      if ((entry.value.description ?? '').isNotEmpty)
                        entry.value.description!,
                      if ((entry.value.phoneNumber ?? '').isNotEmpty)
                        entry.value.phoneNumber!,
                      if ((entry.value.address ?? '').isNotEmpty)
                        entry.value.address!,
                    ].join(' · '),
                    onEdit: () => onEdit(entry.value, entry.key),
                    onDelete: () => onDelete(entry.key),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _SectionActionButton extends StatelessWidget {
  const _SectionActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _EditableTile extends StatelessWidget {
  const _EditableTile({
    required this.title,
    required this.subtitle,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppConstants.spacingSmall),
      decoration: BoxDecoration(
        color: AppColors.surfaceStrong.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle.isEmpty ? null : Text(subtitle),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Bearbeiten',
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Entfernen',
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipListEditor extends StatefulWidget {
  const _ChipListEditor({
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  final List<String> items;
  final String hintText;
  final ValueChanged<List<String>> onChanged;

  @override
  State<_ChipListEditor> createState() => _ChipListEditorState();
}

class _ChipListEditorState extends State<_ChipListEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onChanged([...widget.items, value]);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: widget.hintText),
                onSubmitted: (_) => _addItem(),
              ),
            ),
            const SizedBox(width: AppConstants.spacingSmall),
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        if (widget.items.isNotEmpty) ...[
          const SizedBox(height: AppConstants.spacingSmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.items.asMap().entries.map((entry) {
              return InputChip(
                label: Text(entry.value),
                onDeleted: () {
                  final items = List<String>.from(widget.items)
                    ..removeAt(entry.key);
                  widget.onChanged(items);
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class _EmergencyContactDialog extends StatefulWidget {
  const _EmergencyContactDialog({this.contact});

  final EmergencyContact? contact;

  @override
  State<_EmergencyContactDialog> createState() =>
      _EmergencyContactDialogState();
}

class _EmergencyContactDialogState extends State<_EmergencyContactDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController =
        TextEditingController(text: widget.contact?.phoneNumber ?? '');
    _relationshipController =
        TextEditingController(text: widget.contact?.relationship ?? '');
    _noteController = TextEditingController(text: widget.contact?.note ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.contact == null ? 'Kontakt hinzufügen' : 'Kontakt bearbeiten'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Bitte Name angeben'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefonnummer'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Bitte Telefonnummer angeben'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _relationshipController,
                decoration:
                    const InputDecoration(labelText: 'Beziehung / Rolle'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Notiz'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.of(context).pop(
              EmergencyContact(
                name: _nameController.text.trim(),
                phoneNumber: _phoneController.text.trim(),
                relationship: _relationshipController.text.trim().isEmpty
                    ? null
                    : _relationshipController.text.trim(),
                note: _noteController.text.trim().isEmpty
                    ? null
                    : _noteController.text.trim(),
              ),
            );
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}

class _ProfessionalResourceDialog extends StatefulWidget {
  const _ProfessionalResourceDialog({this.resource});

  final ProfessionalResource? resource;

  @override
  State<_ProfessionalResourceDialog> createState() =>
      _ProfessionalResourceDialogState();
}

class _ProfessionalResourceDialogState
    extends State<_ProfessionalResourceDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _typeController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _websiteController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.resource?.name ?? '');
    _typeController = TextEditingController(text: widget.resource?.type ?? '');
    _phoneController =
        TextEditingController(text: widget.resource?.phoneNumber ?? '');
    _addressController =
        TextEditingController(text: widget.resource?.address ?? '');
    _websiteController =
        TextEditingController(text: widget.resource?.website ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.resource == null
          ? 'Professionelle Hilfe hinzufügen'
          : 'Professionelle Hilfe bearbeiten'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Bitte Name angeben'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _typeController,
                decoration:
                    const InputDecoration(labelText: 'Art / Fachrichtung'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefonnummer'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Adresse'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(labelText: 'Webseite'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.of(context).pop(
              ProfessionalResource(
                name: _nameController.text.trim(),
                type: _typeController.text.trim().isEmpty
                    ? null
                    : _typeController.text.trim(),
                phoneNumber: _phoneController.text.trim().isEmpty
                    ? null
                    : _phoneController.text.trim(),
                address: _addressController.text.trim().isEmpty
                    ? null
                    : _addressController.text.trim(),
                website: _websiteController.text.trim().isEmpty
                    ? null
                    : _websiteController.text.trim(),
              ),
            );
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}

class _LocalResourceDialog extends StatefulWidget {
  const _LocalResourceDialog({this.resource});

  final LocalResource? resource;

  @override
  State<_LocalResourceDialog> createState() => _LocalResourceDialogState();
}

class _LocalResourceDialogState extends State<_LocalResourceDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.resource?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.resource?.description ?? '');
    _phoneController =
        TextEditingController(text: widget.resource?.phoneNumber ?? '');
    _addressController =
        TextEditingController(text: widget.resource?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.resource == null
          ? 'Lokale Hilfe hinzufügen'
          : 'Lokale Hilfe bearbeiten'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Bitte Name angeben'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Beschreibung'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefonnummer'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Adresse'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.of(context).pop(
              LocalResource(
                name: _nameController.text.trim(),
                description: _descriptionController.text.trim().isEmpty
                    ? null
                    : _descriptionController.text.trim(),
                phoneNumber: _phoneController.text.trim().isEmpty
                    ? null
                    : _phoneController.text.trim(),
                address: _addressController.text.trim().isEmpty
                    ? null
                    : _addressController.text.trim(),
              ),
            );
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
