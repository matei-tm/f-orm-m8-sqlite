import 'package:flutter_orm_m8/flutter_orm_m8.dart';

bool isSoftDeletable(int value) {
  return value & TableMetadata.SoftDeletable == TableMetadata.SoftDeletable;
}

bool isCreateTrackable(int value) {
  return value & TableMetadata.TrackCreate == TableMetadata.TrackCreate;
}

bool isUpdateTrackable(int value) {
  return value & TableMetadata.TrackUpdate == TableMetadata.TrackUpdate;
}
