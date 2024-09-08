// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:language_code/language_code.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? from_lang_code;
  String? to_lang_code;
  String? source_text;
  String? translatedText;
  TextEditingController inputTextcontroller = TextEditingController();
  TextEditingController ouputTextcontroller = TextEditingController();
  List<String> language_list = ['English', 'German', 'Russian'];

  bool isLoading = false;
  void translatelanguage(String? from, String? to) async {
    var translator = GoogleTranslator();
    // print(
    //     'from ${fromLangCode.first.toString().split('.')[1]}  to ${toLangCode.first.toString().split('.')[1]}');

    try {
      if (from == null || to == null) {
        throw Exception('Select Source and Destination language');
      }

      var srcText = inputTextcontroller.text.trim();
      if (srcText == '') {
        throw Exception('Source Text is manadatory..!');
      }
      setState(() {
        isLoading = true; // Start loading spinner
      });

      var fromLangCode = LanguageCodes.fromEnglishName(from);
      var toLangCode = LanguageCodes.fromEnglishName(to);
      var translation = await translator.translate(srcText,
          from: fromLangCode.first.toString().split('.')[1],
          to: toLangCode.first.toString().split('.')[1]);

      setState(() {
        translatedText = translation.text.toString();
        ouputTextcontroller.text = translatedText.toString();
        isLoading = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void viceVersaTranslation() {
    String? temp = from_lang_code;
    setState(() {
      from_lang_code = to_lang_code;
      to_lang_code = temp;
      temp = ouputTextcontroller.text;
      ouputTextcontroller.text = inputTextcontroller.text;
      inputTextcontroller.text = temp!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language Translator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 2, 0, 0),
                        width: 130,
                        height: 53,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 70, 70, 70),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        margin: EdgeInsets.all(20),
                        child: DropdownButton(
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white),
                          value: from_lang_code,
                          hint: Text('Select',
                              style: TextStyle(color: Colors.white)),
                          menuWidth: 120,
                          items: language_list.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (String? lang) {
                            setState(() {
                              from_lang_code = lang;
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          viceVersaTranslation();
                        },
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Icon(
                            Icons.change_circle,
                            size: 42,
                            color: Color.fromRGBO(6, 214, 158, 1),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 2, 0, 0),
                        width: 130,
                        height: 53,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 70, 70, 70),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        margin: EdgeInsets.all(20),
                        child: DropdownButton(
                          underline: SizedBox(),
                          value: to_lang_code,
                          style: TextStyle(color: Colors.white),
                          hint: Text(
                            'Select',
                            style: TextStyle(color: Colors.white),
                          ),
                          menuWidth: 120,
                          items: language_list.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (String? lang) {
                            setState(() {
                              to_lang_code = lang;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                        translatelanguage(from_lang_code, to_lang_code);
                      },
                      controller: inputTextcontroller,
                      maxLines: 7,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 118, 118, 118),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        translatelanguage(from_lang_code, to_lang_code);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(6, 214, 158, 1),
                      ),
                      child: Text(
                        'Translate',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: ouputTextcontroller,
                      maxLines: 7,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 118, 118, 118),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) // Show loading spinner
            Positioned.fill(
              child: Container(
                color: Colors.black54, // A semi-transparent background
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(6, 214, 158, 1),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.voice_chat), label: 'Voice chat'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ]),
    );
  }
}
