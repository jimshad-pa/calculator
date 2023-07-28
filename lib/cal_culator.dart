
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  List buttons=[
    '7','8','9','/',
    '4','5','6','*',
    '1','2','3','-',
    'c','0','=','+'
  ];
  String _input='';
  double _result=0.0;
  void _onBtpressed(String buttonText){
    setState(() {
      if(buttonText=='c'){
        _input ='';
        _result = 0.0;
      }
      else if(buttonText=='=') {
        try {
          _result = evalExpression(_input);
          _input = _result.toString();
        }
        catch (e) {
          _input = 'Error';
        }
      } else {
        _input += buttonText;
      }
    });
  }
  double evalExpression(String expression){
    try{
      Parser p=Parser();
      Expression exp=p.parse(expression);
      ContextModel cm=ContextModel();
      double evalresult = exp.evaluate(EvaluationType.REAL, cm);
      return double.parse(evalresult.toStringAsFixed(2));
    } catch(e){
      throw Exception("invalid expression");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
        children: [
          Expanded(
            child: Container(
             alignment: Alignment.bottomRight,
              child: Text(_input, style: TextStyle(fontSize: 70,color: Colors.white),
                ),
            ),
          ),
          Divider(height: 1),
              Expanded(flex: 2,
                child: Container(
            child: GridView.builder(
                itemCount: buttons.length,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4 ),
                  itemBuilder: (context,index){
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: (){
                          _onBtpressed(buttons[index]);
                        }, child: Text(buttons[index] ,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),));
                  }),
          ),
              )


      ],
    )
    );
  }
}
