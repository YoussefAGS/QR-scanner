import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_google_play/shared/constants/constant.dart';
import 'package:qr_google_play/ui/bloc/theam/theme__bloc.dart';

class Thememodebottom extends StatelessWidget {
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
            onTap: () {
              BlocProvider.of<ThemeBloc>(context).add(LightThemeEvent());
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: sharedPreferences?.get('them')=='Light'?Theme.of(context).colorScheme.primary:Colors.black,width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'light'.tr(),
                    style: TextStyle(
                      color: sharedPreferences?.get('them')=='Light'?Theme.of(context).colorScheme.primary: Colors.black,
                      fontSize: 21,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  sharedPreferences?.get('them')=='Light'?Icon(Icons.done,
                      size: 30, color : Theme.of(context).colorScheme.primary)
                      :SizedBox(width: 0,),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<ThemeBloc>(context).add(DarkThemeEvent());
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: sharedPreferences?.get('them')=='Dark'?Theme.of(context).colorScheme.primary:Colors.black,width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('dark'.tr(),
                      style: TextStyle(
                        color: sharedPreferences?.get('them') == 'Dark'
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                        fontSize: 21,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                  sharedPreferences?.get('them') == 'Dark'
                      ?Icon(Icons.done,
                      size: 30, color : Theme.of(context).colorScheme.primary)
                      :SizedBox(width: 0,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
