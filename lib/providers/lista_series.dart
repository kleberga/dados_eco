import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../variables_class.dart';

class ListaDeSeries extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  var codAssunto;
  var dataIni;
  var chartData;
  var dataInicialSerie;
  var dataFinalSerie;
  var periodicidade;
  var formatoData;
  var ultimaDataSerie;
  var listaAnosSerieAnual = [];
  var anoInicialSelecionado;
  var anoFinalSelecionado;
  var dtInicial;
  String urlSerie = '';
  var fonte;
  var cod_serie;
  String dropdownValue = "";
  String dropdownValueMetrica = "";
  String dropdownValueNivelGeog = "";
  String dropdownValueLocalidade = "";
  String dropdownValueCategoria = "";
  var formatoDataGrafico;
  List<String> listaMostrar = [];
  List<String> listaMostrarMetrica = [];
  List<String> listaMostrarNivelGeog = [];
  List<String> listaMostrarLocalidade = [];
  List<String> listaMostrarCategoria = [];
  var nomeSerie;
  var formatoSerie;

  DateTime startval1 = DateFormat("MM/yyyy").parse('01/2021');
  DateTime endval1 = DateFormat("MM/yyyy").parse('12/2021');

  NumberFormat formatter1 = new NumberFormat("00");
  NumberFormat formatter2 = new NumberFormat("0000");

  // essas datas para startval1 e endval1 sao apenas para iniciar as variaveis
  void atribuirValorDataInicial(){
    if(formatoData == 'dd/MM/yyyy'){
      dtInicial = '01/01/2021';
    } else {
      dtInicial = '01/2021';
    }
    startval1 = DateFormat(formatoData).parse(dtInicial);
    endval1 = DateFormat(formatoData).parse(dtInicial);
    notifyListeners();
  }

 /* Future<List<cadastroSeries>> carregarLista(int codAssunto) async {
    await db.collection('indice_precos')
        .where('idAssunto', isEqualTo: codAssunto)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listaEscolhida.add(cadastroSeries(
            doc["numero"],
            doc["nome"],
            doc["nomeCompleto"],
            doc["descricao"],
            doc["formato"],
            doc["fonte"],
            doc["urlAPI"],
            doc["idAssunto"],
            doc["periodicidade"],
            doc["metrica"],
            doc["nivelGeografico"],
            doc["localidades"],
            doc["categoria"]));
      });
    });
    print("listaEscolhida: $listaEscolhida");
    return listaEscolhida;
  }*/

