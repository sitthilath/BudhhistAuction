import 'package:buddhistauction/Model/buddhist_detail.dart';
import 'package:flutter/cupertino.dart';

class BuddhistArguments {

 final int idx;
 final List<BuddhistDetail> buddhistItem;

  BuddhistArguments({@required this.idx,
                      @required this.buddhistItem});
}