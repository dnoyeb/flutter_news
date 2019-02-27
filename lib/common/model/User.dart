/* User类
 * Created by siyongkang
 * Date:2019/2/26
 */

// part 'User.g.dart';

class User {
  int id;
  String name;
  String account;
  String password;
  User(this.id,this.name,this.account,this.password);
  //  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


  // Map<String, dynamic> toJson() => _$UserToJson(this);

  // 命名构造函数
  User.empty();
}