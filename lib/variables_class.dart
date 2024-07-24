
import 'package:intl/intl.dart';

import 'TelaDados.dart';



class serie_app {
  final DateTime data;
  final double valor;
  serie_app(this.data, this.valor);
  factory serie_app.fromJson(Map<String, dynamic> parsedJson){
    var w;
    var data2;
/*    if(cod_serie==200248||cod_serie==200249){
      w = double.parse(parsedJson['valor'])/1000000;
    } else {
      w = double.parse(parsedJson['valor']);
    }*/
/*    if(formatoData=='dd/MM/yyyy'){
      data2 = DateFormat('dd/MM/yyyy').parse(parsedJson['data']);
    } else {
      data2 = DateFormat('MM/yyyy').parse(parsedJson['data'].substring(3));
    }*/
    return serie_app(data2, w);
  }
  @override
  toString(){
    return "data: $data, valor: $valor";
  }
}

class Assunto {
  final int id;
  final String nome;
  Assunto(this.id, this.nome);
}


List<Assunto> listaAssunto = [
  Assunto(1, "Índice de preços"),
  Assunto(2, "Setor real"),
  Assunto(3, "Mercado de trabalho"),
  Assunto(4, "Setor externo"),
  Assunto(5, "Dados monetários")
];

class cadastroSeries {
  final String numero;
  final String nome;
  final String nomeCompleto;
  final String descricao;
  final String formato;
  final String fonte;
  final String urlAPI;
  final int idAssunto;
  final String periodicidade;
  final String metrica;
  final String nivelGeografico;
  final String localidades;
  final String categoria;
  cadastroSeries(this.numero,
   this.nome, this.nomeCompleto, this.descricao, this.formato,
      this.fonte, this.urlAPI, this.idAssunto, this.periodicidade, this.metrica,
      this.nivelGeografico, this.localidades, this.categoria);
  @override
  toString(){
    return "numero $numero, nome: $nome, nomeCompleto: $nomeCompleto, descricao: $descricao, formato: $formato, fonte: $fonte, urlAPI: $urlAPI, idAssunto: $idAssunto, periodicidade: $periodicidade, metrica: $metrica, nivelGeografico: $nivelGeografico, localidade: $localidades, categoria: $categoria";
  }

  factory cadastroSeries.fromDatabase(Map<String, dynamic> map) => cadastroSeries(
      map['numero']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['nomeCompleto'] ?? '',
      map['descricao'],
      map['formato'] ?? '',
      map['fonte'] ?? '',
      map['urlAPI'] ?? '',
      map['idAssunto'] ?? '',
      map['periodicidade'] ?? '',
      map['metrica'] ?? '',
      map['nivelGeografico'] ?? '',
      map['localidades'] ?? '',
      map['categoria'] ?? ''
  );

}
var numeroIndicePrecos = 0;

class Metrica{
  int id;
  String nome;
  Metrica({required this.id, required this.nome});
  @override
  toString(){
    return "id: $id nome: $nome";
  }

}

class NivelGeografico{
  String id;
  String nome;
  NivelGeografico({required this.id, required this.nome});
  @override
  toString(){
    return "id: $id, nome: $nome";
  }
}

class Localidades{
  int id;
  String nome;
  String nivelGeografico;
  Localidades({required this.id, required this.nome, required this.nivelGeografico});
  @override
  toString(){
    return "id: $id, nome: $nome, nivelGeografico: $nivelGeografico";
  }
}

class Categorias{
  int id;
  String nome;
  Categorias({required this.id, required this.nome});
  @override
  toString(){
    return "id: $id, nome: $nome";
  }
}