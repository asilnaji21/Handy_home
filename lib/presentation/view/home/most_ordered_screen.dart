import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

import '../../../bussiness logic/homeCubit/home_cubit.dart';
import 'HomeComponents/single_service_widget.dart';

class MostOrderedScreen extends StatefulWidget {
  const MostOrderedScreen(
      {
      required this.name,

      Key? key})
      : super(key: key);
  final String name;

  @override
  State<MostOrderedScreen> createState() => _MostOrderedScreenState();
}

class _MostOrderedScreenState extends State<MostOrderedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LatestServiceCubit>().latestAddedService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 30, right: 30),
        child: BlocBuilder<LatestServiceCubit, LatestServiceAddedInitialState>(
          builder: (context, state) {
            if (state is LatestServiceAddedLoadingState) {
              return const CircularLoadingWidget();
            } else if (state is LatestServiceAddedSuccessState) {
              return Column(
                children: [
                   CustomHeaderWidget(title: widget.name),
                  const SizedBox(
                    height: 16,
                  ),
                  // const SearchCustomWidget(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.services.length,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamed(
                                RouteConstants.serviceDetailsRoute,
                                arguments: state.services[index].detail);
                          },
                          child: SingleServiceWidget(
                            width: double.infinity,
                            imageHeight: 180,
                            image: state.services[index].image,
                            price:
                                '${state.services[index].priceFrom} - ${state.services[index].priceTo}',
                            serviceName: state.services[index].name,
                            loadingPlaceholder: Container(
                              height: 180,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            height: 50, width: 50, child: CircularProgressIndicator()));
  }
}

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorManager.brownColor,
                  )),
            )),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: StyleManger.headline1(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class CardForIconWidget extends StatelessWidget {
  const CardForIconWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
          onPressed: () {
            NavigationManager.pop();
          },
          icon: icon),
    );
  }
}
