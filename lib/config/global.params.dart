import 'package:flutter/material.dart';
import 'package:health_connect/theme/light_color.dart';
class GlobalParams{
  static List<Map<String , dynamic>> menus =[
    {"title":"Home" , "icon":const Icon(Icons.home ,  color:LightColor.green) , "route":"/home"},
    {"title":"Appointments" , "icon":const Icon(Icons.calendar_month_outlined ,  color:LightColor.green) , "route":"/appointments"},
    {"title":"Medical Records" , "icon":const Icon(Icons.medical_information , color:LightColor.green) , "route":"/medical-records"},
    {"title":"Profile" , "icon":const Icon(Icons.person ,  color: LightColor.green) , "route":"/settings"},
    {"title":"Log out" , "icon":const Icon(Icons.logout ,  color:LightColor.green) , "route":"/login"}
  ];
}

const String api_url="http://10.0.2.2:8081/api/v1";