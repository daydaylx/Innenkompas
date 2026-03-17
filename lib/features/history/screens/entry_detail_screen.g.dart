// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_detail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entryByIdHash() => r'87ef664a53401b882fa38cf38b285f62a2853c7a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [entryById].
@ProviderFor(entryById)
const entryByIdProvider = EntryByIdFamily();

/// See also [entryById].
class EntryByIdFamily extends Family<AsyncValue<SituationEntryData?>> {
  /// See also [entryById].
  const EntryByIdFamily();

  /// See also [entryById].
  EntryByIdProvider call(
    int id,
  ) {
    return EntryByIdProvider(
      id,
    );
  }

  @override
  EntryByIdProvider getProviderOverride(
    covariant EntryByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'entryByIdProvider';
}

/// See also [entryById].
class EntryByIdProvider extends AutoDisposeFutureProvider<SituationEntryData?> {
  /// See also [entryById].
  EntryByIdProvider(
    int id,
  ) : this._internal(
          (ref) => entryById(
            ref as EntryByIdRef,
            id,
          ),
          from: entryByIdProvider,
          name: r'entryByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$entryByIdHash,
          dependencies: EntryByIdFamily._dependencies,
          allTransitiveDependencies: EntryByIdFamily._allTransitiveDependencies,
          id: id,
        );

  EntryByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<SituationEntryData?> Function(EntryByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EntryByIdProvider._internal(
        (ref) => create(ref as EntryByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SituationEntryData?> createElement() {
    return _EntryByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntryByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EntryByIdRef on AutoDisposeFutureProviderRef<SituationEntryData?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _EntryByIdProviderElement
    extends AutoDisposeFutureProviderElement<SituationEntryData?>
    with EntryByIdRef {
  _EntryByIdProviderElement(super.provider);

  @override
  int get id => (origin as EntryByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
