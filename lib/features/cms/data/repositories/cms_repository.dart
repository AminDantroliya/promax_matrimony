import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../models/cms_models.dart';

import '../../../../utils/api_urls.dart';

part 'cms_repository.g.dart';

class CmsRepository extends BaseRepository {
  CmsRepository(super.dio);

  Future<CmsData?> getCMSPage(String pageName) async {
    final response = await postRequest(getCmsDataApi, {'page_slug': pageName});
    if (response.status == 'success' || response.status == '1') {
      return CmsData.fromJson(response.object);
    }
    return null;
  }
}

@riverpod
CmsRepository cmsRepository(Ref ref) {
  return CmsRepository(ref.watch(dioProvider));
}
