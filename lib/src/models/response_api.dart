import 'dart:convert';

//  esta clase ResponseApi proporciona una estructura para manejar respuestas
// de API, incluyendo información sobre el éxito o fracaso de la solicitud,
//mensajes asociados y datos devueltos.
ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  bool? success;
  String? message;
  dynamic data;

  ResponseApi({this.success, this.message, this.data});

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
