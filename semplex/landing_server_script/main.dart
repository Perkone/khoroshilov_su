library lalka_server;

import 'dart:io';
import 'dart:convert';
import 'package:mailer/mailer.dart';

main(List<String> args) {
  HttpServer.bind(InternetAddress.ANY_IP_V4, 26000).then((server) {
    server.listen((HttpRequest request) => requestHandler(request));
  });
}

void sendInfo(jsonObject) {
  String textToSend = '';

  if (jsonObject.keys.contains('name')) {
    textToSend += 'Name: ${jsonObject['name']}';
  }
  if (jsonObject.keys.contains('phone') && textToSend.isNotEmpty) {
    textToSend += '\nPhone: ${jsonObject['phone']}';
  }
  if (jsonObject.keys.contains('email') && textToSend.isNotEmpty) {
    textToSend += '\nEmail: ${jsonObject['email']}';
  }

  var options = new GmailSmtpOptions()
    ..username = 'semplex.it@gmail.com'
    ..password = '321321123';

  var emailTransport = new SmtpTransport(options);

  var envelope = new Envelope()
    ..from = 'semplex.it@gmail.com'
    ..recipients.add('semplex.it@yandex.ru')
//    ..bccRecipients.add('hidden@recipient.com')
    ..subject = 'Контакты клиента - клик на сайте'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = textToSend;
//    ..html = '<h1>Test</h1><p>Hey!</p>';

  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void requestHandler(HttpRequest request) {

  var pathSegments = request.uri.pathSegments;

  if (pathSegments.isEmpty) {
    request.response.close();
    return;
  }

  String pathLvl1 = pathSegments[0];
  switch (pathLvl1) {
    case 'send-info':
      var originHeader = request.headers['Origin'];
      if (originHeader != null) {
        request.response.headers.set('Access-Control-Allow-Origin', originHeader[0]);
        print('Sent response to: ${originHeader[0]}');
      }
      request.response.headers.set('Access-Control-Allow-Headers', 'iam');
//  request.response.headers.set('Access-Control-Expose-Headers', 'iam');
      request.response.headers.set('Access-Control-Allow-Methods', 'POST');
//  request.response.headers.set('Access-Control-Allow-Credentials', 'true');

      bool norm = false;
      request.headers.forEach((name, values) {
        if (name == 'iam' && values.contains('spxman')) {
          norm = true;
        }
      });

      if (!norm) {
        request.response.write('Need authentication.');
        request.response.close();
        return;
      }

      Utf8Codec utfCodec = new Utf8Codec();
      utfCodec.decodeStream(request).then((bodyString) {
        if (bodyString == null) {
          request.response.write('No body is here.');
          request.response.close();
          return;
        }

        if (bodyString.isEmpty) {
          request.response.write('No body is here.');
          request.response.close();
          return;
        }

        JsonCodec jsonCodec = new JsonCodec();
        var jsonObj;
        try {
          jsonObj = jsonCodec.decode(bodyString);
        } catch (e) {
          request.response.write('Bad body.');
          request.response.close();
          return;
        }

        sendInfo(jsonObj);
        request.response.close();
      });
    default:
      request.response.close();
  }
}
