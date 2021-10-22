import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main () {
  runApp(MaterialApp(
    home: Home() ,
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.6){
        _infoText = "Abaixo do peso ideal(${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Acima do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 40.0){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: (){
              setState(() {
                _resetFields();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formkey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 25
              ),
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              SizedBox(
                height: 25,
              ),
              TextFormField(keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Peso(KG)", labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: pesoController,
              validator: (value){
                if(value == null){
                  return "Insira seu peso";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Altura(cm)", labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: alturaController,
              validator: (value){
                if(value == null)
                  return "Insira sua altura";
              },
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: (){
                      if(_formkey.currentState != null){
                        _calcular();
                      }
                    }, 
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ),
            ],
          ),
        )   
      ),
    );
  }
}