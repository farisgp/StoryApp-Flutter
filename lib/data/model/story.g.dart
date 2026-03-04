// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  photoUrl: json['photoUrl'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lat: (json['lat'] as num?)?.toDouble(),
  lon: (json['lon'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
    };

_$StoryListResponseImpl _$$StoryListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StoryListResponseImpl(
  error: json['error'] as bool,
  message: json['message'] as String,
  listStory: (json['listStory'] as List<dynamic>)
      .map((e) => Story.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$StoryListResponseImplToJson(
  _$StoryListResponseImpl instance,
) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
  'listStory': instance.listStory,
};

_$StoryDetailResponseImpl _$$StoryDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StoryDetailResponseImpl(
  error: json['error'] as bool,
  message: json['message'] as String,
  story: json['story'] == null
      ? null
      : Story.fromJson(json['story'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoryDetailResponseImplToJson(
  _$StoryDetailResponseImpl instance,
) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
  'story': instance.story,
};
