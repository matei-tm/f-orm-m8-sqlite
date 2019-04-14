---
name: Publish request
about: Publish master branch
title: ''
labels: 'publish'
assignees: ''

---

**Publish checklist**

- [ ] Update the src/pubspec.yaml with the required version
- [ ] Update the changelog
- [ ] Update documentation
  - [ ] README.md
  - [ ] src/README.md
  - [ ] example/README.md
- [ ] Format the code
  - [ ]  in src  ```dartfmt -w --fix src```
  - [ ]  in example ```dartfmt -w --fix example```
- [ ] Run tests 
  - [ ] ```cd src```
  - [ ] ```pub run test```
  - [ ] ```cd ..```
  - [ ] ```cd example```
  - [ ] ```flutter test```
  - [ ] ```cd ..```
- [ ] Commit with message `#xxxx. Publish review completed`
- [ ] Merge develop changes into master
  - [ ] Check CI [results](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator) 
- [ ] Dry run
  - [ ] ```cd src```
  - [ ] ```pub publish --dry-run```
- [ ] Publish ```pub publish```
- [ ] Commit empty ```git commit --allow-empty -m "Completed publish closes #xxxx."```

