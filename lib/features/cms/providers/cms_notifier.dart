import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/cms_models.dart';
import '../data/repositories/cms_repository.dart';

part 'cms_notifier.g.dart';

@riverpod
class CMSNotifier extends _$CMSNotifier {
  @override
  FutureOr<CmsData?> build(String pageName) async {
    return await ref.read(cmsRepositoryProvider).getCMSPage(pageName);
  }
}
