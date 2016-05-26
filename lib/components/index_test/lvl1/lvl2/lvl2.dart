library khoroshilov_su.components.lvl2.lvl2;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'lvl2-cmp',
    templateUrl: 'lvl2.html',
    styleUrls: const ['lvl2.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class Lvl2Cmp implements OnInit {
  ngOnInit() {
    changeTitle('Level 2 | Хорошилов А.С.');
  }
}

