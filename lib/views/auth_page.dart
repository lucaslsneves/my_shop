import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formSignIn = GlobalKey<FormState>();
  final _formSignUp = GlobalKey<FormState>();
  final TextEditingController _signUpPasswordController = TextEditingController();
  final Map<String, String> _formData = {};
  bool _isSignInForm = true;
  bool _isLoading = false;



  Widget _getFormSignIn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Form(
            key: _formSignIn,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    validator: (String email) {
                      if (email.isEmpty) {
                        return 'Digite seu email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return 'Digite um email válido';
                      }
                      return null;
                    },
                    onSaved: (String email) {
                      _formData['email'] = email;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (String password) {
                      if (password.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                    onSaved: (String password) {
                      _formData['password'] = password;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
         _isLoading ? Container(height: 20,width: 20,child: CircularProgressIndicator()) :  RaisedButton(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.purple,
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'ENTRAR',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {
             
              if (_formSignIn.currentState.validate()) {
                _formSignIn.currentState.save();
                 setState(() {
                _isLoading = true;
              });
              
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text(
              'CADASTRE-SE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            onPressed: _isLoading ? null : () {
              setState(() {
                _isSignInForm = false;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _getFormSignUp() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Form(
            key: _formSignUp,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    validator: (String email) {
                      if (email.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return 'Digite um email válido';
                      }
                      return null;
                    },
                    onSaved: (String email) {
                      _formData['email'] = email;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _signUpPasswordController,
                    validator: (String password) {
                      if (password.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (String password) {
                      _formData['password'] = password;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    )),
                SizedBox(
                  height: 10,
                ),
                  TextFormField(
                    validator: (String confirmPassword) {
                      if (confirmPassword.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if(confirmPassword != _signUpPasswordController.text){
                        return 'As senhas não batem';
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
         _isLoading ? Container(height: 20,width: 20,child: CircularProgressIndicator()) :    RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.purple,
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(color: Colors.white),
                )),
           onPressed:() {
             
              if (_formSignUp.currentState.validate()) {
                _formSignUp.currentState.save();
                 setState(() {
                _isLoading = true;
              });
              
            }
           }),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text(
              'VOLTAR',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            onPressed: _isLoading ? null : () {
              setState(() {
                _isSignInForm = true;
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.pink])),
        ),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'MyShop',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      elevation: 5,
                      child:
                          _isSignInForm ? _getFormSignIn() : _getFormSignUp()),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
