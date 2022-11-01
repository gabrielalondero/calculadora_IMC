import 'package:flutter/material.dart';

class ImcCalculatorPage extends StatefulWidget {
  const ImcCalculatorPage({super.key});

  @override
  State<ImcCalculatorPage> createState() => _ImcCalculatorPageState();
}

class _ImcCalculatorPageState extends State<ImcCalculatorPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = 'Informe seus dados';
  String? errorTextWeight;
  String? errorTextHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.person,
              size: 120.0,
              color: Colors.green,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: weightController,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                errorText: errorTextWeight,
                labelStyle: const TextStyle(
                  color: Colors.green,
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20.0,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: heightController,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                errorText: errorTextHeight,
                labelStyle: const TextStyle(
                  color: Colors.green,
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){
                String textWeight = weightController.text;
                if(textWeight.isEmpty){
                  setState(() {
                    _infoText = 'Informe seu peso';
                    errorTextWeight =  'Informe seu peso';
                  });
                  return;
                }
                errorTextWeight = null;
                String textHeight = heightController.text;
                if(textHeight.isEmpty){
                  setState(() {
                    _infoText = 'Informe sua altura';
                    errorTextHeight =  'Informe sua altura';
                  });
                  return;
                } 
                errorTextHeight = null;
                FocusScope.of(context).requestFocus(FocusNode()); //teclado se recolhe
                _calculate();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(14),
              ),
              child: const Text(
                "Calcular",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }
}
