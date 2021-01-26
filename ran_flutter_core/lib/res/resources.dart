export 'colors.dart';
export 'dimens.dart';
export 'styles.dart';
export 'gaps.dart';

import 'package:flutter/material.dart';
import 'package:ran_flutter_core/config/resource_mananger.dart';

class Images {
//  static const Widget arrowRight = const LoadAssetImage("ic_arrow_right", height: 16.0, width: 16.0);
  static Widget pageNotFound = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('pageNotFound.png'),
  );
  static Widget dataIsEmpty = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('data_is_empty.png'),
  );
  static Widget messageIsEmpty = Image.asset(
    'packages/ran_flutter_core/' +
        ImageHelper.wrapAssets('message_is_empty.png'),
  );
  static Widget messageListIsEmpty = Image.asset(
    'packages/ran_flutter_core/' +
        ImageHelper.wrapAssets('message_list_is_empty.png'),
  );
  static Widget noCollection = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_collection.png'),
  );
  static Widget noComments = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_comments.png'),
  );
  static Widget noCoupon = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_coupon.png'),
  );
  static Widget noHistory = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_history.png'),
  );
  static Widget noNetwork = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_network.png'),
  );
  static Widget noNewsList = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_news_list.png'),
  );
  static Widget noPermission = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('no_permission.png'),
  );
  static Widget noSearchResults = Image.asset(
    'packages/ran_flutter_core/' +
        ImageHelper.wrapAssets('no_search_results.png'),
    width: 200,
    height: 200,
  );
  static Widget noShippingAddress = Image.asset(
    'packages/ran_flutter_core/' +
        ImageHelper.wrapAssets('no_shipping_address.png'),
  );
  static Widget orderIsEmpty = Image.asset(
    'packages/ran_flutter_core/' + ImageHelper.wrapAssets('order_is_empty.png'),
  );
  static Widget shoppingCartIsEmpty = Image.asset(
    'packages/ran_flutter_core/' +
        ImageHelper.wrapAssets('shopping_cart_is_empty.png'),
  );
}
