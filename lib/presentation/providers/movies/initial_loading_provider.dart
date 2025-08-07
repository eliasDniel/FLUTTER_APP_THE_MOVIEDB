import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMovieProvider).isEmpty;
  final step2 = ref.watch(moviesPopularProvider).isEmpty;
  final step3 = ref.watch(moviesUpcomingProvider).isEmpty;
  final step4 = ref.watch(moviesTopRatedProvider).isEmpty;
  if (step1 || step2 || step3 || step4) return true; // Initial loading state is true if any of the providers are empty
  return false; // Initial loading state is set to false by default
});
