library khoroshilov_su.components.index_test.index_test;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'index-test-cmp',
    templateUrl: 'index_test.html',
    styleUrls: const ['index_test.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class IndexTestCmp
    implements OnActivate {

  routerOnActivate(next, prev) {
    changeTitle('Index test | Хорошилов А.С.');
  }

}
