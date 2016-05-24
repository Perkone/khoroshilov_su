library khoroshilov_su.components.lvl1.lvl1;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';

import '../lvl2/lvl2.dart';

@Component(
    selector: 'lvl1-cmp',
    templateUrl: 'lvl1.html',
    styleUrls: const ['lvl1.css'],
    directives: const [ROUTER_DIRECTIVES]
)
@RouteConfig(const [
  const Route(path: '/lvl2', name: 'Lvl2', component: Lvl2Cmp, useAsDefault: true)
])

class Lvl1Cmp implements AfterViewInit{

  ngAfterViewInit(){
    changeTitle('Level 1 | Хорошилов А.С.');
  }

}
