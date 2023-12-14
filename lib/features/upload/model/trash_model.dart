import 'dart:convert';

class TrashModel {
  final String? trashId;
  final String? trashName;
  final String? trashDescription;
  final String? trashImageUrl;
  final String? typeTrash;
  final String? accuracy;
  final String? locationTrash;
  final String? dateTrash;
  final String? timeTrash;
  final String? statusTrash;
  final String? docId;

  TrashModel({
    this.trashId,
    this.trashName,
    this.trashDescription,
    this.trashImageUrl,
    this.typeTrash,
    this.accuracy,
    this.locationTrash,
    this.dateTrash,
    this.timeTrash,
    this.statusTrash,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (trashId != null) {
      result.addAll({'trashId': trashId});
    }
    if (trashName != null) {
      result.addAll({'trashName': trashName});
    }
    if (trashDescription != null) {
      result.addAll({'trashDescription': trashDescription});
    }
    if (trashImageUrl != null) {
      result.addAll({'trashImageUrl': trashImageUrl});
    }
    if (typeTrash != null) {
      result.addAll({'typeTrash': typeTrash});
    }
    if (accuracy != null) {
      result.addAll({'accuracy': accuracy});
    }
    if (locationTrash != null) {
      result.addAll({'locationTrash': locationTrash});
    }
    if (dateTrash != null) {
      result.addAll({'dateTrash': dateTrash});
    }
    if (timeTrash != null) {
      result.addAll({'timeTrash': timeTrash});
    }
    if (statusTrash != null) {
      result.addAll({'statusTrash': statusTrash});
    }
    if (docId != null) {
      result.addAll({'docId': docId});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
