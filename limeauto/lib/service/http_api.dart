
class HttpApi{
  static const String categories = '/api/blogging/categories';
  static const String posts = '/api/blogging/posts';
  static const String banner = '/api/site/entities?sectionId=1a125e72-bcdd-3ff7-01af-39f9441d313d&maxResultCount=5&skipCount=0';
  static const String headlines = '/api/site/entities?sectionId=152aca34-fd4d-a9e0-4ff8-39f945144ab4&maxResultCount=1&skipCount=0';
  static const String recommendedReading = '/api/site/entities/channel/28e69a54-c7e0-0dbc-39d7-39f21b8dd6bc';
  static const String popularTags = '/api/blogging/tags/PopularTags';
  static const String tagsFind = '/api/blogging/tags/find/';
  static const String postsByTag = '/api/blogging/posts/byTag';
  static const String readRanking = '/api/blogging/posts/ReadRanking';

  static const String addComments = '/api/blogging/comments';
  static const String getComments = '/api/blogging/comments/';
  static const String deleteComments = '/api/blogging/comments/';

  static const String adminPosts = '/api/blogging/admin/posts';


  static const String multiples = '/api/blogging/posts/multiples';
  static const String search = '/api/blogging/posts/search';
  static const String article = '/api/blogging/posts/';
  static const String like = '/api/blogging/posts/like/';
  static const String blog = '/api/blogging/blogs/';
  static const String blogs = '/api/blogging/blogs';
  static const String postsByBlog = '/api/blogging/posts/byBlog/';

}