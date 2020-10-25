
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:zulassung123/Controller/mailservice.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  final String name;

  const PdfViewerPage({Key key, this.path, this.name}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    print("Ok " + path);
    return PDFViewerScaffold(
      path: path,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: ()async{
              await MailService().sendMailToClient(path, name);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          )
        ],
      )
    );
  }
}
