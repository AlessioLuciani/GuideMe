import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/main.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  final _surnameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginPage = true;

  void _checkFields() {
    int userIndex = Utils.userExists(_emailController.text);
    if (!_isLoginPage) {
      // Create a new account
      User newUser = User(
          name: _nameController.text,
          surname: _surnameController.text,
          email: _emailController.text);
      if (_nameKey.currentState.validate() &&
          _surnameKey.currentState.validate() &&
          _emailKey.currentState.validate() &&
          _passwordKey.currentState.validate() &&
          Utils.addTempUser(newUser)) {
        Data.currentUserIndex = Utils.userExists(_emailController.text);
        Route route = MaterialPageRoute(builder: (context) => HomePage());
        Navigator.pushReplacement(context, route);
        // and go to the app
      }
      return;
    }
    // Login with your account
    if (_emailKey.currentState.validate() &&
        _passwordKey.currentState.validate() &&
        userIndex >= 0) {
      Data.currentUserIndex = userIndex;
      Route route = MaterialPageRoute(builder: (context) => HomePage());
      Navigator.pushReplacement(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("assets/icon/logo.png"),
      ),
    );

    final name = Form(
        key: _nameKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: _nameController,
          validator: (value) =>
              _isLoginPage || value.isEmpty ? "Inserisci nome" : null,
          decoration: InputDecoration(
            hintText: 'Nome',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final surnname = Form(
        key: _surnameKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: _surnameController,
          validator: (value) =>
              _isLoginPage || value.isEmpty ? "Inserisci cognome" : null,
          decoration: InputDecoration(
            hintText: 'Cognome',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final email = Form(
        key: _emailKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          validator: (value) {
            if (value.isEmpty) {
              return "Inserisci una email";
            } else if (!_isLoginPage &&
                Utils.userExists(_emailController.text) >= 0) {
              return "Utente già esistente";
            }
            return null;
          },
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final password = Form(
        key: _passwordKey,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return "Inserisci una password";
            }
            if (_isLoginPage && Utils.userExists(_emailController.text) < 0) {
              return "I dati inseriti non sono corretti.";
            }
            return null;
          },
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => _checkFields(),
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 36, right: 36),
        color: Colors.red,
        child: _isLoginPage
            ? Text("Effettua l'accesso", style: TextStyle(color: Colors.white))
            : Text("Crea account", style: TextStyle(color: Colors.white)),
      ),
    );

    final registerLabel = Align(
        alignment: FractionalOffset.bottomCenter,
        child: FlatButton(
          child: _isLoginPage
              ? Text(
                  'Crea un nuovo account',
                  style: TextStyle(color: Colors.black54),
                )
              : Text(
                  "Effettua l'accesso",
                  style: TextStyle(color: Colors.black54),
                ),
          onPressed: () => setState(() {
            _isLoginPage = !_isLoginPage;
            _nameController.clear();
            _surnameController.clear();
            _emailController.clear();
            _passwordController.clear();
          }),
        ));

    final forgotLabel = FlatButton(
      child: Text(
        'Hai dimenticato la password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      // Avoid the Scaffold to resize himself when
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 140),
          child: Column(
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              !_isLoginPage ? name : SizedBox(),
              !_isLoginPage ? SizedBox(height: 8.0) : SizedBox(),
              !_isLoginPage ? surnname : SizedBox(),
              SizedBox(height: 8.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              Row(
                children: <Widget>[Expanded(child: loginButton)],
              ),
              _isLoginPage ? forgotLabel : SizedBox(),
              Expanded(
                child: registerLabel,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
