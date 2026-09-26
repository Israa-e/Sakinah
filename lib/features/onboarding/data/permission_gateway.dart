import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_gateway.g.dart';

enum PermissionOutcome { granted, denied, permanentlyDenied }

extension PermissionOutcomeX on PermissionOutcome {
  bool get isGranted => this == PermissionOutcome.granted;
}

/// Thin seam over `permission_handler` so onboarding and profile can request
/// OS permissions without a platform channel in widget tests.
abstract interface class PermissionGateway {
  Future<PermissionOutcome> requestLocation();
  Future<PermissionOutcome> requestNotifications();
  Future<PermissionOutcome> notificationStatus();
  Future<bool> openSystemSettings();
}

class PermissionHandlerGateway implements PermissionGateway {
  const PermissionHandlerGateway();

  static PermissionOutcome _map(PermissionStatus status) {
    if (status.isGranted || status.isLimited || status.isProvisional) {
      return PermissionOutcome.granted;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return PermissionOutcome.permanentlyDenied;
    }
    return PermissionOutcome.denied;
  }

  @override
  Future<PermissionOutcome> requestLocation() async =>
      _map(await Permission.locationWhenInUse.request());

  @override
  Future<PermissionOutcome> requestNotifications() async =>
      _map(await Permission.notification.request());

  @override
  Future<PermissionOutcome> notificationStatus() async =>
      _map(await Permission.notification.status);

  @override
  Future<bool> openSystemSettings() => openAppSettings();
}

@Riverpod(keepAlive: true)
PermissionGateway permissionGateway(Ref ref) => const PermissionHandlerGateway();
