import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

class ListBloc extends Cubit<List<Entries>>{
  ListBloc(super.initialState);

  void updateList(List<Entries> list){
    emit(list);
  }

  void  clearList(){
    List<Entries> list = [];
    emit(list);
  }
}