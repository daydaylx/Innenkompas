import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../application/controllers/crisis_controller.dart';
import '../../../domain/models/crisis_plan.dart';

/// Emergency contacts management section for settings.
class EmergencyContactsSection extends ConsumerWidget {
  const EmergencyContactsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final crisisState = ref.watch(crisisControllerProvider);
    final contacts = crisisState.emergencyContacts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with add button
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMedium,
          ),
          child: Row(
            children: [
              Text(
                'Deine Kontakte',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _openContactForm(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Hinzufügen'),
              ),
            ],
          ),
        ),

        if (contacts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMedium,
              vertical: AppConstants.spacingSmall,
            ),
            child: Text(
              'Noch keine persönlichen Kontakte gespeichert.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),

        // Contact list
        ...contacts.asMap().entries.map((entry) {
          final contact = entry.value;
          return _ContactListTile(
            contact: contact,
            onEdit: () => _openContactForm(context, ref, contact: contact),
            onDelete: () => _deleteContact(context, ref, contact.name),
          );
        }),
      ],
    );
  }

  Future<void> _openContactForm(
    BuildContext context,
    WidgetRef ref, {
    EmergencyContact? contact,
  }) async {
    final result = await showDialog<EmergencyContact>(
      context: context,
      builder: (ctx) => EmergencyContactFormDialog(contact: contact),
    );

    if (result != null) {
      final notifier = ref.read(crisisControllerProvider.notifier);
      if (contact != null) {
        // Update: remove old, add new
        final updatedContacts = ref
            .read(crisisControllerProvider)
            .emergencyContacts
            .where((c) => c.name != contact.name)
            .toList();
        updatedContacts.add(result);
        await notifier.updateEmergencyContacts(updatedContacts);
      } else {
        await notifier.addEmergencyContact(result);
      }
    }
  }

  Future<void> _deleteContact(
    BuildContext context,
    WidgetRef ref,
    String name,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kontakt löschen?'),
        content: Text('Möchtest du "$name" wirklich entfernen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(crisisControllerProvider.notifier)
          .removeEmergencyContact(name);
    }
  }
}

/// List tile for a single contact.
class _ContactListTile extends StatelessWidget {
  const _ContactListTile({
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  final EmergencyContact contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(Icons.person_outline, color: AppColors.primary),
        ),
        title: Text(contact.name, style: theme.textTheme.labelLarge),
        subtitle: Text(
          [
            contact.phoneNumber,
            if (contact.relationship != null) contact.relationship,
          ].join(' · '),
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: onEdit,
              tooltip: 'Bearbeiten',
            ),
            IconButton(
              icon:
                  Icon(Icons.delete_outline, size: 20, color: AppColors.error),
              onPressed: onDelete,
              tooltip: 'Löschen',
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog form for adding/editing an emergency contact.
class EmergencyContactFormDialog extends StatefulWidget {
  const EmergencyContactFormDialog({super.key, this.contact});

  final EmergencyContact? contact;

  @override
  State<EmergencyContactFormDialog> createState() =>
      _EmergencyContactFormDialogState();
}

class _EmergencyContactFormDialogState
    extends State<EmergencyContactFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _noteController;
  String? _selectedRelationship;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController =
        TextEditingController(text: widget.contact?.phoneNumber ?? '');
    _noteController = TextEditingController(text: widget.contact?.note ?? '');
    _selectedRelationship = widget.contact?.relationship;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.contact != null;

    return AlertDialog(
      title: Text(isEditing ? 'Kontakt bearbeiten' : 'Neuer Kontakt'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'z.B. Anna Müller',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Name erforderlich'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefonnummer *',
                  hintText: 'z.B. 0170 1234567',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Telefonnummer erforderlich'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRelationship,
                decoration: const InputDecoration(
                  labelText: 'Beziehung',
                ),
                items: AppConstants.emergencyContactLabels
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedRelationship = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Notiz (optional)',
                  hintText: 'z.B. Erreichbar bis 22 Uhr',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                EmergencyContact(
                  name: _nameController.text.trim(),
                  phoneNumber: _phoneController.text.trim(),
                  relationship: _selectedRelationship,
                  note: _noteController.text.trim().isNotEmpty
                      ? _noteController.text.trim()
                      : null,
                ),
              );
            }
          },
          child: Text(isEditing ? 'Speichern' : 'Hinzufügen'),
        ),
      ],
    );
  }
}
