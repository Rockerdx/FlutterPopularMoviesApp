import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/data.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<List<Result>>();

  Observable<List<Result>> get allMovies => _moviesFetcher.stream;

  fetchAllMovies(String sort) async {
    List<Result> itemModel = await _repository.fetchAllMovies(sort);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
