import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watersupply/MainDrawer.dart';
import 'package:watersupply/productpage.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String imageLink = "https://img.freepik.com/free-psd/1-0l-fresh-water-bottle-mockup_358694-280.jpg?t=st=1652460748~exp=1652461348~hmac=e698c77e3208a26ec50c79b7468b5a73e2a3291d1438df11a8eaedc4ad0f43c0&w=900";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        

            appBar: AppBar(title: const Text("Home"),),


            drawer: MainDrawer(),


      body: SingleChildScrollView(
        child: Column(children: [
                   
      
                   ListView.builder(
                     itemCount: 2,
                     shrinkWrap: true,
                     itemBuilder: (context,index){
      
                            return GestureDetector(
                              onTap: (){

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage(image: imageLink,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25 , right: 25 , top: 15 , bottom:15 ),
                                child: Container(
                                      width: MediaQuery.of(context).size.width*0.75, 
                                      height: MediaQuery.of(context).size.height*0.36,
                                  
                                      decoration: BoxDecoration(
                            
                                                borderRadius: BorderRadius.circular(20),
                            
                                            color: Colors.grey.shade200 
                            
                                      ),
                            
                                      child: Column(children: [
                            
                            
                                                Image.asset("assets/water_image.png",
                            
                                                    height: MediaQuery.of(context).size.height*0.27,
                                                    width: MediaQuery.of(context).size.width*0.8,
                                                  
                                                  ),
                            
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      
                                                      children: [
                                                  
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                            Text("Product One",style: GoogleFonts.raleway(fontWeight: FontWeight.w600, fontSize: 18,),),
                                                              Text("\$135",style:GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16,) ,)
                                                          ],),  
                                                       Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration( shape: BoxShape.circle ,
                                                                  color: Colors.white.withOpacity(0.9)
                                                               ),
                                                  
                                                         child: Icon(Icons.shopping_cart_outlined))
                                                    ],),
                                                  ),
                                      ],),
                                ),
                              ),
                            );
                   })     
        ],),
      ),
    );
  }
}