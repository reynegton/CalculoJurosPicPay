import 'dart:math';

class Parcela{
  int numParcela;
  double valorParcela;
  double valorTotal;
}

class CalculoPrestacao{

  List<Parcela> calcular(double pvalor){
    List<Parcela> parcelas = new List();
    Parcela parcela;
    var jurosPorBoleto = 0.0299;
    var jurosPorParcela = 0.0349;
    double valor;

    if (pvalor == null) {
      valor = 0;
    }
    else
      valor = pvalor;
    valor += valor * jurosPorBoleto;

    for (int i = 1; i <= 12; i++) {
      if (i == 1) {
        parcela = new Parcela();
        parcela.numParcela = i;
        parcela.valorParcela =num.parse(valor.toStringAsFixed(2));
        parcela.valorTotal = num.parse(valor.toStringAsFixed(2));
        parcelas.add(parcela);
      } else {
        parcela = new Parcela();
        parcela.numParcela = i;
        parcela.valorParcela =num.parse((valor * jurosPorParcela / (1 - pow(1 + jurosPorParcela, -i))).toStringAsFixed(2));
        parcela.valorTotal = num.parse((parcela.valorParcela * i).toStringAsFixed(2));
        parcelas.add(parcela);
      }
    }
    return parcelas;
  }

}

