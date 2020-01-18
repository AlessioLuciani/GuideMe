import 'package:GuideMe/main.dart';
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
    int userIndex = userExists(_emailController.text);
    if (!_isLoginPage) {
      // Create a new account
      // User newUser = User(name: _nameController.text,surname: _surnameController.text,email: _emailController.text);
      if (_nameKey.currentState.validate() &&
          _surnameKey.currentState.validate() &&
          _emailKey.currentState.validate() &&
          _passwordKey.currentState.validate()) {
        createUserSession(
            0); // mock value, simply rename test test account at the first boot
        currentUser.name = _nameController.text;
        currentUser.surname = _surnameController.text;
        currentUser.email = _emailController.text;
        //addTempUser(newUser)) {
        //userIndex = userExists(_emailController.text);

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
      createUserSession(userIndex);
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
        child: Image.asset("assets/icon/logo_only_foreground.png"),
      ),
    );

    final name = Form(
        key: _nameKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: _nameController,
          validator: (value) =>
              _isLoginPage || value.isEmpty ? "Enter your name" : null,
          decoration: InputDecoration(
            hintText: 'Name',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(
                  width: isDarkTheme(context) ? 1 : 2,
                  color:
                      isDarkTheme(context) ? Colors.white : Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  width: 1,
                )),
          ),
        ));

    final surnname = Form(
        key: _surnameKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: _surnameController,
          validator: (value) =>
              _isLoginPage || value.isEmpty ? "Enter your last name" : null,
          decoration: InputDecoration(
            hintText: 'Last name',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(
                  width: isDarkTheme(context) ? 1 : 2,
                  color:
                      isDarkTheme(context) ? Colors.white : Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  width: 1,
                )),
          ),
        ));

    final email = Form(
        key: _emailKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          validator: (value) {
            String returnValue;
            if (value.isEmpty) {
              returnValue = "Enter an email";
            } else if (!_isLoginPage &&
                userExists(_emailController.text) >= 0) {
              returnValue = "An user already exists with the given email";
            }
            return returnValue;
          },
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(
                  width: isDarkTheme(context) ? 1 : 2,
                  color:
                      isDarkTheme(context) ? Colors.white : Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  width: 1,
                )),
          ),
        ));

    final password = Form(
        key: _passwordKey,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          validator: (value) {
            String returnValue;
            if (value.isEmpty) {
              returnValue = "Enter a password";
            }
            if (_isLoginPage && userExists(_emailController.text) < 0) {
              returnValue = "Provided data is not correct.";
            }
            return returnValue;
          },
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(
                  width: isDarkTheme(context) ? 1 : 2,
                  color:
                      isDarkTheme(context) ? Colors.white : Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  width: 1,
                )),
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
            ? Text("Login", style: TextStyle(color: Colors.white))
            : Text("Sign Up", style: TextStyle(color: Colors.white)),
      ),
    );

    final registerLabel = Align(
        alignment: FractionalOffset.bottomCenter,
        child: FlatButton(
          child: _isLoginPage
              ? Text(
                  'Create a new account',
                  style: TextStyle(
                      color: isDarkTheme(context)
                          ? Colors.white70
                          : Colors.black54),
                )
              : Text(
                  "Login",
                  style: TextStyle(
                      color:
                          isDarkTheme(context) ? Colors.white70 : Colors.black54),
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
        'Did you forget the password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      // Avoid the Scaffold to resize himself when
      resizeToAvoidBottomInset: false,

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
              //_isLoginPage ? forgotLabel : SizedBox(),
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
