abstract class AppConstant {
  static const String apiUrl =
      'http://ec2-54-146-222-175.compute-1.amazonaws.com/api/v1/';
  static const String tokenExpiredMessage =
      'Sesión expirada\nPor favor, volver a iniciar sesión';
  static const String successfulGet = 'GET realizada con exito';
  static const String successfulPost = 'POST realizada con exito';
  static const String successfulPatch = 'PATCH realizada con exito';
  static const String successfulDelete = 'DELETE realizada con exito';
  static const String connectionError = 'Error en la conexión';
  static const String error = 'Ha ocurrido un error';
  static const String noContent = 'No content';
  static const String noInternet = 'No hay conexión a internet';
  static const String noInternetDescription =
      'Verifique su conexión e intente de nuevo';
}
