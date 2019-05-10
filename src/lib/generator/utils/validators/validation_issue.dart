class ValidationIssue {
  final bool isError;
  final String message;

  ValidationIssue({this.isError, this.message});

  @override
  String toString() {
    String head = isError ? "Error" : "Info";
    return "$head: $message";
  }
}
