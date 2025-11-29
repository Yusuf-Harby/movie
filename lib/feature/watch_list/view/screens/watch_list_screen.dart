import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/app_strings.dart';
import 'package:movie/feature/watch_list/cubit/watch_list_cubit.dart';
import 'package:movie/feature/watch_list/cubit/watch_list_state.dart';
import 'package:movie/feature/watch_list/view/widgets/watch_list_empty.dart';
import 'package:movie/feature/watch_list/view/widgets/watch_list_item.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.watchList)),
      body: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (state is WatchListError && state.items.isEmpty) {
            return Center(
              child: Text(state.message, textAlign: TextAlign.center),
            );
          }
          final items = state.items;
          if (items.isEmpty) {
            return const WatchListEmpty();
          }
          final listView = ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return WatchListItem(
                item: item,
                onRemove: () =>
                    context.read<WatchListCubit>().removeMovie(item.id),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: items.length,
          );
          if (state is WatchListLoading) {
            return Stack(
              children: [
                listView,
                const Positioned.fill(
                  child: IgnorePointer(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            );
          }
          if (state is WatchListError) {
            return Stack(
              children: [
                listView,
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            );
          }
          return listView;
        },
      ),
    );
  }
}
