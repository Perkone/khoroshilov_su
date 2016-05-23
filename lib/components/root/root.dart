library khoroshilov_su.components.root.root;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import '../home/home.dart';
import '../threejs_practics/threejs_practics.dart';
import '../webgl/webgl.dart';
import '../lvl1/lvl1.dart';



@Component(
    selector: 'root-cmp',
    templateUrl: 'root.html',
    styleUrls: const ['root.css'],
    directives: const [ROUTER_DIRECTIVES]
)
@RouteConfig(const [
  const Route(path: '/', name: 'Home', component: HomeCmp, useAsDefault: true),
  const Route(path: '/threejs', name: 'Threejs', component: ThreeJSPracticsCmp),
  const Route(path: '/webgl', name: 'Webgl', component: WebGLCmp),
  const Route(path: '/lvl1/...', name: 'Lvl1', component: Lvl1Cmp)
])
class RootCmp {

  Router angularRouter;

  RootCmp(Router this.angularRouter) {
  }

}
