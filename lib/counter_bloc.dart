import 'dart:convert';

import 'package:bloc_management/model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;

class CounterBloc extends Cubit<int>{
  CounterBloc(super.initialState);
  void increment()=> emit(state+1);
  void decrement()=> emit(state+1);
}

class CatBloc extends Cubit<DemoModel>{
  CatBloc(super.initialState);
  void updateModel(DemoModel model){
    emit(model);
    print(state.toJson().toString());
  }
}


class Controller{

   Future getData(BuildContext context)async{
     var uri = Uri.parse("https://api.publicapis.org/entries");
     var response =await http.get(uri);
     DemoModel model = DemoModel.fromJson(jsonDecode(response.body));
     print("hit");
     context.read<CatBloc>().emit(model);
   }

}
