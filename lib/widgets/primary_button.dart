import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class PrimaryButton extends StatelessWidget{
  final String label; final VoidCallback? onPressed; final bool isLoading;
  const PrimaryButton({super.key,required this.label,required this.onPressed,this.isLoading=false});
  @override Widget build(BuildContext context)=>Container(
    height:48, decoration:BoxDecoration(gradient:isLoading?null:AppColors.buttonGradient,color:isLoading?AppColors.purple.withOpacity(.55):null,borderRadius:BorderRadius.circular(15),boxShadow:[if(!isLoading) BoxShadow(color:AppColors.purple.withOpacity(.24),blurRadius:12,offset:const Offset(0,6))]),
    child:ElevatedButton(onPressed:isLoading?null:onPressed,style:ElevatedButton.styleFrom(backgroundColor:Colors.transparent,disabledBackgroundColor:Colors.transparent,shadowColor:Colors.transparent,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15))),child:isLoading?const SizedBox(width:19,height:19,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2)):Row(mainAxisAlignment:MainAxisAlignment.center,children:[Text(label,style:AppText.button),const SizedBox(width:12),const Icon(Icons.arrow_forward_rounded,color:Colors.white,size:20)])));
}
