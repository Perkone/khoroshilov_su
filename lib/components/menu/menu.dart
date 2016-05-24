library khoroshilov_su.components.menu.menu;

import 'package:angular2/core.dart';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'menu-cmp',
    templateUrl: 'menu.html',
    styleUrls: const ['menu.css'],
    directives: const []
)
class MenuCmp
    implements AfterViewInit {

  ngAfterViewInit() {
    changeTitle('Menu | Хорошилов А.С.');
  }

}
