class FieldParseException implements Exception {
  dynamic inner;

  String fieldName;

  String message;

  StackTrace trace;

  String modelName;

  FieldParseException(this.fieldName, this.modelName,
      {this.inner, this.trace, this.message});

  String toString() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer
        .writeln('Exception while parsing field "$fieldName" on "$modelName"!');

    if (message != null) {
      stringBuffer.writeln("Message: $message");
    }

    if (inner != null) {
      stringBuffer.writeln(inner);
    }

    stringBuffer.writeln(trace);
    return stringBuffer.toString();
  }
}
