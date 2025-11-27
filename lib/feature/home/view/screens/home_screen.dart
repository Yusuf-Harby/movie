import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/app_strings.dart';
import 'package:movie/core/dialogs/app_toasts.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';
import 'package:movie/feature/home/cubit/realse_movie_cubit/release_movie_cubit.dart';
import 'package:movie/feature/home/cubit/recommended_movie_cubit/recommended_movie_cubit.dart';
import 'package:movie/feature/home/view/screens/details_screen.dart';
import 'package:movie/feature/home/view/widgets/popular_movie_card.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ReleaseMovieCubit releaseCubit;
  late final RecommendedMovieCubit recommndedCubit;

  @override
  void initState() {
    super.initState();
    releaseCubit = ReleaseMovieCubit();
    releaseCubit.getReleasesMovies();
    recommndedCubit = RecommendedMovieCubit();
    recommndedCubit.getRecommendedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.home)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Realise movies",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10),

              BlocBuilder<ReleaseMovieCubit, ReleaseMovieState>(
                bloc: releaseCubit,
                builder: (context, state) {
                  if (state is ReleaseMovieSuccess) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ItemMovieWidget(
                            posterPath:
                                state.resultList?[index].posterPath ?? "",
                            onTap: () {
                              int id = state.resultList?[index].id ?? 0;
                              Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: id,
                              );
                            },
                          );
                        },
                        itemCount: state.resultList?.length ?? 0,
                      ),
                    );
                  } else if (state is ReleaseMovieError) {
                    AppToast.showToast(
                      context: context,
                      title: "Error",
                      description: state.message,
                      type: ToastificationType.error,
                    );
                    return Text(state.message);
                  } else {
                    return LoadingWidgetSkelton();
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                "Recomnded movies",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10),

              BlocBuilder<RecommendedMovieCubit, RecommendedMovieState>(
                bloc: recommndedCubit,
                builder: (context, state) {
                  if (state is RecommendedSuccess) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ItemMovieWidget(
                            posterPath:
                                state.resultList?[index].posterPath ?? "",
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: state.resultList?[index].id,
                              );
                            },
                          );
                        },
                        itemCount: state.resultList?.length ?? 0,
                      ),
                    );
                  } else if (state is RecommendedMovieError) {
                    AppToast.showToast(
                      context: context,
                      title: "Error",
                      description: state.message,
                      type: ToastificationType.error,
                    );
                    return Text(state.message);
                  } else {
                    return LoadingWidgetSkelton();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
