import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RoundedTextField extends StatefulWidget {
  final String label, hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final IconData icon;
  const RoundedTextField({super.key, required this.label, required this.hint, required this.controller, required this.icon, this.isPassword=false, this.errorText, this.keyboardType=TextInputType.text, this.onChanged});
  @override State<RoundedTextField> createState()=>_RoundedTextFieldState();
}
class _RoundedTextFieldState extends State<RoundedTextField>{
  late bool _obscure;
  @override void initState(){super.initState(); _obscure=widget.isPassword;}
  @override Widget build(BuildContext context){
    final error=widget.errorText?.isNotEmpty==true;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Text(widget.label, style: AppText.label),
      const SizedBox(height:5),
      SizedBox(height:48, child: TextField(
        controller: widget.controller, obscureText: widget.isPassword && _obscure, keyboardType: widget.keyboardType, onChanged: widget.onChanged,
        style: AppText.input, cursorColor: AppColors.purple,
        decoration: InputDecoration(
          hintText: widget.hint, hintStyle: AppText.hint, filled:true, fillColor: AppColors.white,
          prefixIcon: Icon(widget.icon, color: AppColors.purple, size:20),
          suffixIcon: widget.isPassword ? IconButton(onPressed:()=>setState(()=>_obscure=!_obscure), icon: Icon(_obscure?Icons.visibility_off_outlined:Icons.visibility_outlined, size:18, color:AppColors.muted)) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal:14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color:error?AppColors.error:AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color:error?AppColors.error:AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color:error?AppColors.error:AppColors.purple,width:1.5)),
        ),
      )),
      if(error) Padding(padding:const EdgeInsets.only(top:4,left:4),child:Text(widget.errorText!,style:AppText.error)),
    ]);
  }
}
