import 'dart:convert';
import 'package:desafio_imc/model/imc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImcRepository {
  final List<IMC> imcs = [];

  final String _db = "db_imc";

  Future<List<IMC>> listar() async {
    //await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();

    String? json = prefs.getString(_db);
    List<dynamic> list = json != null ? jsonDecode(json) : [];

    return list.map((item) => IMC.fromJson(item)).toList();
  }

  Future<void> adicionar(IMC imc) async {
    final prefs = await SharedPreferences.getInstance();

    String? json = prefs.getString(_db);
    List<dynamic> list = json != null ? jsonDecode(json) : [];
    list.add(imc.toJson());
    await prefs.setString(_db, jsonEncode(list));
    // await Future.delayed(const Duration(seconds: 1));
    // imcs.add(imc);
  }
}
