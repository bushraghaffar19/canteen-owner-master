class ProductModel{
  static const prodName = "product_name";
  static const prodId = "product_id";
  static const prodImage = "product_Image";
  static const prodPrice = "product_price";
  static const cateId = "category_id";
  static const prodDescription = "product_description";
  static const prodIsStock = "is_stock";


  String? name,image,id,description,categoryId;
  double? price;
  bool? isProductAvailable;
  ProductModel({
    this.name,
    this.image,
    this.id,
    this.description,
    this.categoryId,
    this.price,
    this.isProductAvailable
  });

  ProductModel.fromMap(Map<String, dynamic> data){
    name = data[prodName];
    id = data[prodId];
    image = data[prodImage];
    price = data[prodPrice].toDouble();
    categoryId = data[cateId];
    description = data[prodDescription];
    isProductAvailable = data[prodIsStock];
  }
  toJson() {
    return {
      prodName : name,
      prodId : id,
      prodImage:  image,
      prodPrice:price,
      cateId : categoryId,
      prodDescription:description,
      prodIsStock:isProductAvailable,
    };
  }
}