import 'package:flutter_test/flutter_test.dart';

import 'package:post_explorer/data/models/post.dart';
import 'package:post_explorer/data/models/comment.dart';
import 'package:post_explorer/data/models/user.dart';
import 'package:post_explorer/presentation/state/post_state.dart';

import 'support/fake_post_repository.dart';

void main() {
  group('Post model tests', () {
    test('Post is correctly created from JSON', () {
      final post = Post.fromJson({
        'userId': 1,
        'id': 10,
        'title': 'Test title',
        'body': 'Test body',
      });

      expect(post.id, 10);
      expect(post.userId, 1);
      expect(post.title, 'Test title');
      expect(post.body, 'Test body');
    });

    test('Post is correctly converted to JSON', () {
      const post = Post(
        userId: 2,
        id: 20,
        title: 'Flutter',
        body: 'Testing application',
      );

      final json = post.toJson();

      expect(json['userId'], 2);
      expect(json['id'], 20);
      expect(json['title'], 'Flutter');
      expect(json['body'], 'Testing application');
    });
  });

  group('Comment model tests', () {
    test('Comment is correctly created from JSON', () {
      final comment = Comment.fromJson({
        'postId': 1,
        'id': 5,
        'name': 'Test comment',
        'email': 'test@example.com',
        'body': 'Comment body',
      });

      expect(comment.postId, 1);
      expect(comment.id, 5);
      expect(comment.name, 'Test comment');
      expect(comment.email, 'test@example.com');
      expect(comment.body, 'Comment body');
    });
  });

  group('User model tests', () {
    test('User is correctly created from JSON', () {
      final user = User.fromJson({
        'id': 1,
        'name': 'Test User',
        'username': 'testuser',
        'email': 'test@example.com',
        'phone': '123456',
        'website': 'example.com',
        'address': {
          'street': 'Main Street',
          'suite': 'Apt. 1',
          'city': 'Almaty',
          'zipcode': '050000',
          'geo': {'lat': '43.2389', 'lng': '76.8897'},
        },
        'company': {
          'name': 'Test Company',
          'catchPhrase': 'Test phrase',
          'bs': 'Test business',
        },
      });

      expect(user.id, 1);
      expect(user.name, 'Test User');
      expect(user.username, 'testuser');
      expect(user.email, 'test@example.com');
    });
  });

  group('PostState tests', () {
    test('Search filters posts by title', () async {
      final repository = FakePostRepository();
      final state = PostState(repository: repository);

      await state.loadPosts();
      state.search('Flutter');

      expect(state.filteredPosts.length, 1);
      expect(state.filteredPosts.first.title, 'Flutter Testing');
    });
  });
}
