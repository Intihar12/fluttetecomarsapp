

class StoreExists {
  StoreExists({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  StoreExists.fromJson(Map<String, dynamic> json){
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
     this.id,
     this.name,
     this.logo,
     this.imageUrl,
     this.openingClosingTime,
     this.distance,
  });
   int? id;
   String? name;
   String? logo;
   String? imageUrl;
   String? openingClosingTime;
   int? distance;

  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    imageUrl = json['image_url'];
    openingClosingTime = json['opening_Closing_time'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['image_url'] = imageUrl;
    _data['opening_Closing_time'] = openingClosingTime;
    _data['distance'] = distance;
    return _data;
  }
}