// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:iot/ui/views/kelasDashboard/kelasDashboard_view.dart' as _i4;
import 'package:iot/ui/views/dosen_login/dosen_login_view.dart' as _i8;
import 'package:iot/ui/views/dosen_register/dosen_register_view.dart' as _i7;
import 'package:iot/ui/views/home/home_view.dart' as _i2;
import 'package:iot/ui/views/kelas/kelas_view.dart' as _i9;
import 'package:iot/ui/views/mahasiswa_otp/mahasiswa_otp_view.dart' as _i6;
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.dart'
    as _i5;
import 'package:iot/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const dosenView = '/dosen-view';

  static const mahasiswaRegisterView = '/mahasiswa-register-view';

  static const mahasiswaOtpView = '/mahasiswa-otp-view';

  static const dosenRegisterView = '/dosen-register-view';

  static const dosenLoginView = '/dosen-login-view';

  static const kelasView = '/kelas-view';

  static const all = <String>{
    homeView,
    startupView,
    dosenView,
    mahasiswaRegisterView,
    mahasiswaOtpView,
    dosenRegisterView,
    dosenLoginView,
    kelasView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.dosenView,
      page: _i4.DosenView,
    ),
    _i1.RouteDef(
      Routes.mahasiswaRegisterView,
      page: _i5.MahasiswaRegisterView,
    ),
    _i1.RouteDef(
      Routes.mahasiswaOtpView,
      page: _i6.MahasiswaOtpView,
    ),
    _i1.RouteDef(
      Routes.dosenRegisterView,
      page: _i7.DosenRegisterView,
    ),
    _i1.RouteDef(
      Routes.dosenLoginView,
      page: _i8.DosenLoginView,
    ),
    _i1.RouteDef(
      Routes.kelasView,
      page: _i9.KelasView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i2.HomeView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
    _i3.StartupView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i3.StartupView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
    _i4.DosenView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i4.DosenView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.zoomIn,
      );
    },
    _i5.MahasiswaRegisterView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.MahasiswaRegisterView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideBottom,
      );
    },
    _i6.MahasiswaOtpView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i6.MahasiswaOtpView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.slideTop,
      );
    },
    _i7.DosenRegisterView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i7.DosenRegisterView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeftWithFade,
      );
    },
    _i8.DosenLoginView: (data) {
      return _i10.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i8.DosenLoginView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideRightWithFade,
      );
    },
    _i9.KelasView: (data) {
      final args = data.getArgs<KelasViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.KelasView(
            key: args.key, idKelas: args.idKelas, namaKelas: args.namaKelas),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class KelasViewArguments {
  const KelasViewArguments({
    this.key,
    required this.idKelas,
    required this.namaKelas,
  });

  final _i10.Key? key;

  final int idKelas;

  final String namaKelas;

  @override
  String toString() {
    return '{"key": "$key", "idKelas": "$idKelas", "namaKelas": "$namaKelas"}';
  }

  @override
  bool operator ==(covariant KelasViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.idKelas == idKelas &&
        other.namaKelas == namaKelas;
  }

  @override
  int get hashCode {
    return key.hashCode ^ idKelas.hashCode ^ namaKelas.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDosenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dosenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMahasiswaRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mahasiswaRegisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMahasiswaOtpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mahasiswaOtpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDosenRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dosenRegisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDosenLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dosenLoginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToKelasView({
    _i10.Key? key,
    required int idKelas,
    required String namaKelas,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.kelasView,
        arguments: KelasViewArguments(
            key: key, idKelas: idKelas, namaKelas: namaKelas),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDosenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dosenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMahasiswaRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mahasiswaRegisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMahasiswaOtpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mahasiswaOtpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDosenRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dosenRegisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDosenLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dosenLoginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithKelasView({
    _i10.Key? key,
    required int idKelas,
    required String namaKelas,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.kelasView,
        arguments: KelasViewArguments(
            key: key, idKelas: idKelas, namaKelas: namaKelas),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
