class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "Já existe uma conta com este email",
    "OPERATION_NOT_ALLOWED":
        "a entrada de senha está desativada para este projeto",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Bloqueamos todos os pedidos deste dispositivo devido a atividades incomuns. Tente mais tarde.",
    "EMAIL_NOT_FOUND": "Email não existe",
    "INVALID_EMAIL": "Digite um email válido",
    "INVALID_PASSWORD": "Senha Inválida",
    "USER_DISABLED": "Conta desativada",
    "NETWORK_ERROR": "Verifique sua conexão com a internet e tente novamente mais tarde",
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    if(errors.containsKey(key)){
      return errors[key];
    }else {
      return 'Ocorreu um erro,tente novamente mais tarde';
    }
  }
}
