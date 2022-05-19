import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [

                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text("Thank You!",style: GoogleFonts.raleway(fontSize: 30,fontWeight: FontWeight.w700,),),
                ),
                      Text("Payment done Successfully",style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.w300,),)
            ,Center(
              child: Lottie.asset('assets/pyment_succesful.json',
                  animate: true,
                  fit: BoxFit.cover,
                  repeat: true,
                  width: double.infinity),
            ),
            Text(
              "\$3490",
              style: GoogleFonts.karla(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "You have successfully transferred the amount to \n                VADE0B248932ACRAF23DB3C4",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(

                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.8,

                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Color(0xff53B175)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                
                                
                                ))),
                    onPressed: () {},
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,color: Colors.white
                      ),
                    )),
              ),
            )
          ]),
    );
  }
}
