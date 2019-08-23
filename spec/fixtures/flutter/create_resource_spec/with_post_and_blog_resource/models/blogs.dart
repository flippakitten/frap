class Blogs {
  int _id;
  List<Blog> _results = [];

  Blogs.fromJson(Map<String, dynamic> parsedJson) {
    List<Blog> temp = [];
    for (int i = 0; i < parsedJson['blogs'].length; i++) {
      Blog result = Blog.fromJson(parsedJson['blogs'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Blog> get results => _results;
}

class Blog {
  final String name;
  final int age;
  

  Blog({
    this.name,
    this.age,
    
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      name: json['name'],
      age: json['age'],
      
    );
  }
}
