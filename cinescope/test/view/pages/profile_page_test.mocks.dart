// Mocks generated by Mockito 5.4.0 from annotations
// in cinescope/test/view/pages/profile_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;
import 'dart:ui' as _i5;

import 'package:cinescope/model/profile.dart' as _i3;
import 'package:cinescope/model/providers/profile_provider.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeStreamController_0<T> extends _i1.SmartFake
    implements _i2.StreamController<T> {
  _FakeStreamController_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProfile_1 extends _i1.SmartFake implements _i3.Profile {
  _FakeProfile_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProfileProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileProvider extends _i1.Mock implements _i4.ProfileProvider {
  @override
  _i2.StreamController<bool> get loadedController => (super.noSuchMethod(
        Invocation.getter(#loadedController),
        returnValue: _FakeStreamController_0<bool>(
          this,
          Invocation.getter(#loadedController),
        ),
        returnValueForMissingStub: _FakeStreamController_0<bool>(
          this,
          Invocation.getter(#loadedController),
        ),
      ) as _i2.StreamController<bool>);
  @override
  bool get lastLoaded => (super.noSuchMethod(
        Invocation.getter(#lastLoaded),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set lastLoaded(bool? _lastLoaded) => super.noSuchMethod(
        Invocation.setter(
          #lastLoaded,
          _lastLoaded,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.Stream<bool> get loaded => (super.noSuchMethod(
        Invocation.getter(#loaded),
        returnValue: _i2.Stream<bool>.empty(),
        returnValueForMissingStub: _i2.Stream<bool>.empty(),
      ) as _i2.Stream<bool>);
  @override
  set loaded(_i2.Stream<bool>? _loaded) => super.noSuchMethod(
        Invocation.setter(
          #loaded,
          _loaded,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i3.Profile getProfile() => (super.noSuchMethod(
        Invocation.method(
          #getProfile,
          [],
        ),
        returnValue: _FakeProfile_1(
          this,
          Invocation.method(
            #getProfile,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeProfile_1(
          this,
          Invocation.method(
            #getProfile,
            [],
          ),
        ),
      ) as _i3.Profile);
  @override
  _i2.Future<_i3.Profile> getProfileByUid({String? uid}) => (super.noSuchMethod(
        Invocation.method(
          #getProfileByUid,
          [],
          {#uid: uid},
        ),
        returnValue: _i2.Future<_i3.Profile>.value(_FakeProfile_1(
          this,
          Invocation.method(
            #getProfileByUid,
            [],
            {#uid: uid},
          ),
        )),
        returnValueForMissingStub: _i2.Future<_i3.Profile>.value(_FakeProfile_1(
          this,
          Invocation.method(
            #getProfileByUid,
            [],
            {#uid: uid},
          ),
        )),
      ) as _i2.Future<_i3.Profile>);
  @override
  _i2.Future<_i3.Profile> getProfileByUidReload({String? uid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProfileByUidReload,
          [],
          {#uid: uid},
        ),
        returnValue: _i2.Future<_i3.Profile>.value(_FakeProfile_1(
          this,
          Invocation.method(
            #getProfileByUidReload,
            [],
            {#uid: uid},
          ),
        )),
        returnValueForMissingStub: _i2.Future<_i3.Profile>.value(_FakeProfile_1(
          this,
          Invocation.method(
            #getProfileByUidReload,
            [],
            {#uid: uid},
          ),
        )),
      ) as _i2.Future<_i3.Profile>);
  @override
  _i2.Future<void> saveProfile(_i3.Profile? profile) => (super.noSuchMethod(
        Invocation.method(
          #saveProfile,
          [profile],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);
  @override
  void rerender() => super.noSuchMethod(
        Invocation.method(
          #rerender,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
