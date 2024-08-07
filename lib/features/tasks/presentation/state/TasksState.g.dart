// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TasksState.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$priorityTasksStateHash() =>
    r'658807381d649a421d26f9da064b92430338f573';

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

abstract class _$priorityTasksState extends BuildlessAutoDisposeAsyncNotifier<
    Either<Failure, List<Prioritytask>>> {
  late final WidgetRef remoteref;

  FutureOr<Either<Failure, List<Prioritytask>>> build(
    WidgetRef remoteref,
  );
}

/// See also [priorityTasksState].
@ProviderFor(priorityTasksState)
const priorityTasksStateProvider = PriorityTasksStateFamily();

/// See also [priorityTasksState].
class PriorityTasksStateFamily
    extends Family<AsyncValue<Either<Failure, List<Prioritytask>>>> {
  /// See also [priorityTasksState].
  const PriorityTasksStateFamily();

  /// See also [priorityTasksState].
  PriorityTasksStateProvider call(
    WidgetRef remoteref,
  ) {
    return PriorityTasksStateProvider(
      remoteref,
    );
  }

  @override
  PriorityTasksStateProvider getProviderOverride(
    covariant PriorityTasksStateProvider provider,
  ) {
    return call(
      provider.remoteref,
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
  String? get name => r'priorityTasksStateProvider';
}

/// See also [priorityTasksState].
class PriorityTasksStateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    priorityTasksState, Either<Failure, List<Prioritytask>>> {
  /// See also [priorityTasksState].
  PriorityTasksStateProvider(
    WidgetRef remoteref,
  ) : this._internal(
          () => priorityTasksState()..remoteref = remoteref,
          from: priorityTasksStateProvider,
          name: r'priorityTasksStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$priorityTasksStateHash,
          dependencies: PriorityTasksStateFamily._dependencies,
          allTransitiveDependencies:
              PriorityTasksStateFamily._allTransitiveDependencies,
          remoteref: remoteref,
        );

  PriorityTasksStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.remoteref,
  }) : super.internal();

  final WidgetRef remoteref;

  @override
  FutureOr<Either<Failure, List<Prioritytask>>> runNotifierBuild(
    covariant priorityTasksState notifier,
  ) {
    return notifier.build(
      remoteref,
    );
  }

  @override
  Override overrideWith(priorityTasksState Function() create) {
    return ProviderOverride(
      origin: this,
      override: PriorityTasksStateProvider._internal(
        () => create()..remoteref = remoteref,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        remoteref: remoteref,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<priorityTasksState,
      Either<Failure, List<Prioritytask>>> createElement() {
    return _PriorityTasksStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PriorityTasksStateProvider && other.remoteref == remoteref;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, remoteref.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PriorityTasksStateRef on AutoDisposeAsyncNotifierProviderRef<
    Either<Failure, List<Prioritytask>>> {
  /// The parameter `remoteref` of this provider.
  WidgetRef get remoteref;
}

class _PriorityTasksStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<priorityTasksState,
        Either<Failure, List<Prioritytask>>> with PriorityTasksStateRef {
  _PriorityTasksStateProviderElement(super.provider);

  @override
  WidgetRef get remoteref => (origin as PriorityTasksStateProvider).remoteref;
}

String _$dailyTasksStateHash() => r'a7f78d491e25da36c85e0a8fe5ebb8d04f6448d9';

abstract class _$dailyTasksState extends BuildlessAutoDisposeAsyncNotifier<
    Either<Failure, List<Dailytask>>> {
  late final WidgetRef remoteRef;

  FutureOr<Either<Failure, List<Dailytask>>> build(
    WidgetRef remoteRef,
  );
}

/// See also [dailyTasksState].
@ProviderFor(dailyTasksState)
const dailyTasksStateProvider = DailyTasksStateFamily();

/// See also [dailyTasksState].
class DailyTasksStateFamily
    extends Family<AsyncValue<Either<Failure, List<Dailytask>>>> {
  /// See also [dailyTasksState].
  const DailyTasksStateFamily();

  /// See also [dailyTasksState].
  DailyTasksStateProvider call(
    WidgetRef remoteRef,
  ) {
    return DailyTasksStateProvider(
      remoteRef,
    );
  }

  @override
  DailyTasksStateProvider getProviderOverride(
    covariant DailyTasksStateProvider provider,
  ) {
    return call(
      provider.remoteRef,
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
  String? get name => r'dailyTasksStateProvider';
}

/// See also [dailyTasksState].
class DailyTasksStateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    dailyTasksState, Either<Failure, List<Dailytask>>> {
  /// See also [dailyTasksState].
  DailyTasksStateProvider(
    WidgetRef remoteRef,
  ) : this._internal(
          () => dailyTasksState()..remoteRef = remoteRef,
          from: dailyTasksStateProvider,
          name: r'dailyTasksStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyTasksStateHash,
          dependencies: DailyTasksStateFamily._dependencies,
          allTransitiveDependencies:
              DailyTasksStateFamily._allTransitiveDependencies,
          remoteRef: remoteRef,
        );

  DailyTasksStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.remoteRef,
  }) : super.internal();

  final WidgetRef remoteRef;

  @override
  FutureOr<Either<Failure, List<Dailytask>>> runNotifierBuild(
    covariant dailyTasksState notifier,
  ) {
    return notifier.build(
      remoteRef,
    );
  }

  @override
  Override overrideWith(dailyTasksState Function() create) {
    return ProviderOverride(
      origin: this,
      override: DailyTasksStateProvider._internal(
        () => create()..remoteRef = remoteRef,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        remoteRef: remoteRef,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<dailyTasksState,
      Either<Failure, List<Dailytask>>> createElement() {
    return _DailyTasksStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyTasksStateProvider && other.remoteRef == remoteRef;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, remoteRef.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DailyTasksStateRef
    on AutoDisposeAsyncNotifierProviderRef<Either<Failure, List<Dailytask>>> {
  /// The parameter `remoteRef` of this provider.
  WidgetRef get remoteRef;
}

class _DailyTasksStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<dailyTasksState,
        Either<Failure, List<Dailytask>>> with DailyTasksStateRef {
  _DailyTasksStateProviderElement(super.provider);

  @override
  WidgetRef get remoteRef => (origin as DailyTasksStateProvider).remoteRef;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
