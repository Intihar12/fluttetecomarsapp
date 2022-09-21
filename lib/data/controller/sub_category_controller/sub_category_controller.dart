import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/data/model/itemModel/items_model.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

const double cardHeight = 110.0;

class SubcategoryController extends GetxController
    with SingleGetTickerProviderMixin {
  bool isLoading = true;
  bool noInternet = false;
  final _repository = Repository();
  CategoryProduct? categoryProduct;
  SaveStoreData ? saveStoreData;
  SubcategoryController({ required this.category});
  Categories category;
  ScrollController modalController = ScrollController();
  List<SubCategories>? subCategory = [];
SubCategories ?subCategories;
  // var id1=0.obs;
  RxInt id1 = 0.obs;

  TabController? tabController;

  bool _listen = true;

  List<CategoryTabs> tabs = [];
  final _sharedPrefClient = SharedPrefClient();
  List<SubCat>? subCatModel;

  @override
  void onInit() async {
 saveStoreData=await _sharedPrefClient.getStoreData();
    subCategory = category.subCategories;
    await onCategoryProduct(subCategory![0].id.toString(), saveStoreData!.id!.toString());
    // init(this);
    // TODO: implement onInit
    super.onInit();
  }

  Future<bool> onCategoryProduct(String subCatId, String string, ) async {
    try {
      saveStoreData=await _sharedPrefClient.getStoreData();
      isLoading = true;
      update();
      categoryProduct = await _repository.onCategoryProduct(subCatId, saveStoreData!.id.toString());
      // subCatModel!.addAll(categoryProduct!.response!.categories!.subCategories ?? []);
      subCatModel = categoryProduct!.response!.categories!.subCategories;
      if(tabController!=null)
        tabController = null;
      tabs = [];
      init(this);
      final String? cartString = await _sharedPrefClient.getCartItem();
      final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);

      final String? favString = await _sharedPrefClient.getFavItem();
     final List<FavouriteItem> favItemSave = FavouriteItem.decode(favString!);
      Constants.cartCount.value = Constants.itemInCart(cartItemSave);
      if(favItemSave.length != 0 && subCatModel!.length != 0){
        favItemSave.forEach((elementF) {
          subCatModel!.forEach((elementC) {
            if(elementC.products!.isNotEmpty){
              elementC.products!.forEach((elementP) {
                if(elementF.productStoreId == elementP.productStoreId){
                  elementP.isFav.value = true;
                }
              });
            }
          });
        });
      }
      if (cartItemSave.length != 0 && subCatModel!.length != 0) {
        for (int i = 0; i < subCatModel!.length; i++) {
          if (subCatModel![i].products!.length != 0) {
            for (int k = 0; k < subCatModel![i].products!.length; k++) {
              for (int j = 0; j < cartItemSave.length; j++) {
                if (cartItemSave[j].productStoreId ==
                    subCatModel![i].products![k].productStoreId) {
                  subCatModel![i].products![k].itemCount.value =
                      cartItemSave[j].quantity;
                }
              }
            }
          }
        }
      }

      isLoading = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
      return true;
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading = false;
        noInternet = true;
        update();
        return false;
      } else {
        isLoading = false;
        noInternet = true;
        update();
        Get.snackbar(
            "CategoryProduct", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }

  void tabInit(final TickerProvider ticker) {
    tabController = TabController(length: subCatModel!.length, vsync: ticker);
  }

  void init(TickerProvider ticker) {
    double offSetForm = 0.0;
    double offSetTo = 0.0;

    tabController = TabController(length: subCatModel!.length, vsync: ticker);

    for (int i = 0; i < subCatModel!.length; i++) {
      if (i > 0) {
        offSetForm += (subCatModel![i - 1].products!.length * cardHeight) - 95;
      }
      if (i < subCatModel!.length - 1) {
        offSetTo =
            (offSetForm + (subCatModel![i + 1].products!.length * cardHeight)) - 95;
      } else {
        offSetTo = double.infinity;
      }

      final category = subCatModel![i];

      //  if(tabs.length <6)
      // {
      tabs.add(CategoryTabs(
          catModel: category,
          selected: (i == 0),
          offSetForm: offSetForm,
          offSetTo: offSetTo));
      // }

      print("Tabs Lenght: ${tabs.length}");
    }
    modalController.addListener((onScrollerListener));
  }

  void onScrollerListener() {
    if (_listen) {
      for (int i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if (modalController.offset >= tab.offSetForm &&
            modalController.offset <= tab.offSetTo &&
            !tab.selected) {
          selectedTabMove(i, animationRequired: false);
          tabController!.animateTo(i);
        }
      }
    }
  }

  void selectedTabMove(index, {bool animationRequired = true}) async {
    final selectedTab = tabs[index];
    for (int i = 0; i < tabs.length; i++) {
      final condition = selectedTab.catModel.name == tabs[i].catModel.name;
      tabs[i] = tabs[i].copyWith(condition);
    }
    if (animationRequired) {
      _listen = false;
      await modalController.animateTo(selectedTab.offSetForm,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
    _listen = true;
    update();
  }

  void selectedCategory(int index) {
    id1.value = index;
    update();
  }

  @override
  void onClose() {
    // tabController.dispose();

    // modalController.dispose();

    // modalController.removeListener((onScrollerListener) );

    // TODO: implement onClose

    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

    //  tabController!.dispose();

    // modalController.dispose();

    // modalController.removeListener((onScrollerListener) );
  }

// void scrollToTop() {

//   modalController.animateTo(0,

//       duration: Duration(milliseconds: 200), curve: Curves.linear);

//

// }

}

class CategoryTabs {
  final SubCat catModel;

  final bool selected;

  final double offSetForm;

  final double offSetTo;

  CategoryTabs copyWith(bool selected) => CategoryTabs(
      catModel: catModel,
      selected: selected,
      offSetForm: offSetForm,
      offSetTo: offSetTo);

  CategoryTabs({
    required this.catModel,
    required this.selected,
    required this.offSetForm,
    required this.offSetTo,
  });
}
