library khoroshilov_su.components.menu.menu;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'menu-cmp',
    templateUrl: 'menu.html',
    styleUrls: const ['menu.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class MenuCmp implements OnInit {

  ngOnInit() {
    changeTitle('Хорошилов А.С.');
  }

}
