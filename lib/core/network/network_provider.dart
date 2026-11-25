import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../services/network_manager_service.dart';

part 'network_provider.g.dart';

@riverpod
class NetworkState extends _$NetworkState {
  late NetworkManagerService _networkManager;

  @override
  Stream<bool> build() async* {
    _networkManager = NetworkManagerService();
    await _networkManager.init();
    
    ref.onDispose(() {
      _networkManager.dispose();
    });

    yield _networkManager.isConnected;
    yield* _networkManager.onStatusChange;
  }
}
