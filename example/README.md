# Full example for `flutter-sqlite-m8-generator` 

- [Full example for `flutter-sqlite-m8-generator`](#full-example-for-flutter-sqlite-m8-generator)
  - [Disclaimer](#disclaimer)
  - [Purpose](#purpose)
  - [Dependencies](#dependencies)
  - [CRUD showcase](#crud-showcase)
    - [Interface: DbAccountEntity](#interface-dbaccountentity)
    - [Interface: DbAccountRelatedEntity](#interface-dbaccountrelatedentity)
    - [Interface: DbEntity](#interface-dbentity)
    - [Interface: DbEntity](#interface-dbentity-1)

This is a sample showcase for the facets of `flutter-sqlite-m8-generator`

## Disclaimer

This is a demo application. Do not use for production purposes.

## Purpose

The only purpose of this example is to be a showcase of `flutter-sqlite-m8 generator` based on the `flutter-orm-m8` annotation framework.

![usecase001](docs/usecase000-320.gif)

## Dependencies

* flutter-sqlite-m8
* flutter-orm-m8

## CRUD showcase

For this purpose we are demonstrating how to use the code generator and how to integrate the generated code into a demo `Gymspector` application


### Interface: DbAccountEntity

* Example: User Account
* Model: UserAccount
* Field types: 
  * bool
  * int
  * String

![usecase001](docs/usecase001-320.gif)


### Interface: DbAccountRelatedEntity

* Example: Health Records
* Model: HealthEntry\n
* Field types: 
  * DateTime
  * int
  * String   

![usecase002](docs/usecase002-320.gif)

### Interface: DbEntity

* Example: Gym Places
* Model: GymLocation
* Field types: 
  * int
  * String

![usecase003](docs/usecase003-320.gif)

### Interface: DbEntity

* Example: Receipts
* Model: Receipt
* Field types: 
  * bool
  * DateTime
  * double
  * int
  * num
  * String

![usecase004](docs/usecase004-320.gif)