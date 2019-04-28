import 'package:flutter_orm_m8/flutter_orm_m8.dart';

bool isSoftDeletable(int value) {
  return value & TableMetadata.softDeletable == TableMetadata.softDeletable;
}

bool isCreateTrackable(int value) {
  return value & TableMetadata.trackCreate == TableMetadata.trackCreate;
}

bool isUpdateTrackable(int value) {
  return value & TableMetadata.trackUpdate == TableMetadata.trackUpdate;
}
