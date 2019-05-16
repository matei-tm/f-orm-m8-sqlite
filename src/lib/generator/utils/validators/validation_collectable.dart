import 'package:f_orm_m8_sqlite/generator/utils/validators/validation_issue.dart';

class ValidationCollectable {
  List<ValidationIssue> validationIssues = List<ValidationIssue>();

  bool get hasValidatorIssues =>
      validationIssues?.any((v) => v.isError) ?? false;
}
