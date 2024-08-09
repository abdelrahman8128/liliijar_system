import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/states.dart';
import '../../db/db.dart';
import '../../screens/add_new_item/add_new_item.dart';
import '../../screens/home/home_screen.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../screens/categories/Categories_Screen.dart';

class cubit extends Cubit<States>{
  cubit(): super(InitialState()) ;
  static cubit get(context)=>BlocProvider.of(context);

  List<File> images = [];
  final picker = ImagePicker();

  int screenIndex=2;
  List<Widget> screens=[

    AddNewItem(),
    Categories(),
    HomeScreen(),
  ];

  List<CategoryModel>categories=[];
  List<ProductModel>products=[];
  ProductModel product=ProductModel();




  void pickImages() async {

    emit(ImagePickLoading());

    final pickedFiles = await picker.pickMultiImage();

      if (pickedFiles != null) {

        images =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        emit(ImagePickSuccess());
      } else {

        emit(ImagePickFailed());
        print('No images selected.');
      }

  }

  Future getCategories()async{
    print('a7a');
    emit(GetCategoriesLoading());
    categories.clear();
    try
    {
      var data = await dbGetAll(modelName: 'categories');
      await data.forEach((item) => {
            categories.add(CategoryModel.fromJson(item)),
          });
      emit(GetCategoriesSuccess());
    }
    catch(err){
      emit(GetCategoriesFailed());
    }
    return ;
  }

  void getProducts()async{
    products.clear();
    emit(GetProductsLoading());
    print('ya mosahel');
    try{
      var data = await dbGetAll(
          modelName: "products", columns: 'id,title,price,coverImage');
      await data.forEach((item) {
        products.add(ProductModel.fromJson(item));
      });

      print('done');
    }
    catch(err){
      emit(GetProductsFailed());
     // print('a7a');
      print (err.toString());
    }

    emit(GetProductsSuccess());
  }

  void getProduct(int id)async{
     product=ProductModel();
    emit(GetProductLoading());
   print('ya mosahel');
    try{
      var data = await dbGetOne(
          modelName: "products", id:id );
        product= ProductModel.fromJson(data);
        print(product.title);
    }
    catch(err){
      emit(GetProductFailed());
      print('a7a');
      print (err.toString());
    }


    emit(GetProductSuccess());
  }

  Future searchProducts(String searchQuery)async{
    emit(SearchProductsLoading());
    products.clear();
    try
    {
      var data = await dbSearch(modelName: 'products', searchQuery: searchQuery,columns: 'id,title,price,coverImage');
      await data.forEach((item) {
        products.add(ProductModel.fromJson(item));
      });
      print(data);
      emit(SearchProductsSuccess());
    }
    catch(err){
      emit(SearchProductsFailed());
    }
    return ;
  }

  Future<void> addCategory(String title) async {

   emit(AddCategoryLoading());
   try {
      var data = await dbInsert('categories', {
        "title": title,
      });
       categories.add(CategoryModel.fromJson(data[0]));
      print(categories.last.title.toString());
      emit(AddCategorySuccess());

   }
   catch(err){
     print (err);
     emit(AddCategoryFailed());
   }

  }

  Future<void> editCategory(int id,String title) async {

   emit(EditCategoryLoading());
   try {
      var data = await dbUpdateColumn(
          modelName: 'categories',
          updates:  {
            "title": title,
          },
          id: id
      );
      emit(EditCategorySuccess());
   }
   catch(err){
     print (err);
     emit(EditCategoryFailed());
   }

  }

}
