import 'package:flutter/material.dart';
import 'package:preferencias/src/share_prefes/preferencias_usuario.dart';
import 'package:preferencias/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late bool _colorSsecundario;
  late int _genero;
  String _nombre = 'Pedro';

  late TextEditingController _textController; 
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
   // cargarPref();

    prefs.ultimaPagina = SettingsPage.routeName;

    _genero = prefs.genero;
    _colorSsecundario = prefs.colorSecundario;
    _textController = new TextEditingController(text: prefs.nombreUsuario);

  }

  /* cargarPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _genero = prefs.getInt('genero');
    setState(() {
      
    });
  } */

  _setSelectedRadio(dynamic valor){

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt('genero', valor);
    prefs.genero = valor;
    _genero = valor;
    setState(() {
      
    });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
        centerTitle: true,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),),
          ),

          Divider(),

          SwitchListTile(
            value: _colorSsecundario,
            title: Text('Color secundario'),
            onChanged: (value){
              setState(() {
                _colorSsecundario = value;
                prefs.colorSecundario = value;
              });
            },
          ),

          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono',
              ),
              onChanged: (value){
                prefs.nombreUsuario = value;
              },
            ),
          )

        ],
      ),
    );
  }
}