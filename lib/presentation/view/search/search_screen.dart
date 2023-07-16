import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/searchCubit/search_cubit.dart';
import 'dart:async';
import 'package:skeletons/skeletons.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/search_custom_widget.dart';
import '../../resources/style_manager.dart';
import '../home/HomeComponents/single_service_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().services();
  }

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'البحث',
                  style: StyleManger.headline1(),
                ),
                const SizedBox(
                  height: 16,
                ),
                SearchCustomWidget(
                  searchController: searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      context.read<SearchCubit>().services(searchValue: value);
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  searchController.text.isEmpty
                      ? 'اقتراحات سريعة'
                      : 'نتائج البحث',
                  style: StyleManger.headline1(fontSize: 18),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (state is SearchLoadingState) {
                        return SkeletonItem(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      } else if (state is SearchSuccessState) {
                        if (state.services.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد خدمات',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamed(
                                RouteConstants.serviceDetailsRoute,
                                arguments: state.services[index].detail);
                          },
                          child: SingleServiceWidget(
                            width: 140,
                            imageHeight: 90,
                            image: state.services[index].image,
                            loadingPlaceholder: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            price:
                                '${state.services[index].priceFrom}-${state.services[index].priceTo}',
                            serviceName: state.services[index].name,
                          ),
                        );
                      } else {
                        return const Text('something went wrong');
                      }
                    },
                    itemCount: state is SearchSuccessState
                        ? state.services.isEmpty
                            ? 1
                            : state.services.length
                        : state is SearchLoadingState
                            ? 10
                            : 1,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
