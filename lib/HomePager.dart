import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePager extends StatefulWidget {
  const HomePager({Key key}) : super(key: key);

  @override
  _HomePagerState createState() => _HomePagerState();
}

class _HomePagerState extends State<HomePager> {
  File file;

  gerarPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }));

    final output = await getExternalStorageDirectory();
    String pathToWrit = output.path + '/teste.pdf';
    File outputFile = File(pathToWrit);
    outputFile.writeAsBytesSync(pdf.save());

    //Mostra o caminho que o pdf foi salvo.
    print(pathToWrit);
    print("salvo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf tester'),
      ),
      body: Center(
        child: file != null
            ? PDF.file(file)
            : ElevatedButton(
                onPressed: () async {
                  File pickedFile = await FilePicker.getFile(
                    allowedExtensions: ['pdf'],
                    type: FileType.custom,
                  );

                  setState(() {
                    file = pickedFile;
                  });
                },
                child: const Text('Abrir pdf'),
              ),
      ),
      //Salva do pdf
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gerarPdf();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
