import 'package:intl/intl.dart';

class EventListResponse {
  final bool status;
  final String message;
  final EventListData? data;

  EventListResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory EventListResponse.fromJson(Map<String, dynamic> json) {
    return EventListResponse(
      status: json['status'] == true || json['status']?.toString() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] != null ? EventListData.fromJson(json['data']) : null,
    );
  }
}

class EventListData {
  final int currentPage;
  final List<EventItem> data;
  final int? lastPage;
  final int? total;

  EventListData({
    required this.currentPage,
    required this.data,
    this.lastPage,
    this.total,
  });

  factory EventListData.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    return EventListData(
      currentPage: json['current_page'] is int
          ? json['current_page']
          : int.tryParse(json['current_page']?.toString() ?? '1') ?? 1,
      lastPage: json['last_page'] is int
          ? json['last_page']
          : int.tryParse(json['last_page']?.toString() ?? '1'),
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total']?.toString() ?? '0'),
      data: list is List
          ? list
              .map((e) => EventItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

class EventDetailsResponse {
  final bool status;
  final String message;
  final EventItem? data;

  EventDetailsResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory EventDetailsResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailsResponse(
      status: json['status'] == true || json['status']?.toString() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] != null ? EventItem.fromJson(json['data']) : null,
    );
  }
}

class EventItem {
  final int id;
  final String status;
  final String title;
  final String? contactEmail;
  final double ticketPrice;
  final int totalTickets;
  final int soldTickets;
  final int? ticketsLeft;
  final String? contactNumber;
  final String? description;
  final String? eventDate;
  final String? eventTime;
  final String? venue;
  final String? currency;
  final String? image1Url;
  final String? image2Url;
  final String? image3Url;
  final String? image4Url;
  final String? mapAddress;
  final String? eventFacebookLink;
  final String? eventTwitterLink;
  final String? eventYoutubeLink;
  final String? eventInstagramLink;
  final String? eventPinterestLink;
  final String? createdAt;

  EventItem({
    required this.id,
    required this.status,
    required this.title,
    this.contactEmail,
    required this.ticketPrice,
    required this.totalTickets,
    required this.soldTickets,
    this.ticketsLeft,
    this.contactNumber,
    this.description,
    this.eventDate,
    this.eventTime,
    this.venue,
    this.currency,
    this.image1Url,
    this.image2Url,
    this.image3Url,
    this.image4Url,
    this.mapAddress,
    this.eventFacebookLink,
    this.eventTwitterLink,
    this.eventYoutubeLink,
    this.eventInstagramLink,
    this.eventPinterestLink,
    this.createdAt,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(val.toString()) ?? 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      return int.tryParse(val.toString()) ?? 0;
    }

    return EventItem(
      id: parseInt(json['id']),
      status: json['status']?.toString() ?? 'APPROVED',
      title: json['title']?.toString() ?? '',
      contactEmail: json['contact_email']?.toString(),
      ticketPrice: parsePrice(json['ticket_price']),
      totalTickets: parseInt(json['total_tickets']),
      soldTickets: parseInt(json['sold_tickets']),
      ticketsLeft: json['tickets_left'] != null
          ? parseInt(json['tickets_left'])
          : null,
      contactNumber: json['contact_number']?.toString(),
      description: json['description']?.toString(),
      eventDate: json['event_date']?.toString(),
      eventTime: json['event_time']?.toString(),
      venue: json['venue']?.toString(),
      currency: json['currency']?.toString() ?? 'INR',
      image1Url: json['image1_url']?.toString() ?? json['image']?.toString(),
      image2Url: json['image2_url']?.toString() ?? json['image_2']?.toString(),
      image3Url: json['image3_url']?.toString() ?? json['image_3']?.toString(),
      image4Url: json['image4_url']?.toString() ?? json['image_4']?.toString(),
      mapAddress: json['map_address']?.toString(),
      eventFacebookLink: json['event_facebook_link']?.toString(),
      eventTwitterLink: json['event_twitter_link']?.toString(),
      eventYoutubeLink: json['event_youtube_link']?.toString(),
      eventInstagramLink: json['event_instagram_link']?.toString(),
      eventPinterestLink: json['event_pinterest_link']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'title': title,
    'contact_email': contactEmail,
    'ticket_price': ticketPrice,
    'total_tickets': totalTickets,
    'sold_tickets': soldTickets,
    'tickets_left': ticketsLeft,
    'contact_number': contactNumber,
    'description': description,
    'event_date': eventDate,
    'event_time': eventTime,
    'venue': venue,
    'currency': currency,
    'image1_url': image1Url,
    'image2_url': image2Url,
    'image3_url': image3Url,
    'image4_url': image4Url,
    'map_address': mapAddress,
    'event_facebook_link': eventFacebookLink,
    'event_twitter_link': eventTwitterLink,
    'event_youtube_link': eventYoutubeLink,
    'event_instagram_link': eventInstagramLink,
    'event_pinterest_link': eventPinterestLink,
  };

  List<String> get allImages {
    final list = <String>[];
    if (image1Url != null && image1Url!.trim().isNotEmpty) list.add(image1Url!.trim());
    if (image2Url != null && image2Url!.trim().isNotEmpty) list.add(image2Url!.trim());
    if (image3Url != null && image3Url!.trim().isNotEmpty) list.add(image3Url!.trim());
    if (image4Url != null && image4Url!.trim().isNotEmpty) list.add(image4Url!.trim());
    return list;
  }

  String get bannerImage {
    if (allImages.isNotEmpty) return allImages.first;
    return '';
  }

  String get formattedDate {
    if (eventDate == null || eventDate!.isEmpty) return '';
    try {
      final parsed = DateTime.tryParse(eventDate!);
      if (parsed != null) {
        return DateFormat('dd MMMM, yyyy').format(parsed);
      }
    } catch (_) {}
    return eventDate!;
  }

  String get formattedTime {
    if (eventTime == null || eventTime!.isEmpty) return '';
    try {
      final clean = eventTime!.trim();
      // Handle "HH:mm" like "17:45"
      if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(clean)) {
        final parts = clean.split(':');
        final hour = int.parse(parts[0]);
        final min = int.parse(parts[1]);
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, hour, min);
        return DateFormat('hh:mm a').format(dt);
      }
      return clean;
    } catch (_) {}
    return eventTime!;
  }

