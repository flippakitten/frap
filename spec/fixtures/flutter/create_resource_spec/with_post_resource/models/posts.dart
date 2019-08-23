class Posts {
  int _id;
  List<Post> _results = [];

  Posts.fromJson(Map<String, dynamic> parsedJson) {
    List<Post> temp = [];
    for (int i = 0; i < parsedJson['posts'].length; i++) {
      Post result = Post.fromJson(parsedJson['posts'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Post> get results => _results;
}

class Post {
  final String name;
  

  Post({
    this.name,
    
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      
    );
  }
}
