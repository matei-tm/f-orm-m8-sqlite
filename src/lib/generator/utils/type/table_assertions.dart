import 'package:f_orm_m8/f_orm_m8.dart';

bool isSoftDeletable(int value) {
  return value & TableMetadata.softDeletable == TableMetadata.softDeletable;
}

bool isCreateTrackable(int value) {
  return value & TableMetadata.trackCreate == TableMetadata.trackCreate;
}

bool isUpdateTrackable(int value) {
  return value & TableMetadata.trackUpdate == TableMetadata.trackUpdate;
}
