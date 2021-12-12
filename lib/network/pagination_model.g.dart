// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPaginationLinks _$APIPaginationLinksFromJson(Map<String, dynamic> json) =>
    APIPaginationLinks(
      firstPage: json['first_page'] as String,
      prevPage: json['prev_page'] as String?,
      currentPage: json['current_page'] as String,
      nextPage: json['next_page'] as String?,
      lastPage: json['last_page'] as String,
    );

Map<String, dynamic> _$APIPaginationLinksToJson(APIPaginationLinks instance) =>
    <String, dynamic>{
      'first_page': instance.firstPage,
      'prev_page': instance.prevPage,
      'current_page': instance.currentPage,
      'next_page': instance.nextPage,
      'last_page': instance.lastPage,
    };

APIPaginationMetaData _$APIPaginationMetaDataFromJson(
        Map<String, dynamic> json) =>
    APIPaginationMetaData(
      perPage: json['per_page'] as int,
      count: json['count'] as int,
      totalCount: json['total_count'] as int,
    );

Map<String, dynamic> _$APIPaginationMetaDataToJson(
        APIPaginationMetaData instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'count': instance.count,
      'total_count': instance.totalCount,
    };
