library main;

import 'package:angular2/platform/browser.dart';
import 'package:angular2/router.dart';

import 'package:khoroshilov_su/components/root/root.dart';

main() {
  bootstrap(RootCmp, [ROUTER_PROVIDERS]);
}