  String get formattedDateTime {
    final date = formattedDate;
    final time = formattedTime;
    if (date.isNotEmpty && time.isNotEmpty) {
      return '$date | $time';
    }
    return date.isNotEmpty ? date : time;
  }

  String get formattedPrice {
    if (ticketPrice <= 0) return 'Free';
    final curr = currency?.trim().isNotEmpty == true ? currency!.trim() : 'INR';
    final isWhole = ticketPrice == ticketPrice.roundToDouble();
    final priceStr = isWhole
        ? ticketPrice.toInt().toString()
        : ticketPrice.toStringAsFixed(2);
    return '$curr $priceStr';
  }

  String get plainDescription {
    if (description == null) return '';
    return description!
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  int get remainingTickets {
    if (ticketsLeft != null) return ticketsLeft!;
    if (totalTickets > 0) {
      final left = totalTickets - soldTickets;
      return left > 0 ? left : 0;
    }
    return 100;
  }

  bool get isSoldOut => totalTickets > 0 && remainingTickets <= 0;
}

class BookEventResponse {
  final bool status;
  final String message;
  final dynamic data;

  BookEventResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory BookEventResponse.fromJson(Map<String, dynamic> json) {
    return BookEventResponse(
      status: json['status'] == true || json['status']?.toString() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'],
    );
  }
}

class RegisteredEventsResponse {
  final bool status;
  final String message;
  final RegisteredEventsData? data;

  RegisteredEventsResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory RegisteredEventsResponse.fromJson(Map<String, dynamic> json) {
    return RegisteredEventsResponse(
      status: json['status'] == true || json['status']?.toString() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? RegisteredEventsData.fromJson(json['data'])
          : null,
    );
  }
}

class RegisteredEventsData {
  final int currentPage;
  final List<RegisteredEventItem> data;

  RegisteredEventsData({
    required this.currentPage,
    required this.data,
  });

  factory RegisteredEventsData.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    return RegisteredEventsData(
      currentPage: json['current_page'] is int
          ? json['current_page']
          : int.tryParse(json['current_page']?.toString() ?? '1') ?? 1,
      data: list is List
          ? list
              .map((e) =>
                  RegisteredEventItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

class RegisteredEventItem {
  final int id;
  final int? memberId;
  final int? eventId;
  final String? name;
  final String? mobile;
  final String? email;
  final String? hearAboutUs;
  final String? currency;
  final double ticketPrice;
  final int ticketsQty;
  final String? paymentMode;
  final String? transactionId;
  final String? paymentStatus;
  final String? createdAt;
  final EventItem? event;

  RegisteredEventItem({
    required this.id,
    this.memberId,
    this.eventId,
    this.name,
    this.mobile,
    this.email,
    this.hearAboutUs,
    this.currency,
    required this.ticketPrice,
    required this.ticketsQty,
    this.paymentMode,
    this.transactionId,
    this.paymentStatus,
    this.createdAt,
    this.event,
  });

  factory RegisteredEventItem.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(val.toString()) ?? 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      return int.tryParse(val.toString()) ?? 0;
    }

    return RegisteredEventItem(
      id: parseInt(json['id']),
      memberId: json['member_id'] != null ? parseInt(json['member_id']) : null,
      eventId: json['event_id'] != null ? parseInt(json['event_id']) : null,
      name: json['name']?.toString(),
      mobile: json['mobile']?.toString(),
      email: json['email']?.toString(),
      hearAboutUs: json['hear_about_us']?.toString(),
      currency: json['currency']?.toString() ?? 'INR',
      ticketPrice: parsePrice(json['ticket_price']),
      ticketsQty: parseInt(json['tickets_qty'] ?? json['total_tickets'] ?? 1),
      paymentMode: json['payment_mode']?.toString(),
      transactionId: json['transaction_id']?.toString(),
      paymentStatus: json['payment_status']?.toString() ?? 'confirmed',
      createdAt: json['created_at']?.toString(),
      event: json['event'] is Map<String, dynamic>
          ? EventItem.fromJson(json['event'])
          : null,
    );
  }

  double get grandTotal {
    final qty = ticketsQty > 0 ? ticketsQty : 1;
    return ticketPrice * qty;
  }

  String get formattedTotal {
    final curr = currency ?? 'INR';
    final isWhole = grandTotal == grandTotal.roundToDouble();
    return '$curr ${isWhole ? grandTotal.toInt() : grandTotal.toStringAsFixed(2)}';
  }
}
