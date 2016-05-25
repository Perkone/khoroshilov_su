library khoroshilov_su.components.semplex_landing.semplex_landing;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:khoroshilov_su/utils.dart';
import 'dart:html';
import 'dart:convert';
import 'package:khoroshilov_su/components/semplex_landing/components/landing_component/landing_component.dart';


@Component(
    selector: 'semplex-landing-cmp',
    templateUrl: 'semplex_landing.html',
    styleUrls: const ['semplex_landing.css'],
    directives: const [FORM_DIRECTIVES, LandingComponent]
)
class SemplexLandingCmp implements OnActivate {

  routerOnActivate(next, prev) {
    changeTitle('Semplex landing | Хорошилов А.С.');
  }

  buttonClickOff() {
    Element e = document.querySelector('#top-panel');
    e.attributes.remove('active');
  }

  scrollToForm() {
    Element e = querySelector('form');
    e.scrollIntoView();
  }

  String name = '';
  String email = '';
  String phone = '';

  sendFormData(
      [String host = 'localhost', String name = 'Темыч (ТЕСТ)', String email = '001100110011@mail.ru (ТЕСТ)', String phone = '+7 (921) 654-37-99 (ТЕСТ)']) {
    var requestHeaders = {
      'iam': 'spxman'
    };
    var sendString = '''
{
  "name": "$name",
  "email": "$email",
  "phone": "$phone"
}
  ''';
    var sendData = UTF8.encode(sendString);
    HttpRequest.request('http://$host:26000/send-info', method: 'POST',
        requestHeaders: requestHeaders,
        sendData: sendData);

    String mailMessage = '''
ОТПРАВИЛ
  Имя: $name
  Почта: $email
  Телефон: $phone
-----------------------------
''';
    print(mailMessage);
    markAsClicked();
  }

  markAsClicked() {
    Element e = document.querySelector('#blue-button-text');
    e.attributes['style'] += ' color: black;';
    e.innerHtml = 'СПАСИБО';
  }

}
