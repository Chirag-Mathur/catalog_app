import 'package:catalog_app/bloc/item_bloc/items_event.dart';
import 'package:catalog_app/bloc/item_bloc/items_state.dart';
import 'package:catalog_app/repository/api_repository.dart';

import '../../models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ApiRepository apiRepository;

  ItemsBloc(this.apiRepository):super(InitialItemsState()) {
    on<FetchAllItems>((event, emit) async{
      emit(FetchingItemsState());
      List<ItemModel> items = await apiRepository.getAllitems();
      items = await apiRepository.getAllitems();
      emit(FetchedItemsState(items));     
    });
  }

}
