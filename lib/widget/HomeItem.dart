import 'package:flutter/material.dart';
import 'package:syk_flutter/page/Detail.dart';
import 'package:syk_flutter/common/utils/CommonUtils.dart';

class HomeItemWidget extends StatelessWidget {
  final int index;
  final List dataList;
  HomeItemWidget({Key key, this.index, this.dataList}) : super(key: key);
  void goDetail(BuildContext context, imgUrl, index) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: SizedBox.expand(
              child: Hero(
                tag: index,
                child: new DetailPage(
                  imgUrl: imgUrl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    if (index == 3 || index == 6) {
      return Column(
        children: <Widget>[
          Text(
            '第一类Item格式凑点字数凑点字数凑点字数凑点字数凑点字数',
            style: TextStyle(
              inherit: false,
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '中国青年网    35评论    5分钟前',
                style: TextStyle(
                  inherit: false,
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              CloseTap()
            ],
          ),
        ],
      );
    } else if (index == 2 || index == 5 || index == 7) {
      return Column(
        children: <Widget>[
          Text(
            '第二类Item格式凑点字数凑点字数凑点字数凑点字数凑点字数',
            style: TextStyle(
              inherit: false,
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          Hero(
            tag: index,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.network(
                    dataList[index],
                    fit: BoxFit.fill,
                    width: 135.0,
                    height: 100.0,
                  ),
                  Image.network(
                    dataList[index],
                    fit: BoxFit.fill,
                    width: 135.0,
                    height: 100.0,
                  ),
                  Image.network(
                    dataList[index],
                    fit: BoxFit.fill,
                    width: 135.0,
                    height: 100.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '中国青年网    35评论    5分钟前',
                style: TextStyle(
                  inherit: false,
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              CloseTap()
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 270.0,
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '第三类Item格式凑点字数凑点字数凑点字数凑点字数凑点字数',
                  style: TextStyle(
                    inherit: false,
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '中国青年网    35评论    5分钟前',
                      style: TextStyle(
                        inherit: false,
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                    CloseTap()
                  ],
                ),
              ],
            ),
          ),
          Hero(
            tag: index,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Image.network(
                dataList[index],
                fit: BoxFit.fill,
                width: 135.0,
                height: 100.0,
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: _renderItem(context, index),
      ),
      onTap: () {
        goDetail(context, dataList[index], index);
      },
    );
  }
}

class CloseTap extends StatefulWidget {
  @override
  _CloseTapTapState createState() => _CloseTapTapState();
}

class _CloseTapTapState extends State<CloseTap> with WidgetsBindingObserver {
  void _onAfterRendering(Duration timeStamp) {
    RenderObject renderObject = context.findRenderObject();
    Size size = renderObject.paintBounds.size;
    var vector3 = renderObject.getTransformTo(null)?.getTranslation();
    CommonUtils.showChooseDialog(context, size, vector3);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.close),
      onTapDown: (TapDownDetails details) {
        WidgetsBinding.instance.addPostFrameCallback(_onAfterRendering);
        setState(() {
        });
      },
    );
  }
}
