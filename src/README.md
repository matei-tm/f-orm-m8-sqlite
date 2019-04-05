# Sqlite ORM Mate Generator (flutter-sqlite-m8-generator)

![GitHub release](https://img.shields.io/github/release-pre/matei-tm/flutter-sqlite-m8-generator.svg) <!--[![pub package](https://img.shields.io/pub/v/flutter-sqlite-m8-generator.svg)](https://pub.dartlang.org/packages/flutter-sqlite-m8-generator)--> [![Build Status](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator.svg?branch=master)](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator)


## Introduction

Dart package to generate SQLite ready-to-go fixture. Uses [Dart Build System](https://github.com/dart-lang/build) builders. Based on [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8) annotations convention this package generates proxies and database adapter for SQLite.

## Dependencies

It depends on dart package [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8)

## Usage

1. Create a flutter project
2. Add flutter_orm_m8, sqflite, build_runner, flutter_sqlite_m8_generator dependencies to **pubspec.yaml**

    - Before

        ```yaml
        dependencies:
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2

        dev_dependencies:
            flutter_test:
                sdk: flutter
        ```

    - After

        ```yaml
        dependencies:
            flutter_orm_m8: ^0.4.0
            sqflite: ^1.1.0
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2

        dev_dependencies:
            build_runner: ^1.0.0
            flutter_sqlite_m8_generator: ^0.1.0
            flutter_test:
                sdk: flutter

        ```        

3. Add build.yaml file with the following content


    ```yaml
    targets:
      $default:
        builders:
          flutter_sqlite_m8_generator|orm_m8:
            generate_for:
              - lib/models/*.dart
              - lib/main.dart
    ```

4. Refresh packages
   
   ```bash
   flutter packages get
   ```

5. In the lib folder create a new one named **models**
6. In the models folder add model classes for your business objects.
7. Using [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8) annotations convention mark:

   - classes with @DataTable
   - fields with @DataColumn
  
8. Run the build_runner
   
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

   The build_runner will generate:

    - in models folder, a *.g.m8.dart file for each model file
    - in lib folder, a main.adapter.g.m8.dart file

