import 'package:json_annotation/json_annotation.dart';
import 'pagination.dart';

part 'user.g.dart';

@JsonSerializable()
class APIUser {
  int id;
  String name;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  String? email;

  String about;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  APIUser({
    required this.id,
    required this.name,
    required this.createdAt,
    this.email,
    this.avatarUrl,
    this.about = '',
  });

  factory APIUser.fromJson(Map<String, dynamic> json) =>
      _$APIUserFromJson(json);

  Map<String, dynamic> toJson() => _$APIUserToJson(this);
}

@JsonSerializable()
class APIUserList {
  @JsonKey(name: '_links')
  APIPaginationLinks links;

  @JsonKey(name: '_meta')
  APIPaginationMetaData meta;

  @JsonKey(name: 'data')
  List<APIUser> users;

  APIUserList({
    required this.links,
    required this.meta,
    required this.users,
  });

  factory APIUserList.fromJson(Map<String, dynamic> json) =>
      _$APIUserListFromJson(json);

  Map<String, dynamic> toJson() => _$APIUserListToJson(this);
}
