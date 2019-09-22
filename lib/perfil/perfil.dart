import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import '../common/modal.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PerfilPage extends StatefulWidget {
  String id, nome, email, imagem;
  PerfilPage(this.id, this.nome, this.email, this.imagem);
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nome, email, imagem;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  TextEditingController controllerNome = new TextEditingController();
  TextEditingController controllerSenha = new TextEditingController();
  TextEditingController controllerConfirmarSenha = new TextEditingController();
  String novoNome = '';
  String novaSenha = '';
  String confirmarSenha = '';
  Modal m = new Modal();

  MemoryImage base64ToImage(String img) {
    return MemoryImage(base64Decode(img));
  }

  mensagem(String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(msg, style: estiloMensagem),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  mensagemErro(String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(msg, style: estiloMensagem),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  salvarUsuario() async {
    final pref = await SharedPreferences.getInstance();
    List<String> tempInfoUsuario = pref.getStringList('usuario');
    tempInfoUsuario[1] = novoNome;
    pref.setStringList('usuario', tempInfoUsuario);
  }

  

  atualizarCampos() async {
    if (novaSenha.isEmpty || confirmarSenha.isEmpty) {
      print(novoNome);
      print(widget.nome);
      if(controllerNome.text == widget.nome){
        mensagemErro('Você não fez alterações!');
      }else{
        var res = await http.post(
        Uri.parse("${Usuario.urlBase}atualizarDados.php"),
        body: {
          "usuario": Usuario.id.toString(),
          "nome": novoNome,
          },
        headers: {"Accept": "application/json"});

        var obj = json.decode(res.body);
        print(obj);

        if(obj == true){
          salvarUsuario();
          mensagem('Informações alteradas');
        }else{
          mensagemErro('Oops! Algo deu errado');
        }
      }
      
    }else{
      if (novaSenha == confirmarSenha) {
      var res = await http.post(
        Uri.parse("${Usuario.urlBase}atualizarSenha.php"),
        body: {
          "usuario": Usuario.id.toString(),
          "senha": novaSenha,
          },
        headers: {"Accept": "application/json"});

        var obj = json.decode(res.body);
        print(obj);

        if(obj == true){
          salvarUsuario();
          mensagem('Informações alteradas');
        }else{
          mensagemErro('Oops! Algo deu errado');
        }
    } else {
      mensagemErro("Senhas não são iguais");
    }
    }
    
  }

  buscarUsuario() async {
    final pref = await SharedPreferences.getInstance();

    List<String> usuario = pref.getStringList("usuario");

    setState(() {
      nome = usuario[1];
      imagem = usuario[2];
      email = usuario[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: CoresDoProjeto.principal,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: CoresDoProjeto.principal,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      border: Border.all(width: 3.0, color: Colors.purple),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: base64ToImage(widget.imagem)))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text(
                widget.nome,
                style: TextStyle(
                    fontFamily: "Montserrat-Medium",
                    color: Colors.white,
                    fontSize: 18.0),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.envelope,
                color: Colors.white,
              ),
              title: Text(widget.email,
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(

              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: controllerNome,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                onChanged: ((str) {
                  setState(() {
                    novoNome = str;
                  });
                }),
                decoration: InputDecoration(
                    hintText: "Nome",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                onChanged: ((str) {
                  setState(() {
                    novaSenha = str;
                  });
                }),
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                onChanged: ((str) {
                  setState(() {
                    confirmarSenha = str;
                  });
                }),
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirmar senha",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              child: Container(
                width: 150.0,
                height: 45.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      //Color(0xFF17ead9),
                      //Color(0xFF6078ea)
                      Colors.white,
                      Colors.white,
                    ]),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6078ea).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => atualizarCampos(),
                    child: Center(
                      child: Text("SALVAR",
                          style: TextStyle(
                            color: CoresDoProjeto.principal,
                            fontFamily: "Poppins-Medium",
                            fontSize: 16,
                            //letterSpacing: 1.0
                          )),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNome.text = widget.nome;
  }
}
