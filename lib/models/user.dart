import 'package:intl/intl.dart';
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

  @JsonKey(name: 'unconfirmed_email')
  String? unconfirmedEmail;

  String about;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  APIUser({
    required this.id,
    required this.name,
    required this.createdAt,
    this.email,
    this.unconfirmedEmail,
    this.avatarUrl,
    this.about = '',
  });

  factory APIUser.fromJson(Map<String, dynamic> json) =>
      _$APIUserFromJson(json);

  Map<String, dynamic> toJson() => _$APIUserToJson(this);

  String get joinedAt {
    DateTime localCreated = createdAt.toLocal();
    final formatted =
        '${DateFormat.yMMMd().format(localCreated)} - ${DateFormat.Hm().format(localCreated)}';
    return formatted;
  }
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
