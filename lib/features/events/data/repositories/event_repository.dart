import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../utils/api_urls.dart';
import '../models/event_models.dart';

class EventRepository extends BaseRepository {
  EventRepository(super.dio);

  Future<EventListResponse> getEvents({
    String? keyword,
    int page = 1,
  }) async {
    final Map<String, dynamic> query = {'page': page};
    if (keyword != null && keyword.trim().isNotEmpty) {
      query['search'] = keyword.trim();
      query['keyword'] = keyword.trim();
      query['keywords'] = keyword.trim();
    }

    final response = await getRequest(
      getEventListApi,
      queryParameters: query,
    );
    return EventListResponse.fromJson(response.data);
  }

  Future<EventDetailsResponse> getEventDetails(int eventId) async {
    final response = await getRequest('$getEventDetailsApi/$eventId');
    return EventDetailsResponse.fromJson(response.data);
  }

  Future<BookEventResponse> bookEvent(Map<String, dynamic> params) async {
    final formData = FormData.fromMap(params);
    final response = await postMultipartRequest(bookEventApi, formData);
    return BookEventResponse.fromJson(response.data);
  }

  Future<RegisteredEventsResponse> getRegisteredEvents({
    int page = 1,
  }) async {
    final response = await getRequest(
      getRegisteredEventsApi,
      queryParameters: {'page': page},
    );
    return RegisteredEventsResponse.fromJson(response.data);
  }
}

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(ref.watch(dioProvider));
});
