// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

class SearchResponse {
  final String? status;
  final dynamic message;
  final Data data;

  SearchResponse({
    this.status,
    this.message,
    required this.data,
  });

  factory SearchResponse.fromMap(Map<String, dynamic> map) {
    return SearchResponse(
        status: map['status'] != null ? map['status'] as String : null,
        message: map['message'] as dynamic,
        data: Data.formJson(map['data']));
  }

  factory SearchResponse.fromJson(String source) =>
      SearchResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SearchResponse(status: $status, message: $message)';
}

class Data {
  final int total;
  final Results result;
  Data({required this.total, required this.result});

  factory Data.formJson(Map<String, dynamic> source) {
    return Data(
        total: source['total'] as int,
        result: Results.fromJson(source['results']));
  }
}

class Results {
  List<Result> results;
  Results({required this.results});

  factory Results.fromJson(List<dynamic> data) {
    return Results(results: data.map((item) => Result.fromJson(item)).toList());
  }
}

class Result {
  String id;
  String name;
  String year;
  List<ImageModel> images;
  List<DownloadUrl> downloadUrl;

  Result({required this.id, required this.name, required this.year,required this.images, required this .downloadUrl});

  factory Result.fromJson(Map<String, dynamic> jsonData) {
    return Result(
      id: jsonData['id'] as String,
      name: jsonData['name'] as String,
      year: jsonData['year'] as String,
      images: (jsonData['image'] as List)
          .map((e) => ImageModel.fromJson(e))
          .toList(),
      downloadUrl: (jsonData['downloadUrl'] as List)
          .map((e) => DownloadUrl.fromJson(e))
          .toList(),
    );
  }
}

class ImageModel {
  String link;
  ImageModel({required this.link});

  factory ImageModel.fromJson(Map<String, dynamic> source) {
    return ImageModel(link: source['link']);
  }
}

class DownloadUrl {
  String link;
  DownloadUrl({required this.link});

  factory DownloadUrl.fromJson(Map<String, dynamic> source) {
    return DownloadUrl(link: source['link']);
  }
}
