class TypeMapper {
  static String getTypeDefinition(String modelTypeName) {
    switch (modelTypeName) {
      case "int":
        return "INTEGER";
        break;
      case "num":
        return "NUMERIC";
        break;
      case "double":
        return "REAL";
        break;
      case "String":
        return "TEXT";
        break;
      case "DateTime":
        return "INTEGER";
        break;
      default:
        return "TEXT";
    }
  }
}
