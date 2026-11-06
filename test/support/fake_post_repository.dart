import 'package:dio/dio.dart';

import 'package:post_explorer/data/local/post_cache.dart';
import 'package:post_explorer/data/models/comment.dart';
import 'package:post_explorer/data/models/post.dart';
import 'package:post_explorer/data/models/user.dart';
import 'package:post_explorer/data/remote/post_api.dart';
import 'package:post_explorer/data/repositories/post_repository.dart';

class FakePostRepository extends PostRepository {
  FakePostRepository() : super(api: PostApi(Dio()), cache: PostCache());

  final List<Post> testPosts = [
    const Post(
      userId: 1,
      id: 1,
      title: 'Flutter Testing',
      body: 'Learning how to test Flutter applications.',
    ),
    const Post(
      userId: 2,
      id: 2,
      title: 'Dart Programming',
      body: 'Learning Dart programming language.',
    ),
    const Post(
      userId: 1,
      id: 3,
      title: 'Mobile Development',
      body: 'Building applications with Flutter.',
    ),
  ];

  final List<User> testUsers = [
    const User(
      id: 1,
      name: 'Test User One',
      username: 'user1',
      email: 'user1@test.com',
      phone: '123456',
      website: 'test1.com',
    ),
    const User(
      id: 2,
      name: 'Test User Two',
      username: 'user2',
      email: 'user2@test.com',
      phone: '654321',
      website: 'test2.com',
    ),
  ];

  @override
  Future<List<Post>> getPosts({
    int page = 1,
    int limit = 10,
    int? userId,
  }) async {
    var result = testPosts;

    if (userId != null) {
      result = result.where((post) => post.userId == userId).toList();
    }

    final start = (page - 1) * limit;

    if (start >= result.length) return [];

    return result.skip(start).take(limit).toList();
  }

  @override
  Future<List<Post>> getCachedPosts() async => [];

  @override
  Future<List<User>> getUsers() async => testUsers;

  @override
  Future<void> saveCachedPosts(List<Post> posts) async {}

  @override
  Future<Post> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    return Post(userId: userId, id: 100, title: title, body: body);
  }

  @override
  Future<List<Comment>> getComments(int postId) async => [];
}
