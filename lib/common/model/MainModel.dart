import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

class MainModel extends Model
    with BaseModel, CounterModel, PhotoModel, SlideModel {}

class BaseModel extends Model {}

class CounterModel extends BaseModel {
  int _count = 0;
  get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class PhotoModel extends BaseModel {
  File _imageData = null;
  get imageData => _imageData;

  void setImage(value) {
    _imageData = value;
    print(_imageData);
    notifyListeners();
  }
}

class SlideModel extends BaseModel {
  String _imageUrl;
  get imageUrl => _imageUrl;

  void setSlideImage(value) {
    _imageUrl = value;
    notifyListeners();
  }
}
