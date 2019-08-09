import 'package:rxdart/rxdart.dart';
import 'package:frap_test_suite_app_ui/src/resources/repository.dart';
import 'package:frap_test_suite_app_ui/src/models/posts.dart';

class PostsBloc {
  final _repository = Repository();
  final _postsFetcher = PublishSubject<Posts>();

  Observable<Posts> get allPosts => _postsFetcher.stream;

  fetchAllPosts() async {
    Posts posts = await _repository.fetchAllPosts();
    _postsFetcher.sink.add(posts);
  }

  dispose() {
    _postsFetcher.close();
  }
}

final bloc = PostsBloc();