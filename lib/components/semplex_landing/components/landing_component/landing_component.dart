library semplex_landing.components.landing_component.landing_component;

import 'package:angular2/angular2.dart';
import 'dart:html';
import 'package:khoroshilov_su/components/semplex_landing/components/hollow_button_component/hollow_button_component.dart';

@Component(selector: 'landing',
    templateUrl: 'landing_component.html',
    styleUrls: const ['landing_component.css'],
    directives: const [HollowButtonComponent]
)
class LandingComponent {

  buttonClick() {
    Element e = document.querySelector('#top-panel');
    e.setAttribute('active', '');
  }

}



