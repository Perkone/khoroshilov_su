library khoroshilov_su.components.threejs_practics.threejs_practics;

import 'package:angular2/core.dart';
import 'dart:html';
import 'dart:async';
import 'package:angular2/router.dart';

import 'jsToDart.dart';

const List<String> js_sources = const [
  'packages/khoroshilov_su/components/threejs_practics/js_libs/three.min.js',
  'packages/khoroshilov_su/components/threejs_practics/js_libs/stats.min.js',
  'packages/khoroshilov_su/components/threejs_practics/js_libs/dat.gui.min.js',
  'packages/khoroshilov_su/components/threejs_practics/threejs_practics.js'
];

@Component(
    selector: 'threejs-practics-cmp',
    templateUrl: 'threejs_practics.html',
    styleUrls: const ['threejs_practics.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class ThreeJSPracticsCmp implements AfterViewInit {

  ElementRef _host;
  Router angularRouter;

  Element get host => (_host.nativeElement as HtmlElement);

  ThreeJSPracticsCmp(this._host, Router this.angularRouter);

  ngAfterViewInit() {
    loadJS().then((_) {
//      threeJSPracticsStart();
    });
  }

  Future loadJS() {
    Completer complete = new Completer();
    List<Future> loadedJS = [];

    for (int i = 0; i < js_sources.length; i++) {
      ScriptElement jScript = new ScriptElement();
      jScript.src = js_sources[i];
      document.head.append(jScript);
      loadedJS.add(jScript.onLoad.first);
    }

    Future.wait(loadedJS).then((e) {
      complete.complete();
    });

    return complete.future;
  }

  threeJSPracticsStart() {
    var practics = new Practics();
    practics.start(host);
  }

}


