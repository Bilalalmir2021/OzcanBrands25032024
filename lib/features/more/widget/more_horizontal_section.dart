import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/more_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/views/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/loyaltyPoint/view/loyalty_point_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/offer/offers_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/view/order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/view/wallet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/view/wishlist_screen.dart';
import 'package:provider/provider.dart';

class MoreHorizontalSection extends StatelessWidget {
  const MoreHorizontalSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider,_) {
        return SizedBox(height: 130,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            child: Center(
              child: ListView(scrollDirection:Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(), children: [
                    if(!isGuestMode)
                      SquareButton(image: Images.shoppingImage, title: getTranslated('orders', context),
                        navigateTo: const OrderScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'orders',
                        balance: profileProvider.userInfoModel?.totalOrder??0, isLoyalty: true,
                      ),

                    SquareButton(image: Images.wishlist, title: getTranslated('wishlist', context),
                      navigateTo: const WishListScreen(),
                      count: Provider.of<AuthController>(context, listen: false).isLoggedIn() &&
                          Provider.of<WishListProvider>(context, listen: false).wishList != null &&
                          Provider.of<WishListProvider>(context, listen: false).wishList!.isNotEmpty ?
                      Provider.of<WishListProvider>(context, listen: false).wishList!.length : 0, hasCount: false,),

                    SquareButton(image: Images.cartImage, title: getTranslated('cart', context),
                      navigateTo: const CartScreen(),
                      count: Provider.of<CartController>(context,listen: false).cartList.length, hasCount: true,),

                   if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "theme_fashion")
                    SquareButton(image: Images.offerIcon, title: getTranslated('offers', context),
                      navigateTo: const OffersScreen(),count: 0,hasCount: false,),

                    if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.walletStatus == 1)
                      SquareButton(image: Images.wallet, title: getTranslated('wallet', context),
                          navigateTo: const WalletScreen(),count: 1,hasCount: false,
                          subTitle: 'amount', isWallet: true, balance: Provider.of<ProfileProvider>(context, listen: false).balance),


                    if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.loyaltyPointStatus == 1)
                      SquareButton(image: Images.loyaltyPoint, title: getTranslated('loyalty_point', context),
                        navigateTo: const LoyaltyPointScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'point',
                        balance: Provider.of<ProfileProvider>(context, listen: false).loyaltyPoint, isLoyalty: true,
                      ),





                  ]),
            ),
          ),
        );
      }
    );
  }
}
