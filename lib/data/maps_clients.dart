



import 'package:get/get.dart';
import 'dart:io';
import 'constants/constants.dart';
import 'model/map_search_models/geomery_latlng/geomatry_latlng.dart';
import 'model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'model/map_search_models/map_search/map_search.dart';


class MapClient extends GetConnect {
  static const _address =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  static const _epAutocomplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static const _epDetails = "https://maps.googleapis.com/maps/api/place/details/json";
// parameters
  static const _key = 'AIzaSyDYemrIWj0xMxdjONCcD5W4lDj2zxKzLx8';
  static const _pfields = 'fields';
  static const _pKey = 'key';
  static const _pLanguage = 'language';
  static const _pQuery = 'input';
  static const _pPlaceid = 'place_id';
  static const _pOrigin = 'origin';
  static const _pDestination = 'destination';

  Future<MapSearchModel> getPlaces(String str) async {
    final response = await get(
      _epAutocomplete,
      query: {
        'input': str,
        'key': Constants.mapKey,
        'language': 'en',
        'types':'postal_code',
        "components": "country:${Constants().mapsearch}"
      },
    );
    if (response.statusCode == 200) {
      MapSearchModel model = MapSearchModel.fromJson(response.body);

      model.predictions = model.predictions.reversed.toList();

      return model;

    }
    throw (response.statusText!);
  }


  Future<AutoComplete> getPlacesOnMap(String str) async {
    final response = await get(
      _epAutocomplete,
      query: {
        _pQuery: str,
        _pKey: Constants.mapKey,
        _pLanguage: 'en'
      },
    );
    print(response.toString());
    if (response.statusCode==200) {
      print(response.body);
      return AutoComplete.fromJson(response.body);

    }
    throw (response.statusText ?? "Exception");
  }



  Future<IdtoLatLong> getPlacesLatLong(String str) async {
    final response = await get(
      _epDetails,
      query: {
        'place_id': str,
        'key': Constants.mapKey,
        'fields': 'geometry'
      },
    );
    if (response.statusCode == 200) {
      return IdtoLatLong.fromJson(response.body);
    }
    throw (response.statusText!);
  }


  Future<AutoComplete> getPlaces1(String str,
      {String? key, String? language}) async {
    final response = await get(
      _epAutocomplete,
      query: {_pQuery: str, _pKey: _key, _pLanguage: 'en'},
    );
    if (response.statusCode == 200) {
      return AutoComplete.fromJson(response.body);
    }
    throw (response.statusText!);
  }

  Future<GeomatryLatLng> getPlacesLatLong1(String str,
      {String? key, String? language}) async {
    final response = await get(
      _epDetails,
      query: {_pPlaceid: str, _pKey: _key, _pfields: 'geometry'},
    );
    if (response.statusCode == 200) {
      return GeomatryLatLng.fromJson(response.body);
    }
    throw (response.body);
  }

}