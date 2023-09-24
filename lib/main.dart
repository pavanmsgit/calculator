import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const CalculatorMain());
}

class CalculatorMain extends StatelessWidget {
  const CalculatorMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Calculator",
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String inputField = "0";

  int input1 = 0;
  int input2 = 0;
  String operator = "";

  ///FIRST TAKE INPUT
  ///USER WILL TYPE ON NUMBERS AND THAT WILL BE UPDATED IN INPUT FIELD
  ///THE MOMENT USER CLICKS ON OPERATOR, INPUT 1 SHOULD BE UPDATED AND INPUT FIELD SHOULD BE CLEARED OR RESET TO 0
  ///OPERATOR SHOULD BE UPDATED
  ///USER WILL ENTER SECOND INPUT
  ///WHEN THE USER CLICKS ON = BUTTON
  ///THE INPUT 2 WILL BE UPDATED
  ///THEN FINAL OUT PUT IS UPDATED IN INPUT FIELD ONLY
  ///COOL?
  ///

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              //INPUT FIELD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                alignment: Alignment.bottomRight,
                width: screenSize.width,
                height: screenSize.height * 0.25,
                child: AutoSizeText(
                  inputField,
                  minFontSize: 50.0,
                  maxFontSize: 100.0,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 100.0),
                ),
              ),

              //KEYBOARD OR BUTTONS
              Container(
                height: screenSize.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(
                            screenSize: screenSize,
                            character: "1",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "2",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "3",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "+",
                            color: Colors.amber.shade700,isNumber:false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(
                            screenSize: screenSize,
                            character: "4",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "5",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "6",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "-",
                            color: Colors.amber.shade700,isNumber:false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(
                            screenSize: screenSize,
                            character: "7",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "8",
                            color: Colors.black54,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "9",
                            color: Colors.black54 ,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "x",
                            color: Colors.amber.shade700 ,isNumber:false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(
                            screenSize: screenSize,
                            character: "AC",
                            color: Colors.black26,
                            textColor: Colors.black ,isNumber:false),
                        button(
                            screenSize: screenSize,
                            character: "0",
                            color: Colors.black54 ,isNumber:true),
                        button(
                            screenSize: screenSize,
                            character: "=",
                            color: Colors.amber.shade700
                          ,isNumber:false),
                        button(
                            screenSize: screenSize,
                            character: "/",
                            color: Colors.amber.shade700,
                            isNumber:false),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(
      {required Size screenSize,
      required String character,
      required Color color,
      Color? textColor,
      required bool isNumber, ///TRUE - NUMBER WILL BE UPDATED ELSE SPECIAL CHARACTER WILL BE UPDATED AS OPERATOR


      }) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(isNumber){
            ///CHANGE FIRST CHARACTER
            inputField = (inputField + character);
          }else{
            if(character == "AC"){
              inputField = "0";
            }else
              if(character == "="){
              input2 = int.parse(inputField);
              ///PERFORM SOME TASK
              if(input1 != 0 && input2 != 0){
                ///CALCULATION
                switch(operator){
                  case "+":
                    inputField = add(input1, input2).toString();
                    break;
                  case "-":
                    inputField = sub(input1, input2).toString();
                    break;
                  case "x":
                    inputField = mul(input1, input2).toString();
                    break;
                  case "/":
                    inputField = div(input1, input2).toString();
                    break;
                  default:
                    Fluttertoast.showToast(
                        msg: "Bro please select the operation",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                    break;
                }
              }
              else {
                Fluttertoast.showToast(
                    msg: "Bro please enter an input",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
              }
            }else{
              ///IT CAN BE + , - * , /
              input1 = int.parse(inputField);
              operator = character;
              inputField = "";
            }
          }
        });
      },
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: Container(
          width: screenSize.width * 0.2,
          height: screenSize.height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0), color: color),
          child: Center(
            child: Text(
              character,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 35),
            ),
          ),
        ),
      ),
    );
  }

  int add(int a, int b) {
    return a + b;
  }

  int sub(int a, int b) {
    return a - b;
  }

  int mul(int a, int b) {
    return a * b;
  }

  int div(int a, int b) {
    return a ~/ b;
  }
}
