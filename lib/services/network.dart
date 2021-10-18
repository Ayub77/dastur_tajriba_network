
import 'dart:convert';

import 'package:dastur_tajriba_network/model/emplist_model.dart';
import 'package:http/http.dart';

class Network{


   static String Base = 'dummy.restapiexample.com';
   static Map<String,String> headers = {'Coutent-Type':'application/json; charset=UTF-8'};
   
   
   
   //http api
   static String API_LIST = "/api/v1/employees";


   static Future<String> GET(String api, Map<String, String> params)async{

      var uri = Uri.http(Base,api,params);

      var response = await get(uri,headers: headers);

      if(response.statusCode==200){
        return response.body;
      }
      return "";

   } 


   static Map<String, String> EmptyParams(){
     Map<String, String> params = new Map();

     return params;
   }


   static EmpList parseEmplist(String body){

     dynamic json = jsonDecode(body);
     var data = EmpList.fromJson(json);
     return data;

   }
  
    
}