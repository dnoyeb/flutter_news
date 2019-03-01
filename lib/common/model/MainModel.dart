import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with BaseModel,CounterModel{}

class BaseModel extends Model {}
class CounterModel extends BaseModel{
  int _count = 0;
  get count => _count;
  
  void increment(){
    _count++;
    notifyListeners();
  }
}