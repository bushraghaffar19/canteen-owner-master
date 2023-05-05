class CategoryModel{
  static const cateName = "category_name";
  static const cateId = "category_id";
  String? categoryName;
  String? categoryId;
  CategoryModel({
    this.categoryName,
    this.categoryId,
  });

  CategoryModel.fromMap(Map<String, dynamic> data){
    categoryName = data[cateName];
    categoryId = data[cateId];
  }
  toJson() {
    return {
      cateId:categoryId,
      cateName:categoryName,
    };
  }
}