class EntityAttribute {
  final String modelTypeName;
  final String modelName;

  final String attributeName;

  final int metadataLevel;

  EntityAttribute(this.modelTypeName, this.modelName, this.attributeName,
      {this.metadataLevel});
}
