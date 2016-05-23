library khoroshilov_su.components.root.root;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
//import 'package:route_hierarchical/client.dart' as RH;

import '../threejs_practics/threejs_practics.dart';

@Component(
    selector: 'root-cmp',
    templateUrl: 'root.html',
    directives: const [ROUTER_DIRECTIVES, ThreeJSPracticsCmp]
)
class RootCmp implements AfterViewInit {
  ElementRef _host;
  Router angularRouter;
  String location = 'menu';

  RootCmp(this._host, Router this.angularRouter);

  ngAfterViewInit() {

  }
}
