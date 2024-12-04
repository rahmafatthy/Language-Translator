import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  final languages = [
    'Arabic',
    'English',
    'Hindi',
    'French',
    'German',
    'Spanish',
    'Chinese (Simplified)',
    'Chinese (Traditional)',
    'Japanese',
    'Korean',
    'Russian',
    'Portuguese',
    'Italian',
    'Turkish',
    'Bengali',
    'Malay',
    'Indonesian',
    'Thai',
    'Vietnamese',
    'Urdu',
  ];  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = " ";
  @override
  void initState() {
    super.initState();

    // Add listener to monitor text field changes
    languageController.addListener(() {
      if (languageController.text.isEmpty) {
        setState(() {
          output = " ";
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    languageController.dispose();
    super.dispose();
  }
  TextEditingController languageController = TextEditingController();
  void translate(String src, String dest, String input) async {
    try {
      if (src == '--' || dest == '--' || input.isEmpty) {
        setState(() {
          output = "Invalid input";
        });
        return;
      }
      GoogleTranslator translator = GoogleTranslator();
      final translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text.toString();
      });
    } catch (e) {
      // Handle translation errors
      setState(() {
        if (e.toString().contains("Unsupported")) {
          output = "The selected language pair is not supported.";
        } else {
          output = "An error occurred: $e";
        }
      });
    }
  }


  String getLanguageCode(String language) {
    switch (language) {
      case "Arabic":
        return "ar";
      case "English":
        return "en";
      case "Hindi":
        return "hi";
      case "French":
        return "fr";
      case "German":
        return "de";
      case "Spanish":
        return "es";
      case "Japanese":
        return "ja";
      case "Korean":
        return "ko";
      case "Russian":
        return "ru";
      case "Portuguese":
        return "pt";
      case "Italian":
        return "it";
      case "Turkish":
        return "tr";
      case "Bengali":
        return "bn";
      case "Malay":
        return "ms";
      case "Indonesian":
        return "id";
      case "Thai":
        return "th";
      case "Vietnamese":
        return "vi";
      case "Urdu":
        return "ur";
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Language Translator", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.black,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                          child: Text(dropDownStringItem),
                          value: dropDownStringItem);
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.black,
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    focusColor: Colors.black,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                          child: Text(dropDownStringItem),
                          value: dropDownStringItem);
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Enter Your Text ',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Text";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    translate(
                        getLanguageCode(originLanguage),
                        getLanguageCode(destinationLanguage),
                        languageController.text.toString());
                  },
                  child: Container(width:double.infinity,height:60,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text("Translate",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),)),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("\n$output",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22))
            ],
          ),
        ),
      ),
    );
  }
}
