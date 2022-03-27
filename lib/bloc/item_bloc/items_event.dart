import '../../models/item_model.dart';

abstract class ItemsEvent {}

class FetchAllItems extends ItemsEvent {
  FetchAllItems();
}

class AddItems extends ItemsEvent {
  final ItemModel item;

  AddItems(this.item);
}
