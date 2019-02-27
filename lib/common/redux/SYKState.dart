/**redux全局state
 * Created by siyongkang
 * Date:2019/2/26
 */
import 'package:syk_flutter/common/model/User.dart';
import 'package:syk_flutter/common/redux/SYKReducer.dart';

class SYKState {
  User userInfo;
  SYKState({this.userInfo});
}

SYKState appReducer(SYKState state, action) {
  return SYKState(userInfo: UserReducer(state.userInfo, action));
}
