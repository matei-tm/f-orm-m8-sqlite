import 'drawer_widget_test.dart' as drawerWidget;
import 'gym_places_widget_test.dart' as gymPlacesWidget;
import 'health_entry_widget_test.dart' as healthEntryWidget;
import 'mock_generics_test.dart' as mockGenerics;
import 'receipts_widget_test.dart' as receiptsWidget;
import 'start_widget_test.dart' as startWidget;
import 'account_widget_test.dart' as accountWidget;
import 'gym_location_proxy_test.dart' as gymLocationProxyTest;
import 'health_entry_proxy_test.dart' as healthEntryProxyTest;
import 'user_account_proxy_test.dart' as userAccountProxyTest;
import 'receipt_proxy_test..dart' as receiptProxyTest;
import 'to_do_proxy_test.dart' as toDoProxyTest;

main() {
  mockGenerics.main();
  drawerWidget.main();
  startWidget.main();
  accountWidget.main();
  gymPlacesWidget.main();
  healthEntryWidget.main();
  receiptsWidget.main();
  gymLocationProxyTest.main();
  healthEntryProxyTest.main();
  userAccountProxyTest.main();
  receiptProxyTest.main();
  toDoProxyTest.main();
}
