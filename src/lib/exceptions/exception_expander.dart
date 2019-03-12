library orm_m8_generator.exceptions;

class ExceptionExpander {
  dynamic exception;

  StackTrace stack;

  ExceptionExpander(this.exception, StackTrace this.stack);

  @override
  String toString() {
    var result = new StringBuffer();
    result.writeln('/*');
    result.write(exception.toString());
    result.writeln();
    result.write(stack);
    result.writeln('*/');

    return result.toString();
  }
}