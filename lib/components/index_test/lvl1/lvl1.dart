library khoroshilov_su.components.lvl1.lvl1;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'lvl1-cmp',
    templateUrl: 'lvl1.html',
    styleUrls: const ['lvl1.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class Lvl1Cmp implements OnInit {

  ngOnInit() {
    changeTitle('Level 1 | Хорошилов А.С.');
  }

}
