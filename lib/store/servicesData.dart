import 'package:laundry/models/ServiceModel.dart';

Map<String, Map<String, Service>> laundryServices = {
  "men": {
    "t_shirt": Service.fromMap(
      {
        "slug": "t_shirt",
        "quantity": 0,
        "price": 0,
        "name": "T-SHIRT",
        "image": "assets/images/shirt.jpeg"
      }
    ),
      "trouser": Service.fromMap(
        {
          "slug": "trouser",
          "quantity": 0,
          "price": 0,
          "name": "TROUSER",
          "image": "assets/images/trouser.jpeg"
        }
      ),
      "shirt_hanging": Service.fromMap(
        {
          "slug": "shirt_hanging",
          "quantity": 0,
          "price": 0,
          "name": "SHIRT (HANGING)",
          "image": "assets/images/shirt_hanging.jpeg"
        }
      ),
      "shirt_folding": Service.fromMap(
        {
          "slug": "shirt_folding",
          "quantity": 0,
          "price": 0,
          "name": "SHIRT (FOLDING)",
          "image": "assets/images/shirt_folding.jpeg"
        }
      ),
      "suit_2piece": Service.fromMap(
        {
          "slug": "suit_2piece",
          "quantity": 0,
          "price": 0,
          "name": "SUIT 2PIECE",
          "image": "assets/images/suit2piece.jpeg"
        }
      ),
      "suit_3piece": Service.fromMap(
        {
          "slug": "suit_3piece",
          "quantity": 0,
          "price": 0,
          "name": "SUIT 3PIECE",
          "image": "assets/images/suit3piece.jpeg"
        }
      ),
      "jeans_trouser": Service.fromMap(
        {
          "slug": "jeans_trouser",
          "quantity": 0,
          "price": 0,
          "name": "JEANS TROUSER",
          "image": "assets/images/jeans.jpeg"
        }
      ),

      "buba_and_sokoto": Service.fromMap(
        {
          "slug": "buba_and_sokoto",
          "quantity": 0,
          "price": 0,
          "name": "BUBA AND SOKOTO",
          "image": "assets/images/buba_sokoto.jpeg"
        }
      ),
      "kaftan": Service.fromMap(
        {
          "slug": "kaftan",
          "quantity": 0,
          "price": 0,
          "name": "KAFTAN",
          "image": "assets/images/kaftan.jpg"
        }
      ),
    },
    "women": {
      "long_native_gown_not_stoned": Service.fromMap(
        {
          "slug": "long_native_gown_not_stoned",
          "quantity": 0,
          "price": 0,
          "name": "LONG NATIVE GOWN NOT STONED",
          "image": "assets/images/shirt.jpeg"
        }
      ),
      "long_stoned_native_gown": Service.fromMap(
        {
          "slug": "long_stoned_native_gown",
          "quantity": 0,
          "price": 0,
          "name": "LONG STONED NATIVE GOWN",
          "image": "assets/images/trouser.jpeg"
        }
      ),
      "short_native_gown": Service.fromMap(
        {
          "slug": "short_native_gown",
          "quantity": 0,
          "price": 0,
          "name": "SHORT NATIVE GOWN",
          "image": "assets/images/shirt.jpeg"
        }
      ),
      "shirt_native_gown_stoned": Service.fromMap(
        {
          "slug": "shirt_native_gown_stoned",
          "quantity": 0,
          "price": 0,
          "name": "SHORT NATIVE GOWN STONED",
          "image": "assets/images/skirt.jpeg"
        }
      ),
      "office_gown_short": Service.fromMap(
        {
          "slug": "office_gown_short",
          "quantity": 0,
          "price": 0,
          "name": "OFFICE GOWN (SHORT)",
          "image": "assets/images/jacket.jpeg"
        }
      ),
      "office_gown_long": Service.fromMap(
        {
          "slug": "office_gown_long",
          "quantity": 0,
          "price": 0,
          "name": "OFFICE GOWN (LONG)",
          "image": "assets/images/pant.jpeg"
        }
      ),
      "shirt": Service.fromMap(
        {
          "slug": "shirt",
          "quantity": 0,
          "price": 0,
          "name": "SHIRT",
          "image": "assets/images/jeans.jpeg"
        }
      ),

      "skirt_and_blouse": Service.fromMap(
        {
          "slug": "skirt_and_blouse",
          "quantity": 0,
          "price": 0,
          "name": "SKIRT AND BLOUSE",
          "image": "assets/images/pant.jpeg"
        }
      ),
      "skirt_and_blouse_stoned": Service.fromMap(
        {
          "slug": "skirt_and_blouse_stoned",
          "quantity": 0,
          "price": 0,
          "name": "SKIRT AND BLOUSE STONED",
          "image": "assets/images/jeans.jpeg"
        }
      ),
      "blouse": Service.fromMap(
        {
          "slug": "blouse",
          "quantity": 0,
          "price": 0,
          "name": "BLOUSE",
          "image": "assets/images/jeans.jpeg"
        }
      ),
    },
    "others": {
      "towel_xxl": Service.fromMap(
        {
          "slug": "towel_xxl",
          "quantity": 0,
          "price": 0,
          "name": "TOWEL (XXL)",
          "image": "assets/images/towel_xxl.jpeg"
        }
      ),
      "towel_L": Service.fromMap(
        {
          "slug": "towel_L",
          "quantity": 0,
          "price": 0,
          "name": "TOWEL (LARGE)",
          "image": "assets/images/towel_large.jpeg"
        }
      ),
      "towel_medium": Service.fromMap(
        {
          "slug": "towel_medium",
          "quantity": 0,
          "price": 0,
          "name": "TOWEL (MEDIUM)",
          "image": "assets/images/towel_medium.jpeg"
        }
      ),
      "towel_small": Service.fromMap(
        {
          "slug": "towel_small",
          "quantity": 0,
          "price": 0,
          "name": "TOWEL (SMALL)",
          "image": "assets/images/towel_small.jpeg"
        }
      ),
      "bed_sheet_xl": Service.fromMap(
        {
          "slug": "bed_sheet_xl",
          "quantity": 0,
          "price": 0,
          "name": "BED SHEET (XL)",
          "image": "assets/images/bedsheet_xl.jpeg"
        }
      ),
      "bed_sheet_large": Service.fromMap(
        {
          "slug": "bed_sheet_large",
          "quantity": 0,
          "price": 0,
          "name": "BED SHEET (LARGE)",
          "image": "assets/images/bedsheet_large.jpeg"
        }
      ),
      "pillow_case": Service.fromMap(
        {
          "slug": "pillow_case",
          "quantity": 0,
          "price": 0,
          "name": "PILLOW CASE",
          "image": "assets/images/pillowcase.jpeg"
        }
      ),
      "duvet_xl": Service.fromMap(
        {
          "slug": "duvet_xl",
          "quantity": 0,
          "price": 0,
          "name": "DUVET (XL)",
          "image": "assets/images/duvet_xl.jpeg"
        }
      ),
      "duvet_large": Service.fromMap(
        {
          "slug": "duvet_large",
          "quantity": 0,
          "price": 0,
          "name": "DUVET (LARGE)",
          "image": "assets/images/duvet_large.jpeg"
        }
      ),
      "duvet_small": Service.fromMap(
        {
          "slug": "duvet_small",
          "quantity": 0,
          "price": 0,
          "name": "DUVET (SMALL)",
          "image": "assets/images/duvet_small.jpeg"
        }
      ),
      "duvet_cover": Service.fromMap(
        {
          "slug": "duvet_cover",
          "quantity": 0,
          "price": 0,
          "name": "DUVET COVER",
          "image": "assets/images/duvet_cover.jpeg"
        }
      ),
    },
  };