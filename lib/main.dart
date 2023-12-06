import 'package:flutter/material.dart';
import 'dart:math';

import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const Calculator());
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<String> str1 = [
//     "c","*","/","<-",
//     "1","2","3","+",
//     "4","5","6","-",
//     "7","8","9","*",
//     "%","0",".","=",
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Calculator App'),),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 40,),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 40,),
//               Container(
//                 height: 700,
//                 child: GridView.count(
//                   crossAxisCount: 4,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                   padding: const EdgeInsets.all(8),
//                   children: [
//                     for(int i=0;i<str1.length;i++)...{
//                       SizedBox(
//                         child: ElevatedButton(
//                           onPressed: (){},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightBlue.shade200,
//                             foregroundColor: Colors.black,
//                             elevation: 4,
//                           ),
//                           child: Text(str1[i],style: const TextStyle(
//                               fontSize: 20
//                           ),
//                           ),
//                         ),
//                       )
//                     }
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class Calculator extends StatefulWidget {
const Calculator({Key? key}) : super(key: key);

@override
State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
List<String> str = [
"C", "*",
"/", "<-",
"1",
"2",
"3",
"+",
"4",
"5",
"6",
"-",
"7",
"8",
"9",
"*",
"%",
"0",
".",
"=",
];

final TextEditingController _textController = TextEditingController();
String _displayText = '';

@override
Widget build(BuildContext context) {
return MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blueGrey,scaffoldBackgroundColor: Colors.blue.shade100,
    fontFamily: 'Montserrat-BoldItalic'
  ),
  debugShowCheckedModeBanner: false,
  home: Scaffold(
  appBar: AppBar(
  title:  const Text("Calculator"),
  ),
  body: ListView(
  children: [
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
  controller: _textController,
  readOnly: true,
  textAlign: TextAlign.right,
  style: const TextStyle(fontSize: 25),
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.all(18),
  ),
  ),
  ),
  GridView.count(
  shrinkWrap: true,
  crossAxisCount: 4,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  children: [
  for (int i = 0; i < str.length; i++) ...{
  ElevatedButton(
  style: ElevatedButton.styleFrom(
  // backgroundColor: Colors.redAccent,
  // foregroundColor: Colors.black,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
  ),
  ),
  child: Text(
  str[i],
  style: const TextStyle(fontSize: 20),
  ),
  onPressed: () {
  _handleButtonPress(str[i]);
  },
  )
  }
  ],
  ),
  ],
  ),
  ),
);
}

void _handleButtonPress(String value) {
setState(() {
if (value == "C") {
_displayText = '';
} else if (value == "<-") {
if (_displayText.isNotEmpty) {
_displayText = _displayText.substring(0, _displayText.length - 1);
}
} else if (value == "=") {
_displayText = _calculateResult(_displayText);
} else {
_displayText += value;
}

_textController.text = _displayText;
});
}

String _calculateResult(String expression) {
try {
Parser p = Parser();
Expression exp = p.parse(expression);
ContextModel cm = ContextModel();
double eval = exp.evaluate(EvaluationType.REAL, cm);
return eval.toString();
} catch (e) {
return "Error";
}
}
}
