import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/support_repository.dart';

part 'support_notifier.g.dart';

@riverpod
Future<Map<String, dynamic>> helpSupport(Ref ref) async {
  final repository = ref.watch(supportRepositoryProvider);
  return await repository.getSiteSettings();
}
