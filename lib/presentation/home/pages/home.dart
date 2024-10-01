import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/widget/appbar/basic_appbar.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/presentation/home/widgets/news_song.dart';
import 'package:music_app/presentation/home/widgets/playlist.dart';

import '../../../core/configs/theme/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppVectors.logo,width: 40,height: 40,),
        hideBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _homeTopCard(),
              _tabs(),
              SizedBox(
                height: 260,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const NewsSongs(),
                    Container(child: const Text("1"),),
                    Container(child: const Text("2"),),
                    Container(child: const Text("3"),),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Playlists",style: TextStyle(fontWeight: FontWeight.bold,color: context.isDarkMode ? Colors.white :Colors.black,fontSize: 20),),
                        const Text("See more",style: TextStyle(color: AppColors.grey,fontSize: 12),)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const PlayLists()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 128,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Image.asset(AppImages.homeArtist)))
          ],
        ),
      ),
    );
  }
  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      dividerHeight: 0,
      padding: const EdgeInsets.symmetric(
          vertical: 20,
          // horizontal: 16
      ),
      tabs: const [
        Text(
          'News',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        )
      ],
    );
  }
}