/*  ListaDeSeries(){
    listaEscolhida = carregarLista(codAssunto);
    notifyListeners();
  }*/

  void atualizaCodAssunto(int codigo){
    codAssunto = codigo;
    //notifyListeners();
  }

  Future<String> getJsonFromRestAPI(String url_serie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('urlSerieArmaz', urlSerie);
    await prefs.setString('fonteSerieArmaz', fonte);
    await prefs.setString("codigoArmaz", cod_serie);
    await prefs.setString("metricaArmaz", dropdownValueMetrica);
    await prefs.setString("localidadeArmaz", dropdownValueLocalidade);
    await prefs.setString("categoriaArmaz", dropdownValueCategoria);
    String url = url_serie;
    http.Response response = await http.get(Uri.parse(url));
    notifyListeners();

    return response.body;
  }

  Future loadDataSGS() async {
    String jsonString = await getJsonFromRestAPI(urlSerie);
    final jsonResponse = json.decode(jsonString);
    //setState(() {
      for (Map<String, dynamic> i in jsonResponse){
        if(i['valor']!=""){
          chartData.add(serie_app.fromJson(i));
        }
      }
      endval1 = chartData.last.data;
      startval1 = chartData[chartData.length-13].data;
      chartData.sort((a, b){ //sorting in descending order
        return a.data.compareTo(b.data);
      });
      dataInicialSerie = DateFormat(formatoData).format(chartData.first.data).toString();
      dataFinalSerie = DateFormat(formatoData).format(chartData.last.data).toString();
      listaAnosSerieAnual = chartData.map((e) => e.data.toString().substring(0,4)).toSet().toList();
      anoInicialSelecionado = listaAnosSerieAnual.length-13;
      anoFinalSelecionado = listaAnosSerieAnual.length-1;
    //});
    ultimaDataSerie = chartData.last.data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataFinal', endval1.toString());
    notifyListeners();
  }


  Future loadDataIBGE() async {
    String jsonString = await getJsonFromRestAPI(urlSerie);
    final jsonResponse = json.decode(jsonString);
    final item = jsonResponse[0]['resultados'][0]['series'][0]['serie'];
    //setState(() {
    for (var i = 0; i<item.keys.toList().length; i++){
      var x = item.keys.toList()[i];
      var w = formatter1.format(int.parse(x.substring(4)));
      if(periodicidade=="trimestral") {
        if(w=="01"){
          w = "03";
        } else if(w=="02"){
          w = "06";
        } else if(w=="03"){
          w = "09";
        } else {
          w = "12";
        }
      }
      x = w + "/" + formatter2.format(int.parse(x.substring(0, 4)));
      var y = item.values.toList()[i].toString();
      if(y!="..."&&y!="-"){
        chartData.add(
            serie_app(
                DateFormat('MM/yyyy').parse(x),
                double.parse(y)
            )
        );
      }
    }
    chartData.sort((a, b){ //sorting in descending order
      return a.data.compareTo(b.data);
    });
    dataInicialSerie = DateFormat(formatoData).format(chartData.first.data).toString();
    dataFinalSerie = DateFormat(formatoData).format(chartData.last.data).toString();
    ultimaDataSerie = chartData.last.data;
    listaAnosSerieAnual = chartData.map((e) => e.data.toString().substring(0,4)).toSet().toList();
    anoInicialSelecionado = listaAnosSerieAnual.length-13;
    anoFinalSelecionado = listaAnosSerieAnual.length-1;
    //});
    endval1 = chartData.last.data;
    startval1 = chartData[chartData.length-13].data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataFinal', endval1.toString());
    notifyListeners();
  }

  void formatarData(){
    if(periodicidade=="anual"){
      formatoData = "yyyy";
      formatoDataGrafico = "yyyy";
    } else if(periodicidade=="diária"){
      formatoData = "dd/MM/yyyy";
      formatoDataGrafico = "dd/MM/yy";
    } else {
      formatoData = "MM/yyyy";
      formatoDataGrafico = "MM/yy";
    }
    notifyListeners();
  }

  void updateDropdownValueFirst(List listaEscolhida){
    listaMostrar = listaEscolhida.map((element) => element.nome.toString()).toList().toSet().toList();
    dropdownValue = listaMostrar.first;
    notifyListeners();
  }


  void updateDropdows(List listaEscolhida){
    listaMostrarMetrica = listaEscolhida.where((element) => element.nome==dropdownValue).map((e) => e.metrica.toString()).toSet().toList();
    dropdownValueMetrica = listaMostrarMetrica.first;

    listaMostrarNivelGeog = listaEscolhida.where((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica).map((e) => e.nivelGeografico.toString()).toSet().toList();
    dropdownValueNivelGeog = listaMostrarNivelGeog.first;

    listaMostrarLocalidade = listaEscolhida.where((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog).map((e) => e.localidades.toString()).toSet().toList();
    dropdownValueLocalidade = listaMostrarLocalidade.first;

    listaMostrarCategoria = listaEscolhida.where((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade).map((e) => e.categoria.toString()).toSet().toList();
    dropdownValueCategoria = listaMostrarCategoria.first;

    urlSerie = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).urlAPI;

    fonte = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).fonte;

    cod_serie = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).numero;

    nomeSerie = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).nome;

    formatoSerie = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).formato;

    periodicidade = listaEscolhida.firstWhere((element) => element.nome==dropdownValue &&
        element.metrica==dropdownValueMetrica && element.nivelGeografico==dropdownValueNivelGeog &&
        element.localidades==dropdownValueLocalidade && element.categoria==dropdownValueCategoria).periodicidade;
    notifyListeners();
  }

}