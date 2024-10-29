import 'dart:developer';
import 'package:bloc_project/repo/project_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemModel {
  final int id;
  final String name;

  ItemModel({required this.id, required this.name});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['title'] ?? 'Unnamed Item',
    );
  }
}

abstract class ItemEvent {}

class FetchItems extends ItemEvent {}

class FetchMoreItems extends ItemEvent {}

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<ItemModel> items;
  final bool hasReachedMax;

  ItemLoaded({required this.items, this.hasReachedMax = false});
}

class ItemError extends ItemState {
  final String message;
  ItemError({required this.message});
}

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ProductRepo productRepo;
  int page = 1;
  final int limit = 20;
  bool isFetching = false;

  ItemBloc(this.productRepo) : super(ItemInitial()) {
    on<FetchItems>(_onFetchItems);
    on<FetchMoreItems>(_onFetchMoreItems);
  }

  void _onFetchItems(FetchItems event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    try {
      page = 1;
      final items = await productRepo.fetchItems(page: page, limit: limit);
      debugger();
      print(items);
      emit(ItemLoaded(items: items, hasReachedMax: items.length < limit));
    } catch (e) {
      emit(ItemError(message: e.toString()));
    }
  }

  void _onFetchMoreItems(FetchMoreItems event, Emitter<ItemState> emit) async {
    if (state is ItemLoaded &&
        !(state as ItemLoaded).hasReachedMax &&
        !isFetching) {
      isFetching = true;
      page += 1;
      try {
        final currentState = state as ItemLoaded;
        final items = await productRepo.fetchItems(page: page, limit: limit);
        emit(ItemLoaded(
          items: currentState.items + items,
          hasReachedMax: items.length < limit,
        ));
      } catch (e) {
        emit(ItemError(message: e.toString()));
      } finally {
        isFetching = false;
      }
    }
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemBloc>().add(FetchItems());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ItemBloc>().add(FetchMoreItems());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paginated List")),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ItemLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final item = state.items[index];
                return ListTile(title: Text(item.name.toString()));
              },
            );
          } else if (state is ItemError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
