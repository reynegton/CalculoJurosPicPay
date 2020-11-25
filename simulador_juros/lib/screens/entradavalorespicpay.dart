import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador_juros/src/calculoprestacao.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class EntradaValoresPicPay extends StatefulWidget {
  @override
  _EntradaValoresPicPayState createState() => _EntradaValoresPicPayState();
}

class _EntradaValoresPicPayState extends State<EntradaValoresPicPay> {
  final MoneyMaskedTextController _valorTotalController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: '');
  List<Widget> parcelas = new List();

  List<Widget> retornarParcelas() {
    CalculoPrestacao calculoPrestacao = CalculoPrestacao();
    double valorTotal = double.tryParse(_valorTotalController.text) ?? 0;
    List<Widget> resultado = new List();
    if (valorTotal == 0)
      return resultado;
    else {
      List<Parcela> parcelas = calculoPrestacao.calcular(valorTotal);
      for (var item in parcelas) {
        resultado.add(Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Parcelado em ${item.numParcela} vez${item.numParcela == 1 ? "" : "es"}",
                ),
                subtitle: Container(
                  alignment: Alignment.bottomLeft,
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                          'Valor Parcela: ${item.valorParcela.toStringAsFixed(2)}'),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                          'Valor Total: ${item.valorTotal.toStringAsFixed(2)}'),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
      }
      return resultado;
    }
  }

  void onClick(bool calcular) {
    setState(() {
      if (calcular)
        parcelas = retornarParcelas();
      else
        _valorTotalController.text = "0.00";
      parcelas = retornarParcelas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculos Juros Pic Pay'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: TextField(
                maxLines: 1,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.white),
                controller: _valorTotalController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                decoration: InputDecoration(
                  hintText: 'Valor Total',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.attach_money),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                    child: Text('Calcular'),
                    color: Colors.cyan,
                    onPressed: () => {onClick(true)}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                    child: Text('Limpar'),
                    color: Colors.cyan,
                    onPressed: () => {onClick(false)}),
              ),
            ]),
            Expanded(
              child: ListView(children: parcelas),
            ),
          ],
        ),
      ),
    );
  }
}
