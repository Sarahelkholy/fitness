import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/features/popular_tarining/data/data_source/popular_training_data_source.dart';
import 'package:fitness/features/popular_tarining/domain/repo/popular_training_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PopularTrainingRepo)
class PopularTrainingRepoImpl implements PopularTrainingRepo {
  final PopularTrainingDataSource _popularTrainingDataSource;

  PopularTrainingRepoImpl(this._popularTrainingDataSource);

  @override
  Future<Result<List<String>>> getRandomPrimeMoverMuscles() {
    return _popularTrainingDataSource.getRandomPrimeMoverMuscles();
  }
}
