import 'dart:io';
import 'dart:typed_data';
import 'package:HyperBeam/pdfView.dart';
import 'package:HyperBeam/pdfViewer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:HyperBeam/attemptQuiz.dart';
import 'package:HyperBeam/services/firebase_quiz_service.dart';
import 'package:HyperBeam/services/firebase_storage_service.dart';
import 'package:HyperBeam/widgets/designConstants.dart';
import 'package:HyperBeam/widgets/progressCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:HyperBeam/services/firebase_module_service.dart';
import 'package:provider/provider.dart';
import 'package:HyperBeam/quizHandler.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ModuleDetails extends StatefulWidget {

  @override
  _ModuleDetailsState createState() => _ModuleDetailsState();
}

class _ModuleDetailsState extends State<ModuleDetails> {
  var moduleRepository;
  var size;

  Widget _buildTaskList(List<dynamic> snapshots) {
    if(snapshots == null) {
      return Container(
        child: Text("loading"),
      );
    }
    return Column(
      children: snapshots.map((data) => TaskCard(data)).toList(),
    );
  }
  Widget _buildQuizList(List<dynamic> snapshots) {
    if(snapshots == null) {
      return Container(
        child: Text("loading"),
      );
    }
    return Column(
      children: snapshots.map((data) => QuizCard(data)).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Args args = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    moduleRepository = Provider.of<FirebaseModuleService>(context).getRepo();
    return Scaffold(
        body: Stack(
            children: <Widget> [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: size.height * .03),
                        height: size.height * .1,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: kExtraBigText),
                            text: " ${args.moduleSnapshot.data['name']}",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTaskList(args.taskList),
                      _buildQuizList(args.quizList),
                      Container(
                      ),
                    ],
                  )
              ),
            ]
        )
    );
  }
}

class TaskCard extends StatelessWidget {
  DocumentSnapshot snapshot;
  TaskCard(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
      margin: EdgeInsets.all(16),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 16,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:20, left: 15),
            child: RichText(
              text: TextSpan(
                text: "Task:  ${snapshot.data['name']}\n",
                style: TextStyle(
                  fontSize: kMediumText,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: (){},
          )
        ],
      ),
    );

  }
}
class QuizCard extends StatelessWidget {
  DocumentSnapshot snapshot;
  QuizCard(this.snapshot);



  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final dialogContext = context;
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(20.0)
              ),
              backgroundColor: kSecondaryColor,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  height: 120,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Obtain Master PDF"),
                        color:  kPrimaryColor,
                        onPressed: () async  {
                          print("Obtaining");
                          PDFDocument doc = await PDFDocument.fromURL(snapshot.data['masterPdfUri']);
                          print("Obtained $doc");
                          if (snapshot.data['masterPdfUri'] != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewer(doc)
                                    )
                            );

                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            child: Text("Delete"),
                            color: Colors.red,
                            onPressed: () async {
                              print("DELETE");
                              /*
                              final quizRepository = Provider.of<FirebaseQuizService>(context).getRepo();
                              quizRepository.delete(snapshot);

                               */
                              Navigator.pop(dialogContext);
                            },
                          ),
                          RaisedButton(
                            child: Text("Upload PDF file"),
                            color: kAccentColor,
                            onPressed: () async {
                              final firebaseStorageReference = Provider.of<FirebaseStorageService>(context);
                              final quizRepository = Provider.of<FirebaseQuizService>(context).getRepo();
                              File file = await FilePicker.getFile(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              );
                              final pdfUrl = await firebaseStorageReference.uploadPdf(file: file,
                                  docId: snapshot.documentID);
                              print("PDFURL is $pdfUrl");
                              snapshot.data['masterPdfUri'] = pdfUrl;
                              await quizRepository.updateDoc(Quiz.fromSnapshot(snapshot));
                              await file.delete();
                              /*
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                }),
                              );
                              */
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            );
          }
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        margin: EdgeInsets.all(16),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 33,
              color: Color(0xFFD3D3D3).withOpacity(.84),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:20, left: 15),
              child: Container(
                width: size.width*0.4,
                child: RichText(
                  overflow: TextOverflow.fade,
                  text: TextSpan(
                    text: "Quiz: ${snapshot.data == null ? "NOTHING":snapshot.data['name']} \n",
                    style: TextStyle(
                      fontSize: kMediumText,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top:10, right: 15),
              child: RichText(
                overflow: TextOverflow.fade,
                text: TextSpan(
                  text: "Score: \n${snapshot.data['score'] == null ? "Not attempted" : "${snapshot.data['score']} out of ${snapshot.data['fullScore']}"} \n",
                  style: TextStyle(
                    fontSize: kSmallText,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return AttemptQuiz(snapshot: snapshot,);
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }

}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    print("THIS PATH IS ${widget.path}");
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
            backgroundColor: Colors.red,
            label: Text("Go to ${_currentPage - 1}"),
            onPressed: () {
              _currentPage -= 1;
              _pdfViewController.setPage(_currentPage);
            },
          )
              : Offstage(),
          _currentPage+1 < _totalPages
              ? FloatingActionButton.extended(
            backgroundColor: Colors.green,
            label: Text("Go to ${_currentPage + 1}"),
            onPressed: () {
              _currentPage += 1;
              _pdfViewController.setPage(_currentPage);
            },
          )
              : Offstage(),
        ],
      ),
    );
  }
}