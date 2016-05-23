library khoroshilov_su.components.lvl1.lvl1;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import '../home/home.dart';
import '../lvl2/lvl2.dart';

@Component(
    selector: 'lvl1-cmp',
    templateUrl: 'lvl1.html',
    styleUrls: const ['lvl1.css'],
    directives: const [ROUTER_DIRECTIVES]
)
@RouteConfig(const [
  const Route(path: '/', name: 'Home', component: HomeCmp, useAsDefault: true),
  const Route(path: '/lvl2', name: 'Lvl2', component: Lvl2Cmp)
])

class Lvl1Cmp {
  Router angularRouter;

  Lvl1Cmp(Router this.angularRouter);

}
