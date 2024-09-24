import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb/constants.dart';
import 'package:quadb/presentation/widgets/show_tile.dart';
import '../../provider/show_provider.dart';
import '../../services/show_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ShowProvider>(
        builder: (context, showProvider, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                pinned: true,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'search',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: primaryGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 24),
                          suffixIcon: searchController.text.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.white), 
                                  onPressed: () {
                                    searchController
                                        .clear(); 
                                    showProvider
                                        .clearSearchResults(); 
                                  },
                                ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ShowService.searchShows(
                                context: context, query: value);
                          } else {
                            showProvider.clearSearchResults();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                floating: true,
                backgroundColor: Colors.black.withOpacity(0.9),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    
                    if (index < showProvider.searchResults.length) {
                      return ShowTile(show: showProvider.searchResults[index]);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  childCount: showProvider.searchResults.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 2 * kTextTabBarHeight),
              ),
            ],
          );
        },
      ),
    );
  }
}
