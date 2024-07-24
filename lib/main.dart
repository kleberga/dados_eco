import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dados_eco/providers/lista_series.dart';
import 'package:dados_eco/variables_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'TelaDados.dart';
import 'back_services.dart';
import 'configuracao.dart';
import 'database_helper.dart';
import 'home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<cadastroSeries> listaIBGE = [];
List<Metrica> listaMetrica = [];
List<NivelGeografico> listaNivelGeografico = [];
List<Localidades> listaLocalidades = [];
List<Categorias> listaCategorias = [];
var listaCombinada;


void main() async {
  // inicializar uma instancia de WidgetsFlutterBinding. In the Flutter framework,
  // the WidgetsFlutterBinding class plays a crucial role. It is responsible for
  // the application's lifecycle, handling input gestures, and triggering the build
  // and layout of widgets. It also manages the widget tree, a hierarchy of widgets
  // that Flutter uses to choose which widgets to render and how to render them.
  // The WidgetsFlutterBinding class also interacts with the native code of the
  // platform it's running on.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var db = FirebaseFirestore.instance;

  List<cadastroSeries> listaDados = [
  cadastroSeries("100001",
      'IPCA',
      'Índice Nacional de Preços ao Consumidor (INPC)',
      'O INPC tem por objetivo a correção do poder de compra dos salários, através da mensuração das variações de preços da cesta de consumo da população assalariada com mais baixo rendimento. Atualmente, a população-objetivo do INPC abrange as famílias com rendimentos de 1 a 5 salários mínimos, cuja pessoa de referência é assalariada, residentes nas regiões metropolitanas de Belém, Fortaleza, Recife, Salvador, Belo Horizonte, Vitória, Rio de Janeiro, São Paulo, Curitiba, Porto Alegre, além do Distrito Federal e dos municípios de Goiânia, Campo Grande, Rio Branco, São Luís e Aracaju.',
      '%',
      'IBGE',
      'https://servicodados.ibge.gov.br/api/v3/agregados/1736/periodos/all/variaveis/44?localidades=N1[1]',
      1,
      'mensal',
      'Variação mensal',
      'Brasil',
      'Brasil',
      'Índice geral'),
  cadastroSeries("100002",
  'INPC',
  'Índice Nacional de Preços ao Consumidor (INPC)',
  'O INPC tem por objetivo a correção do poder de compra dos salários, através da mensuração das variações de preços da cesta de consumo da população assalariada com mais baixo rendimento. Atualmente, a população-objetivo do INPC abrange as famílias com rendimentos de 1 a 5 salários mínimos, cuja pessoa de referência é assalariada, residentes nas regiões metropolitanas de Belém, Fortaleza, Recife, Salvador, Belo Horizonte, Vitória, Rio de Janeiro, São Paulo, Curitiba, Porto Alegre, além do Distrito Federal e dos municípios de Goiânia, Campo Grande, Rio Branco, São Luís e Aracaju.',
  '%',
  'IBGE',
  'https://servicodados.ibge.gov.br/api/v3/agregados/1736/periodos/all/variaveis/68?localidades=N1[1]',
  1,
  'mensal',
  'Variação acumulada no ano',
  'Brasil',
  'Brasil',
  'Índice geral'),
  cadastroSeries("100003",
  'IGP-M',
  'Índice Nacional de Preços ao Consumidor (INPC)',
  'O INPC tem por objetivo a correção do poder de compra dos salários, através da mensuração das variações de preços da cesta de consumo da população assalariada com mais baixo rendimento. Atualmente, a população-objetivo do INPC abrange as famílias com rendimentos de 1 a 5 salários mínimos, cuja pessoa de referência é assalariada, residentes nas regiões metropolitanas de Belém, Fortaleza, Recife, Salvador, Belo Horizonte, Vitória, Rio de Janeiro, São Paulo, Curitiba, Porto Alegre, além do Distrito Federal e dos municípios de Goiânia, Campo Grande, Rio Branco, São Luís e Aracaju.',
  '%',
  'IBGE',
  'https://servicodados.ibge.gov.br/api/v3/agregados/1736/periodos/all/variaveis/2292?localidades=N1[1]',
  1,
  'mensal',
  'Variação acumulada em 12 meses',
  'Brasil',
  'Brasil',
  'Índice geral')];

  // Create a new user with a first and last name
 /* for(var i in listaDados){
    final serie = <String, dynamic>{
      "numero": DateTime.now().toString().replaceAll(" ", "_").padRight(26, '0'),
      "nome": i.nome,
      "nomeCompleto": i.nomeCompleto,
      "descricao": i.descricao,
      "formato": i.formato,
      "fonte": i.fonte,
      "urlAPI": i.urlAPI,
      "idAssunto": i.idAssunto,
      "periodicidade": i.periodicidade,
      "metrica": i.metrica,
      "nivelGeografico": i.nivelGeografico,
      "localidades": i.localidades,
      "categoria": i.categoria
    };
    db.collection("indice_precos").add(serie);
  }*/


/*  db.collection('indice_precos')
      .where('idAssunto', isEqualTo: 1)
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(cadastroSeries(doc["nome"]));
        });
  });*/

/*var lista_de_dados = db.collection('indice_precos')
      .where('idAssunto', isEqualTo: 1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      listaEscolhida.add(cadastroSeries(doc["numero"], doc["nome"], doc["nomeCompleto"],
          doc["descricao"], doc["formato"], doc["fonte"], doc["urlAPI"], doc["idAssunto"],
          doc["periodicidade"], doc["metrica"], doc["nivelGeografico"], doc["localidades"],
          doc["categoria"]));
      print(listaEscolhida);
    });
  });
print(lista_de_dados);*/

/*  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };*/
/*  var now = DateTime.now();
  print(now);
  print(DateTime.now().toString().replaceAll(" ", "_"));*/

// Add a new document with a generated ID
/*  db.collection("users").add(user).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));*/

  NotificationService().initNotification();
  await Permission.notification.isDenied.then(
        (value){
      if(value){
        Permission.notification.request();
      }
    },
  );

 /* Future<String> getJsonFromRestAPI(String url_serie) async {
    String url = url_serie;
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadDataIBGE() async {
    String jsonString = await getJsonFromRestAPI("https://servicodados.ibge.gov.br/api/v3/agregados/7063/metadados");
    final jsonResponse = json.decode(jsonString);
    for(var i = 0; i<jsonResponse['variaveis'].length; i++){
      listaMetrica.add(Metrica(id: jsonResponse['variaveis'][i]['id'], nome: jsonResponse['variaveis'][i]['nome']));
    }
    var urlSerie2 = jsonResponse['nivelTerritorial']['Administrativo'];
    urlSerie2 = urlSerie2.join("|");

    for(var i = 0; i<jsonResponse['classificacoes'][0]['categorias'].length; i++) {
      listaCategorias.add(Categorias(id: jsonResponse['classificacoes'][0]['categorias'][i]['id'],
          nome: jsonResponse['classificacoes'][0]['categorias'][i]['nome']));
    }

    String jsonString2 = await getJsonFromRestAPI("https://servicodados.ibge.gov.br/api/v3/agregados/7063/localidades/$urlSerie2");
    final jsonResponse2 = json.decode(jsonString2);
    // preencher a lista de nivel geografico
    for(var i = 0; i<jsonResponse2.length; i++){
      if(listaNivelGeografico.any((element) => element.id==jsonResponse2[i]['nivel']['id'])){
        continue;
      }
        listaNivelGeografico.add(NivelGeografico(id: jsonResponse2[i]['nivel']['id'], nome: jsonResponse2[i]['nivel']['nome']));
    }
    // preencher a lista de localidades
    for(var i = 0; i<jsonResponse2.length; i++){
      listaLocalidades.add(Localidades(id: int.parse(jsonResponse2[i]['id']), nome: jsonResponse2[i]['nome'], nivelGeografico: jsonResponse2[i]['nivel']['id']));
    }

    print(jsonResponse['variaveis'].firstWhere((e) => e['nome']=="INPC - Peso mensal")['id']);

  }




  loadDataIBGE();
  */

  isNotificationGranted = await Permission.notification.isGranted;

  runApp(
      ChangeNotifierProvider(
        create: (context) => ListaDeSeries(),
        child: MaterialApp(
          //home: Home(),
          home: Home(),
          debugShowCheckedModeBanner: false,
        ),
      )
);
}



