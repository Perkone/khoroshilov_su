library main;

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/router.dart';

import 'package:khoroshilov_su/components/root/root.dart';

main() {
  bootstrap(
      RootCmp,
      [
        ROUTER_PROVIDERS,
        bind(APP_BASE_HREF).toValue('/')
        , bind(LocationStrategy).toClass(HashLocationStrategy) // TODO: строчка для отладки на локальном серве
      ]
  );
}
