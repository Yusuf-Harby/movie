import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/core/constants/app_hive.dart';
import 'package:movie/core/utils/app_theme.dart';
import 'package:movie/feature/app_section/app_section.dart';
import 'package:movie/feature/details/view/screens/details_screen.dart';
import 'package:movie/feature/watch_list/cubit/watch_list_cubit.dart';
import 'package:movie/feature/watch_list/data/models/watch_list_item_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WatchListItemModelAdapter());
  await Hive.openBox<WatchListItemModel>(AppHive.watchListBox);
  runApp(const Movie());
}

class Movie extends StatelessWidget {
  const Movie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchListCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: App.routeName,
        routes: {
          App.routeName: (_) => const App(),
          DetailsScreen.routeName: (_) => const DetailsScreen(),
        },
      ),
    );
  }
}
