import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class ValidatorWriter {
  List<ValidationIssue> validationIssues;

  ValidatorWriter(List<ValidationIssue> this.validationIssues);

  String expandValidationIssues() {
    StringBuffer result = StringBuffer();
    validationIssues.forEach((f) => result.writeln("${f.toString()}"));

    return result.toString();
  }

  @override
  String toString() {
    String header =
        "Not all the models have passed the validation process. Review the following issues, fix them and rerun the builder:";
    return '''/*
$header

${expandValidationIssues()}*/''';
  }
}
