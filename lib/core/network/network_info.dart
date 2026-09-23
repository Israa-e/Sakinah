import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

/// Abstraction over connectivity so repositories can check "am I online"
/// without depending on a concrete plugin — and tests can fake it.
abstract interface class NetworkInfo {
  Future<bool> get isConnected;

  Stream<bool> get onConnectivityChanged;
}

class ConnectivityNetworkInfo implements NetworkInfo {
  ConnectivityNetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _hasConnection(result);
  }

  @override
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) {
  return ConnectivityNetworkInfo(Connectivity());
}

@Riverpod(keepAlive: true)
Stream<bool> isOnline(Ref ref) async* {
  final info = ref.watch(networkInfoProvider);
  yield await info.isConnected;
  yield* info.onConnectivityChanged;
}
