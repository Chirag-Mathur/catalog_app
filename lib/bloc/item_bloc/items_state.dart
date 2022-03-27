import "../../models/item_model.dart";

abstract class ItemsState {}

class InitialItemsState extends ItemsState {
  InitialItemsState();
}

class FetchingItemsState extends ItemsState {
  FetchingItemsState();
}

class FetchedItemsState extends ItemsState {
  final List<ItemModel> items;
  FetchedItemsState(this.items);
}

