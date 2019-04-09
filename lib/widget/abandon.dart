//ListView.builder(
//   itemExtent: 160.0,
//   itemCount: 11,
//   itemBuilder: (context, index) => Container(
//         margin: EdgeInsets.all(10.0),
//         child: Material(
//           elevation: 6.0,
//           // borderRadius: BorderRadius.circular(5.0),
//           color: index % 2 == 0 ? Colors.cyan : Colors.orangeAccent,
//           child: Container(
//             margin: new EdgeInsets.all(10.0),
//             child: new Stack(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Image.asset(
//                       'assets/images/avatar.png',
//                       width: 120.0,
//                       height: 120.0,
//                       fit: BoxFit.contain,
//                     ),
//                     new Container(
//                       padding: new EdgeInsets.all(10.0),
//                       // decoration: new BoxDecoration(
//                       //   border:
//                       //       new Border.all(color: Colors.green, width: 0.5),
//                       // ),
//                       width: 200.0,
//                       // height: 100.0,
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             '标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             softWrap: true,
//                             style: new TextStyle(
//                               color: Colors.black,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                           Text(
//                             index.toString() + '简介简介简介简介简介简介简介简介简介简介简介简介',
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             softWrap: true,
//                             style: new TextStyle(
//                               color: Colors.black45,
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 new Positioned(
//                   child: Container(
//                     padding: EdgeInsets.all(10.0),
//                     // width: 140.0,
//                     // decoration: new BoxDecoration(
//                     //   border: new Border.all(color: Colors.red, width: 0.5),
//                     // ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         new IconButton(
//                           tooltip: '喜欢',
//                           onPressed: () {
//                             setState(() {
//                               ListData[index] =
//                                   ListData[index] == 1 ? 0 : 1;
//                             });
//                           },
//                           icon: Icon(
//                             ListData[index] == 1
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: Colors.pink,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   right: 0.0,
//                   bottom: 0.0,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
// );





// class MyPage extends StatefulWidget {
//   @override
//   MyPageState createState() => MyPageState();
// }

// class MyPageState extends State<MyPage> {
//   List<String> lists = [
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557760&di=2c0ccc64ab23eb9baa5f6582e0e4f52d&imgtype=0&src=http%3A%2F%2Fpic.feizl.com%2Fupload%2Fallimg%2F170725%2F43998m3qcnyxwxck.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557760&di=37d5107e6f7277bc4bfd323845a2ef32&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Fsmccloud%2Ffetch%2F2015%2F06%2F05%2F79697840747611479.JPEG",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557760&di=95860b0fd501110885cf6e191f7403f0&imgtype=0&src=http%3A%2F%2Fuploads.5068.com%2Fallimg%2F1712%2F144-1G2011I420.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212636935&di=110a278fe4fb22f07d183a049f36cba3&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D3695896267%2C3833204074%26fm%3D214%26gp%3D0.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557759&di=3730dccf46e4b4f35bcb882148b973ee&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F3%2F71%2F4c5b0d26ad.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557759&di=4f53fa8e1699def18e976deaee5558bf&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201707%2F07%2F20170707151851_r34Se.jpeg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557758&di=ea77e663ac012b8ce7eb921454528cb8&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201707%2F07%2F20170707151853_Xr2UP.jpeg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686377&di=513a2deeb0b9f66ac9f7713c1f08e38c&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180926104109132.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686377&di=d895baef0710a780cbff871b68fbabba&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201810%2F20181015170515909.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686376&di=6c670e61692a4b8a8c97fc8d751df6e9&imgtype=0&src=http%3A%2F%2Fpic.qqtn.com%2Fup%2F2018-8%2F2018082209071335857.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686375&di=5772b73b9349682e9883d57394655c5e&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180926104109561.jpg",
//     "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1919562808,974781852&fm=11&gp=0.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686375&di=6646871a196763dad8bfb7d0b74f4fad&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180925112416520.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686375&di=07280c585f18cac3c1f251e7a496e2f3&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180920095533914.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686374&di=e0d4e585e1bafcfc0534f793091fbd03&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180918142250630.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686374&di=734df4a0341928437473ffaf4103b04e&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201810%2F20181015170515157.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686374&di=da3b239ebf59f5baae05eea6c663e8e5&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201810%2F20181015111057142.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212686374&di=f1156ff86227ca20deeaf2251f9a4054&imgtype=0&src=http%3A%2F%2Fwmimg.sc115.com%2Fwm%2Fpic%2F1705%2F1705vzcqpmrsfxo.jpg",
//     "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=509143600,2831498304&fm=26&gp=0.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212767984&di=79e2286d0ecd5a944183eb319af5a07e&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180920104457446.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212767983&di=779e1f58291cb90d7635fb7575c14149&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201810%2F20181015134233184.jpg",
//     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212833549&di=6f022bf302e786643fb43b9ba9c5a75e&imgtype=0&src=http%3A%2F%2Flife.southmoney.com%2Ftuwen%2FUploadFiles_6871%2F201809%2F20180926110752933.jpg"
//   ];
//   void showPhoto(BuildContext context, f, index) {
//     Navigator.push(context,
//         MaterialPageRoute<void>(builder: (BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(title: Text('图片${index + 1}')),
//         body: SizedBox.expand(
//           child: Hero(
//             tag: index,
//             child: new Photo(url: f, source: 3),
//           ),
//         ),
//       );
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: Text('GridAnimation'),
//         ),
//         body: new Column(
//           children: <Widget>[
//             new Expanded(
//               child: new SafeArea(
//                 top: false,
//                 bottom: false,
//                 child: new GridView.count(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10.0,
//                   crossAxisSpacing: 4.0,
//                   padding: const EdgeInsets.all(4.0),
//                   childAspectRatio: 1.5,
//                   children: lists.map((f) {
//                     var index;
//                     if (lists.contains(f)) {
//                       index = lists.indexOf(f);
//                     }
//                     return new GestureDetector(
//                       onTap: () {
//                         showPhoto(context, f, index);
//                       },
//                       child: Hero(
//                         tag: index,
//                         child: Image.network(
//                           f,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             )
//           ],
//         ));
//   }
// }






// class MyPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => MyPageState();
// }

// class MyPageState extends State<MyPage> {
//   String test = '132';
//   @override
//   void initState() {
//     dio
//         .get(
//             'https://result.eolinker.com/VI1Wbcdb5a5f53e8621a1e4c252df9124da6a9030246781?uri=mall')
//         .then((res) {
//       print(json.decode(res.data)['limit']);
//       setState(() {
//         test = json.decode(res.data)['limit'].toString();
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(test),
//     );
//   }
// }
// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
//   Animation<double> tween;
//   AnimationController controller;
//   /*初始化状态*/
//   @override
//   initState() {
//     /*创建动画控制类对象*/
//     controller = new AnimationController(
//         duration: const Duration(seconds: 5), vsync: this);

//     /*创建补间对象*/
//     tween = new Tween(begin: 0.0, end: 1.0).animate(controller) //返回Animation对象
//       ..addListener(() {
//         //添加监听
//         setState(() {
//           print(tween.value); //打印补间插值
//         });
//       });
//     // controller.repeat(); //执行动画
//     super.initState();
//   }

//   @override
//   dispose() {
//     //销毁控制器对象
//     controller.dispose();
//     super.dispose();
//   }

//   startAnimtaion() {
//     setState(() {
//       controller.forward(from: 0.0);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // decoration: new BoxDecoration(
//         //   border: new Border.all(color: Colors.red, width: 0.5),
//         // ),
//         child: ClipPath(
//           clipper: BottomClipper(),
//           child: Container(
//             color: Colors.deepPurpleAccent,
//             height: 200.0,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BottomClipper extends CustomClipper<Path> {
//   // BottomClipper(this.item);
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     double w = size.width;
//     double h = size.height;
//     path.lineTo(0, h - 40);
//     for (int i = 0; i < 2; i++) {
//       var cp =
//           Offset(i * w / 2 + w / 4, h + 40 * (i % 2 == 0 ? -1 : 1) - 40);
//       var ep = Offset((i + 1) * w / 2, h - 40);
//       path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
//     }

//     path.lineTo(w, h - 80);
//     path.lineTo(w, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
