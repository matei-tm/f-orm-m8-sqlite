# Changelog

## [Unreleased]

## [0.4.0] - 2019-04-29

### Changed

* Aligned generators with `flutter-orm-m8` v0.7.0

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
* Boolean extremeDevelopmentMode field to DatabaseHelper to control regeneration of database in dev mode

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