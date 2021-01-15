export 'colors.dart';
export 'dimens.dart';
export 'styles.dart';
export 'gaps.dart';

import 'package:dayansoft/config/resource_mananger.dart';
import 'package:flutter/material.dart';

class Images {
  static Widget dataIsEmpty = Image.asset(
    ImageHelper.wrapAssets('data_is_empty.png'),
  );
}
