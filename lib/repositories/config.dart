import 'dart:convert';

const String scheme = 'http';
const String host = '10.0.2.2';
const int port = 8000;
const Map<String, String> headers= {'Content-Type': 'application/json'};
final Encoding? encoding= Encoding.getByName("utf-8");