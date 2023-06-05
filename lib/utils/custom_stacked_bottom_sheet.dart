import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customShowStackedBottomSheet(
    {required Widget child,
    required BuildContext context,
    bool? isDismissible,
    Size? size,
    Color? backColor,
    BoxConstraints? constraints, bool? isDarkMode}) {
  showModalBottomSheet(
    isDismissible: isDismissible ?? true,
    isScrollControlled: true,
    constraints: constraints,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.0),
      ),
    ),
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0.w),
              //width: size!.width,
              height: 10.0.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0.r),
                    topRight: Radius.circular(80.0.r),
                  ),
                  color: isDarkMode == true ? Colors.black12.withOpacity(0.6) : const Color(0xFFE7E8EA)),
            ),
            Container(
              //height: 700.0.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0.r),
                  topRight: Radius.circular(15.0.r),
                ),
                color: isDarkMode == true
                    ? Colors.black
                    : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 60.0.w,
                        height: 8.0.h,
                        decoration: BoxDecoration(
                          color: isDarkMode == true ? Colors.white70 : const Color(0xFFCFD1D4),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
            Container(
              color:  isDarkMode == true ? Colors.black : Colors.white,
              height: 32.0.h,
            ),
          ],
        ),
      ),
    ),
  );
}
