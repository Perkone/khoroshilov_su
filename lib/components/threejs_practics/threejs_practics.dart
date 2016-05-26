library khoroshilov_su.components.threejs_practics.threejs_practics;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';
import 'dart:async';
import 'package:khoroshilov_su/utils.dart';
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
    directives: const []
)
class ThreeJSPracticsCmp implements AfterViewInit, OnInit {

  ElementRef _host;

  Element get host => (_host.nativeElement as HtmlElement);

  ThreeJSPracticsCmp(this._host);

  ngOnInit() {
    changeTitle('ThreeJS | Хорошилов А.С.');
  }

  ngAfterViewInit() {
    loadJS().then((_) {
      threeJSPracticsStart();
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
    practics.runIt(host);
  }

}



