import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb/presentation/widgets/show_tile.dart';
import 'package:quadb/presentation/widgets/top_show_tile.dart';

import '../../provider/show_provider.dart';
import '../../services/show_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowService.getShows(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ShowProvider>(
        builder: (context, showProvider, child) {
         
          if (showProvider.loading) {
            return Container(
              color: Colors.black, 
              child: Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator(
                        animating: true,
                        color: Colors.white,
                      )
                    : const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ), //
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: showProvider.loading
                  ? null
                  : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        showProvider.color, 

                        Colors.black, 
                      ],
                    ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'For you',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.grey, 
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/profile_pic.jpg'), 
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                  floating: true,
                  backgroundColor:
                      Colors.transparent, 
                ),
                
                if (showProvider.shows.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No shows available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else ...[
                  
                  SliverToBoxAdapter(
                    child: TopShowTile(show: showProvider.shows[0]),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        'Popular Shows',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: showProvider.shows.length > 1
                            ? showProvider.shows.length - 1
                            : 0,
                        itemBuilder: (context, index) {
                          final show =
                              showProvider.shows[index + 1];
                          return ShowTile(show: show);
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        'Popular Shows',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: showProvider.shows.length > 1
                            ? showProvider.shows.length - 1
                            : 0,
                        itemBuilder: (context, index) {
                          final show = showProvider.shows[
                              showProvider.shows.length - 1 - index]; 
                          return ShowTile(show: show);
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 2 * kTextTabBarHeight),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
