import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/lib/model/season.dart';

class SeasonService {
  SeasonService();

  final SeasonRepository seasonRepository = SeasonRepository();

  Future<List<Season>> fetchSeasons() async {
    return await seasonRepository.fetchSeasons();
  }

  void sortSeasonListDescByYear(List<Season> seasons) => seasons.sort((a, b) => Comparable.compare(b.year, a.year));
}