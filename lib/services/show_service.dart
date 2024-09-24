// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:quadb/constants.dart';
import 'package:quadb/models/show_model.dart';

import '../provider/show_provider.dart';

class ShowService {
  static final Dio dio = Dio();

  static CancelToken? _cancelToken;

  static Future<void> getShows({required BuildContext context}) async {
    try {
      Provider.of<ShowProvider>(context, listen: false).setLoading(true);

      final Response response = await dio.get('$apiBaseUrl/search/shows?q=all');

      
      if (response.data is List) {
        
        List<ShowModel> shows = (response.data as List)
            .map((item) => ShowModel.fromJson(item))
            .toList();

        if (context.mounted) {
          Provider.of<ShowProvider>(context, listen: false)
              .setShows(shows); 
        }

        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(shows[0].image ?? ''),
        );

        if (context.mounted) {
          Provider.of<ShowProvider>(context, listen: false).setColor(
              paletteGenerator.dominantColor?.color ??
                  Colors.black); 
        }

        return; 
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('getShows error: $e');
    } finally {
      if (context.mounted) {
        Provider.of<ShowProvider>(context, listen: false).setLoading(false);
      }
    }
    return; 
  }

  static Future<void> searchShows(
      {required BuildContext context, required String query}) async {
    
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    try {
      Provider.of<ShowProvider>(context, listen: false).clearSearchResults();

      Provider.of<ShowProvider>(context, listen: false).setSearching(true);

      final Response response = await dio.get(
        '$apiBaseUrl/search/shows?q=$query',
        cancelToken: _cancelToken, 
      );

      
      if (response.data is List) {
        
        List<ShowModel> shows = (response.data as List)
            .map((item) => ShowModel.fromJson(item))
            .toList();

        if (context.mounted) {
          Provider.of<ShowProvider>(context, listen: false)
              .setSearchResults(shows);
        }

        return; 
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('searchShows error: $e');
    } finally {
      if (context.mounted) {
        Provider.of<ShowProvider>(context, listen: false).setSearching(false);
      }
    }
    return; 
  }
}
