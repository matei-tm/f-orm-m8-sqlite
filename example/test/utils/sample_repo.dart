import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';

GymLocationProxy gymLocationProxySample01 = GymLocationProxy()
  ..id = 1
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..rating = 5
  ..description = "silva";

GymLocationProxy gymLocationProxySample02 = GymLocationProxy()
  ..id = 2
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763031)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763032)
  ..rating = 2
  ..description = "montis";

HealthEntryProxy healthEntryProxySample01 = HealthEntryProxy()
  ..id = 1
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763046)
  ..accountId = 2
  ..description = "happy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763047)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763048);

HealthEntryProxy healthEntryProxySample02 = HealthEntryProxy()
  ..id = 2
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763042)
  ..accountId = 2
  ..description = "healthy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763043)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763044);

ReceiptProxy receiptProxySample01 = ReceiptProxy()
  ..id = 1
  ..isBio = true
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..quantity = 3.1415
  ..numberOfItems = 44
  ..storageTemperature = 106
  ..description = "Happiness forever"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763037);

ReceiptProxy receiptProxySample02 = ReceiptProxy()
  ..id = 2
  ..isBio = false
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..quantity = 1.41
  ..numberOfItems = 13
  ..storageTemperature = -38
  ..description = "Joy forever"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763037);
