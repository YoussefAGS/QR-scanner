import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_google_play/shared/constants/constant.dart';
class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: (){
              context.setLocale(Locale("en"));
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.locale == Locale("en")?Theme.of(context).colorScheme.primary:Colors.black,width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'english'.tr(),
                    style: TextStyle(
                      color:  context.locale == Locale("en")?Theme.of(context).colorScheme.primary: Colors.black,
                      fontSize: 21,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  context.locale == Locale("en")?Icon(
                    Icons.done,
                    size: 30,
                    color:context.locale == Locale("en")?Theme.of(context).colorScheme.primary: Colors.black ,
                  ):SizedBox(width: 0,),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: (){
              context.setLocale(Locale("ar","EG"));
              Navigator.pop(context);
            },

            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.locale == Locale("ar","EG")?Theme.of(context).colorScheme.primary:Colors.black,width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Arabic'.tr(),
                    style: TextStyle(
                      color:  context.locale == Locale("ar","EG")?Theme.of(context).colorScheme.primary: Colors.black,
                      fontSize: 21,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  context.locale == Locale("ar","EG")?
                  Icon(
                    Icons.done,
                    size: 30,
                    color:context.locale == Locale("ar","EG")?Theme.of(context).colorScheme.primary: Colors.black ,
                  ):SizedBox(width: 0,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
