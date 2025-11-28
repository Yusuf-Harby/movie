import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/core/constants/app_strings.dart';
import 'package:movie/core/dialogs/app_toasts.dart';
import 'package:movie/feature/home/view/screens/details_screen.dart';
import 'package:movie/feature/search/cubit/search_cubit.dart';
import 'package:movie/feature/search/data/models/search_result_model.dart';
import 'package:movie/feature/search/view/widgets/search_empty.dart';
import 'package:movie/feature/search/view/widgets/search_input.dart';
import 'package:movie/feature/search/view/widgets/search_item_widget.dart';
import 'package:movie/feature/search/view/widgets/search_loading.dart';
import 'package:toastification/toastification.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  late SearchCubit searchCubit;
  List<Results> searchList = [];

  @override
  void initState() {
    searchCubit = SearchCubit();
    super.initState();
    searchController = TextEditingController();
  }

  String query = "";
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.search)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            CustomTextForm(
              controller: searchController,
              hintText: "Search",
              onPressed: () {
                query = searchController.text;
                searchCubit.search(query);
              },
              onFieldSubmitted: (p0) {
                query = p0;
                searchCubit.search(query);
              },
              onChanged: (p0) {
                query = p0;
                searchCubit.search(query);
              },
            ),
            SizedBox(height: 20),

            BlocBuilder<SearchCubit, SearchState>(
              bloc: searchCubit,
              builder: (context, state) {
                if (state is SearchCubitLoaded) {
                  final List<Results> data = state.data ?? [];
                  if (data.isEmpty || query == "") {
                    return const EmptySearch();
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return SearchWidgetItem(
                          totalItemonTap: () {
                            Navigator.of(context).pushNamed(
                              DetailsScreen.routeName,
                              arguments: state.data?[index].id,
                            );
                          },
                          imagePath: state.data?[index].posterPath,
                          movieDescrption: state.data?[index].title,
                          movieRate: state.data?[index].voteAverage,
                          totalRate: state.data?[index].voteCount,
                          movieDate: state.data?[index].releaseDate,
                          movieType: state.data?[index].title,
                        );
                      },
                    ),
                  );
                }
                if (state is SearchCubitError) {
                  AppToast.showToast(
                    context: context,
                    title: "Error",
                    description: state.message ?? "",
                    type: ToastificationType.error,
                  );
                  return Text(state.message ?? "");
                }
                if (state is SearchCubitLoading) {
                  return SearchLoadingIndecator();
                }

                return const EmptySearch();
              },
            ),
          ],
        ),
      ),
    );
  }
}
