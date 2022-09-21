
class SearchKeyword{
  SearchKeyword({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });
  String? responseCode;
  String? responseMessage;
  Response? response;
  List<String>? errors;

  SearchKeyword.fromJson(Map<String, dynamic> json){
    responseCode = json['ResponseCode'];
    responseMessage = json['ResponseMessage'];
    response = Response.fromJson(json['Response']);
    errors = List.castFrom<dynamic, String>(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ResponseCode'] = responseCode;
    _data['ResponseMessage'] = responseMessage;
    _data['Response'] = response!.toJson();
    _data['errors'] = errors;
    return _data;
  }
}

class Response {
  Response({
    this.keyWords,
  });
  List<Keywords>? keyWords;

  Response.fromJson(Map<String, dynamic> json){
    keyWords = List.from(json['kewords']).map((e)=>Keywords.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kewords'] = keyWords!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Keywords {
  Keywords({
    this.id,
    this.keyWord,
  });
  int? id;
  String? keyWord;


  Keywords.fromJson(Map<String, dynamic> json){
    id = json['id'];
    keyWord = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['keyword'] = keyWord;
    return _data;
  }
}