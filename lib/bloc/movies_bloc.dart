import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/data.dart';

class MoviesBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<List<Result>> _subject =
      BehaviorSubject<List<Result>>();

  fetchAllMovies(String sort) async {
    List<Result> itemModel = await _repository.fetchAllMovies(sort);
    _subject.sink.add(itemModel);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Result>> get subject => _subject;
}

final bloc = MoviesBloc();
