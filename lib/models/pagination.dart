import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class APIPaginationLinks {
  @JsonKey(name: 'first_page')
  String firstPage;

  @JsonKey(name: 'prev_page')
  String? prevPage;

  @JsonKey(name: 'current_page')
  String currentPage;

  @JsonKey(name: 'next_page')
  String? nextPage;

  @JsonKey(name: 'last_page')
  String lastPage;

  APIPaginationLinks({
    required this.firstPage,
    this.prevPage,
    required this.currentPage,
    this.nextPage,
    required this.lastPage,
  });

  factory APIPaginationLinks.fromJson(Map<String, dynamic> json) =>
      _$APIPaginationLinksFromJson(json);

  Map<String, dynamic> toJson() => _$APIPaginationLinksToJson(this);
}

@JsonSerializable()
class APIPaginationMetaData {
  @JsonKey(name: 'per_page')
  int perPage;

  int count;

  @JsonKey(name: 'total_count')
  int totalCount;

  APIPaginationMetaData({
    required this.perPage,
    required this.count,
    required this.totalCount,
  });

  factory APIPaginationMetaData.fromJson(Map<String, dynamic> json) =>
      _$APIPaginationMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$APIPaginationMetaDataToJson(this);
}
