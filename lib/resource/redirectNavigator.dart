import 'package:flutter/material.dart';

import '../views/mainpage/bookPage.dart';
import '../views/wishlist/wishlist.dart';

class RedirectTO {
  RedirectToBookPage(context) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => BookPage()),
      ModalRoute.withName('/'),
    );
  }

  RedirectTOWishlistPage(context) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => WishList()),
        ModalRoute.withName('/'));
  }
}
