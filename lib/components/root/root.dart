library khoroshilov_su.components.root.root;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import '../menu/menu.dart';
import '../threejs_practics/threejs_practics.dart';
import '../webgl/webgl.dart';
import '../semplex_landing/semplex_landing.dart';
import '../index_test/index_test.dart';
import '../index_test/lvl1/lvl1.dart';
import '../index_test/lvl1/lvl2/lvl2.dart';

@Component(
    selector: 'root-cmp',
    templateUrl: 'root.html',
    styleUrls: const ['root.css'],
    directives: const [ROUTER_DIRECTIVES]
)
@RouteConfig(const [
  const Route(
      path: '/',
      name: 'Menu',
      component: MenuCmp,
      useAsDefault: true),
  const Route(
      path: '/threejs',
      name: 'Threejs',
      component: ThreeJSPracticsCmp),
  const Route(path: '/webgl',
      name: 'Webgl',
      component: WebGLCmp),
  const Route(path: '/semplex-landing',
      name: 'SemplexLanding',
      component: SemplexLandingCmp),
  const Route(
      path: '/index-test',
      name: 'IndexTest',
      component: IndexTestCmp),
  const Route(
      path: '/index-test/lvl1',
      name: 'IndexTest_Lvl1',
      component: Lvl1Cmp),
  const Route(
      path: '/index-test/lvl1/lvl2',
      name: 'IndexTest_Lvl1_Lvl2',
      component: Lvl2Cmp)
])
class RootCmp
    implements AfterViewInit {

  Router angularRouter;

  RootCmp(Router this.angularRouter) {
  }

  ngAfterViewInit() {
  }

}
