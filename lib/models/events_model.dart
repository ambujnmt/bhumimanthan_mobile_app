import 'package:bhumi_manthan/utils/app_imports.dart';

class EventsModel {
  final int? id;
  final String? title;
  final String? slug;
  final String? eventType;
  final String? organizerName;
  final String? brandName;
  final String? description;
  final String? eventDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? location;
  final String? address;
  final String? city;
  final String? state;
  final String? mapUrl;
  final String? latitude;
  final String? longitude;
  final String? expectedFootfall;
  final String? buildersAttending;
  final List<String> highlights;
  final String? highlightOther;
  final String? image;
  final String? brochure;
  final bool? isActive;
  final String? createdAt;
  final String updatedAt;
  final List<EventImage> images;
  final String? eventTypeLabel;
  final String? expectedFootfallLabel;
  final List<String> highlightLabels;

  EventsModel({
    this.id,
    this.title,
    this.slug,
    this.eventType,
    this.organizerName,
    this.brandName,
    this.description,
    this.eventDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.location,
    this.address,
    this.city,
    this.state,
    this.mapUrl,
    this.latitude,
    this.longitude,
    this.expectedFootfall,
    this.buildersAttending,
    this.highlights = const [],
    this.highlightOther,
    this.image,
    this.brochure,
    this.isActive,
    this.createdAt,
    required this.updatedAt,
    this.images = const [],
    this.eventTypeLabel,
    this.expectedFootfallLabel,
    this.highlightLabels = const [],
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      eventType: json['event_type'],
      organizerName: json['organizer_name'],
      brandName: json['brand_name'],
      description: json['description'],
      eventDate: json['event_date'],
      endDate: json['end_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      location: json['location'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      mapUrl: json['map_url'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      expectedFootfall: json['expected_footfall'],
      buildersAttending: json['builders_attending'],
      highlights: List<String>.from(json['highlights'] ?? []),
      highlightOther: json['highlight_other'],
      image: json['image'],
      brochure: json['brochure'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      images: JsonParser.parseList(
        json['images'],
        (event) => EventImage.fromJson(event),
      ),
      eventTypeLabel: json['event_type_label'],
      expectedFootfallLabel: json['expected_footfall_label'],
      highlightLabels: List<String>.from(json['highlight_labels'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'event_type': eventType,
      'organizer_name': organizerName,
      'brand_name': brandName,
      'description': description,
      'event_date': eventDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'location': location,
      'address': address,
      'city': city,
      'state': state,
      'map_url': mapUrl,
      'latitude': latitude,
      'longitude': longitude,
      'expected_footfall': expectedFootfall,
      'builders_attending': buildersAttending,
      'highlights': highlights,
      'highlight_other': highlightOther,
      'image': image,
      'brochure': brochure,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'images': images.map((e) => e.toJson()).toList(),
      'event_type_label': eventTypeLabel,
      'expected_footfall_label': expectedFootfallLabel,
      'highlight_labels': highlightLabels,
    };
  }

  EventsModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? eventType,
    String? organizerName,
    String? brandName,
    String? description,
    String? eventDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? location,
    String? address,
    String? city,
    String? state,
    String? mapUrl,
    String? latitude,
    String? longitude,
    String? expectedFootfall,
    String? buildersAttending,
    List<String>? highlights,
    String? highlightOther,
    String? image,
    String? brochure,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    List<EventImage>? images,
    String? eventTypeLabel,
    String? expectedFootfallLabel,
    List<String>? highlightLabels,
  }) {
    return EventsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      eventType: eventType ?? this.eventType,
      organizerName: organizerName ?? this.organizerName,
      brandName: brandName ?? this.brandName,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      mapUrl: mapUrl ?? this.mapUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      expectedFootfall: expectedFootfall ?? this.expectedFootfall,
      buildersAttending: buildersAttending ?? this.buildersAttending,
      highlights: highlights ?? this.highlights,
      highlightOther: highlightOther ?? this.highlightOther,
      image: image ?? this.image,
      brochure: brochure ?? this.brochure,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      eventTypeLabel: eventTypeLabel ?? this.eventTypeLabel,
      expectedFootfallLabel:
          expectedFootfallLabel ?? this.expectedFootfallLabel,
      highlightLabels: highlightLabels ?? this.highlightLabels,
    );
  }
}

class EventImage {
  final String? url;

  EventImage({this.url});

  factory EventImage.fromJson(Map<String, dynamic> json) {
    return EventImage(url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }

  EventImage copyWith({String? url}) {
    return EventImage(url: url ?? this.url);
  }
}
