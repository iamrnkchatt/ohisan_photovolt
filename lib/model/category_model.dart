class CategoryModel {
  List<Category> category = [];

  CategoryModel({required this.category});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String name = "";
  List<String> subcat = [];

  Category({required this.name, required this.subcat});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subcat = json['subcat'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subcat'] = this.subcat;
    return data;
  }
}
