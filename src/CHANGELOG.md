# Changelog

## [Unreleased]

## [0.7.0+2] - 2019-05-23

### Fixed

* Dartlang publish warnings

### Added

* More tests on `example` project in order to obtain a test coverage greater than 95%


## [0.7.0+1] - 2019-05-18

### Changed

* Update to Example project. Change the theme color, updating docs animated gif's

## [0.7.0] - 2019-05-17

### Fixed

* Issue #97. The generator must validate models with multiple PKs. If the model is incorectly annotated with PKs the generator emit a wrong mixin.

### Added

* Validation for Primary Key combination
* Implementation for Indexed annotation from MetadataLevel or from Composites in any combination

### Changed

* The softDelete annotation generates a combination of unique key with other uniqe annotated fields

## [0.6.3] - 2019-05-16

### Added

* Implementation for mapping Duration fields. Currently handled in milliseconds and saved to database as INTEGER
* Implementation for mapping BigInt fields. Saved to database as TEXT to keep precision
* Implementation for DbOpenEntity scaffolding

### Changed

* If the Model class does not implement allowed interfaces (DbEntity or DbOpenEntity) the parser will handle as validation error (not Exception)

## [0.6.2+1] - 2019-05-15

### Changed

* Refactoring entity attribute classes to closer OOP

### Fixed

* Analysis warnings

## [0.6.2] - 2019-05-15

### Added

* Test for Account entity raw output generation
* Test the multiple DataColumn annotations on the same field!
* Validation on post extraction for models with fields that do not pass validation at all
* A unified header to all generated files
* A DatabaseAdapter to handle the database singleton in different init stages (dev/ci/prod)
* Tests for CRUD operations on DatabaseProvider

### Changed

* Throw Exception switched to Validation design pattern
* If the model is not valid, then the generated file will contain the validation issues in a comment block
* In `*DatabaseProvider` mixins, the `the*TableHandler` fields to public
* Renamed DatabaseHelper as DatabaseProvider

## [0.6.1] - 2019-05-06

### Added

* Default name generation when DataTable name is missing. The name is the model name prefixed with "M8"
* Tests for generator exceptions handling

## [0.6.0+2] - 2019-05-05

### Changed

* README.md reviewed. Typo fixes. Updating dependencies table. Adding codecov badge

### Added

* Widget tests on example project

## [0.6.0+1] - 2019-05-03

### Changed

* README.md reviewed

## [0.6.0] - 2019-05-03

### Changed

* The github project was renamed from **flutter-sqlite-m8-generator** to **f-orm-m8-sqlite**
* It package was renamed from flutter_sqlite_m8_generator to f_orm_m8_sqlite
* The dart package was published as [f_orm_m8_sqlite](http://pub.dartlang.org/packages/f_orm_m8_sqlite)
* See [f_orm_m8_sqlite](http://pub.dartlang.org/packages/f_orm_m8_sqlite) for new updated framework

## [0.5.0] - 2019-05-03

### Changed

* Switched from `flutter_orm_m8` to the de facto successor `f_orm_m8` 
* Aligned generators with `f_orm_m8` v0.8.0
* Softdeletable meta determines the generation of a DateTime dateDelete field
* The tests were refactored with caliber files

### Added

* A custom header with timestamp on the generated files
* Test coverage reporting to the CI pipeline
* The example project integration tests were wired the CI pipeline

## [0.4.0] - 2019-05-01

### Changed

* Aligned generators with `flutter-orm-m8` v0.7.1
* Example project: HealthEntry model received a composite unique constraint

### Added

* Generator support for CompositeConstraint.unique
* Generator support for CompositeConstraint.primaryKey
* Tests for CompositeConstraint generation
* Flutter Driver tests on example project for all UI use cases

## [0.3.0+1] - 2019-04-25

### Fixed

* Documentation

## [0.3.0] - 2019-04-23

### Changed

* Aligned generators with `flutter-orm-m8` v0.6.0
* Default constructor on proxy entities has named parameters
* All db helpers `get*all` methods return a list of proxy entities 
* The generator handles DbAccountEntity isCurrent field 
* The pluralize for model switched from "${modelName}s" to "${modelName}Proxies" 
* Example project was extended with implementations for:
  * DbEntity
  * DbAccountEntity
  * DbAccountRelatedEntity

### Fixed

* Wrong attribute emission on accountId, for account related entities

## [0.2.3+1] - 2019-04-15

### Fixed

* Fix typo in save and update methods for trackable entities

### Changed

* The showcase in the example project. All models are closer to a real life application

## [0.2.3] - 2019-04-14

### Fixed

* The generated entity database helper does not contain the meta columns
* Fixed test in the example project

### Changed

* The showcase in the example project

## [0.2.2] - 2019-04-12

### Added

* Bidirectional mapping for Model DateTime to Database Integer
* Complete implementation for trackable, update and create, fields
* Boolean extremeDevelopmentMode field to DatabaseProvider to control regeneration of database in dev mode

## [0.2.1] - 2019-04-09

### Changed

* Emitting only public fields

### Fixed

* Missing metadataLevel on DataColumn annotated model fields, generates wrong emition

## [0.2.0] - 2019-04-07

### Added

* A full implementation in the example project for a dbEntity CRUD

### Fixed

* Returning all rows on softDeletable entities

## [0.1.1] - 2019-04-06

### Changed

* FileStamp for database file

### Fixed

* Fixing format and analyzer issues recommended after publish
* Fixing readme formatting issues

## [0.1.0] - 2019-04-05

### Added

* Chaining database adapter builder with annotation helpers builder
* Tests
* A proxy default constructor with mandatory parameters
* A database adapter

### Changed

* Generated files extension

## [0.0.7] - 2019-04-03

### Added

* Working generator, ready to be published
* Soft delete annotation implemented 
* Track create annotation implemented
* Track update annotation implemented

## [0.0.6] - 2019-04-02

### Added

* Proxy writer

## [0.0.5] - 2019-04-01

### Added

* A simple fields enumeration with model type
* A basic type mapper for Sqlite types
* Expanding metadata in column definition
* Extracting the primary key name

## [0.0.4] - 2019-03-22

### Added

* An entity factory for account related, account and independent entities

### Changed

* The build output is routed to cache

## [0.0.3] - 2019-03-14

### Added

* A weak try to expand some information
* Tests

## [0.0.2] - 2019-03-14

### Fixed

* Fixing analyzer issues

## [0.0.1] - 2019-03-03

### Added

* Basic generator