library khoroshilov_su.components.home.home;

import 'package:angular2/core.dart';
import 'dart:html';

@Component(
    selector: 'home-cmp',
    templateUrl: 'home.html',
    styleUrls: const ['home.css'],
    directives: const []
)
class HomeCmp
    implements AfterContentChecked {

  ngAfterContentChecked() {
    if (window.location.hash == '#!') {
      window.history.pushState(null, null, '/');
    }
  }

}
