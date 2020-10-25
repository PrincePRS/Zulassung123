import 'package:flutter_mailer/flutter_mailer.dart';

class MailService {
//  final clientemail = 'w.liyang@yandex.com';

  Future<void> sendMailToClient(path, name) async {

    final MailOptions mailOptions = MailOptions(
      body: 'Hello. This is from Zulassung123',
      subject: '' + name,
      recipients: [''],
      isHTML: true,
//      bccRecipients: ['other@example.com'],
//      ccRecipients: ['third@example.com'],
      attachments: [ '$path', ],
    );

    await FlutterMailer.send(mailOptions);
  }
}