// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIUser _$APIUserFromJson(Map<String, dynamic> json) => APIUser(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      email: json['email'] as String?,
      unconfirmedEmail: json['unconfirmed_email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      about: json['about'] as String? ?? '',
    );

Map<String, dynamic> _$APIUserToJson(APIUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'email': instance.email,
      'unconfirmed_email': instance.unconfirmedEmail,
      'about': instance.about,
      'avatar_url': instance.avatarUrl,
    };

APIUserList _$APIUserListFromJson(Map<String, dynamic> json) => APIUserList(
      links:
          APIPaginationLinks.fromJson(json['_links'] as Map<String, dynamic>),
      meta:
          APIPaginationMetaData.fromJson(json['_meta'] as Map<String, dynamic>),
      users: (json['data'] as List<dynamic>)
          .map((e) => APIUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$APIUserListToJson(APIUserList instance) =>
    <String, dynamic>{
      '_links': instance.links,
      '_meta': instance.meta,
      'data': instance.users,
    };
