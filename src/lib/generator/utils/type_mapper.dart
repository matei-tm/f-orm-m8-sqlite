class TypeMapper {
  static String getTypeDefinition(String modelTypeName) {
    switch (modelTypeName) {
      case "int":
        return "INTEGER";
        break;
      case "float":
        return "REAL";
        break;
      case "String":
        return "TEXT";
        break;
      default:
        return "TEXT";
    }
  }
}
