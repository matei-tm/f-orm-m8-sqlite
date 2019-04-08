# Changelog

## [Unreleased]

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