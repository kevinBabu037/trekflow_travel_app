import 'package:flutter/material.dart';
import 'package:travel_app/presentation/fav&comments/favorite.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TrekFlow",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const Favorite(),));
            },
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.amber,
              size: 28,
            ),
          ),
        
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          sizedBox(height: 20),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'T r e n d i n g  N o w',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40, right: 20),
              scrollDirection: Axis.horizontal,
              children: [
                
                trentingPlacesNow(placeName: 'Maldives',
                imageUrl:'https://images.unsplash.com/photo-1586500038052-b831efc02314?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fG1hbGRpdmVzJTIwaXNsYW5kc3xlbnwwfHwwfHx8MA%3D%3D',
                 buttonAction: (){
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>
                       trentingPlaceDetails(
                           placeName: 'Maldives',
                           location:'Indian Island ' , 
                           img1: 'https://images.pexels.com/photos/1078983/pexels-photo-1078983.jpeg?auto=compress&cs=tinysrgb&w=600',
                           img2: 'https://images.pexels.com/photos/3250613/pexels-photo-3250613.jpeg?auto=compress&cs=tinysrgb&w=600',     
                           img3:'https://images.pexels.com/photos/2880801/pexels-photo-2880801.jpeg?auto=compress&cs=tinysrgb&w=600',
                           img4: 'https://images.pexels.com/photos/2417862/pexels-photo-2417862.jpeg?auto=compress&cs=tinysrgb&w=600',
                           descriptionTxt:"The Maldives, situated in the Indian Ocean southwest of India and Sri Lanka, is a captivating island nation comprised of 26 atolls and over 1,000 coral islands. Characterized by its breathtaking tropical beauty, the Maldives boasts pristine white sandy beaches, crystal-clear turquoise waters, and vibrant coral reefs. Malé serves as the bustling capital city. Despite being one of the world's lowest-lying countries, with no point rising significantly above sea level, it has become a renowned global tourist destination.")
                        ,)) ; 
                 } 
                ),

                 sizedBox(width: 20),
                
                 trentingPlacesNow(placeName: 'Varanasi',
                 imageUrl:'https://images.unsplash.com/photo-1608412525748-e06621067e23?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHZhcmFuYXNpfGVufDB8fDB8fHww',
                 buttonAction: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>
                   trentingPlaceDetails(
                        placeName: 'Varnasi',
                        location: 'Uttar Pradesh',
                        img1: 'https://images.pexels.com/photos/16745037/pexels-photo-16745037/free-photo-of-view-of-varanasi-from-ganges-river.jpeg?auto=compress&cs=tinysrgb&w=600', 
                        img2: 'https://images.pexels.com/photos/12771960/pexels-photo-12771960.jpeg?auto=compress&cs=tinysrgb&w=600',
                        img3: 'https://images.pexels.com/photos/8112558/pexels-photo-8112558.jpeg?auto=compress&cs=tinysrgb&w=600',
                        img4: 'https://images.pexels.com/photos/18073349/pexels-photo-18073349/free-photo-of-man-during-aarti-ceremony.jpeg?auto=compress&cs=tinysrgb&w=600',
                        descriptionTxt: "Varanasi, on the banks of the Ganges in Uttar Pradesh, India, is a city of profound spirituality and antiquity. As one of the world's oldest continuously inhabited places, it serves as a revered pilgrimage site for Hindus, believed to be the home of Lord Shiva. Iconic ghats like Dashashwamedh and Manikarnika host daily rituals, while narrow winding lanes showcase vibrant markets and traditional arts. Varanasi is also a center of learning, housing the prestigious Banaras Hindu University. This city, with its spiritual resonance and cultural richness, remains a timeless destination, drawing visitors seeking a deep connection with India's ancient traditions."
                        )
                   ,));
                 
                 }
                ),

                 sizedBox(width: 20),
                
                 trentingPlacesNow( placeName: 'Goa',
                 imageUrl:'https://images.unsplash.com/photo-1512100356356-de1b84283e18?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZGl2ZXN8ZW58MHx8MHx8fDA%3D',
                 buttonAction: (){
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>
                       trentingPlaceDetails(
                           placeName: 'Diva Island',
                           location:"Goa" , 
                           img1: 'https://images.pexels.com/photos/1433052/pexels-photo-1433052.jpeg?auto=compress&cs=tinysrgb&w=600',
                           img2: 'https://images.pexels.com/photos/1430676/pexels-photo-1430676.jpeg?auto=compress&cs=tinysrgb&w=600',     
                           img3:"https://imgs.search.brave.com/ZuclVI9meUuN1wT7UM3qdewuZ46pOqTgpPUjuomyivk/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jMC53/YWxscGFwZXJmbGFy/ZS5jb20vcHJldmll/dy83MzkvNjkvMTY2/L2luZGlhLWNhbGFu/Z3V0ZS0xNTYtZ29h/LmpwZw",   
                           img4: 'https://images.pexels.com/photos/59884/pexels-photo-59884.jpeg?auto=compress&cs=tinysrgb&w=600',
                           descriptionTxt:"Goa, a coastal state on the southwestern shores of India, is renowned for its sun-kissed beaches, vibrant nightlife, and rich cultural heritage. Nestled along the Arabian Sea, Goa is a tropical paradise that seamlessly blends Portuguese colonial influences with Indian traditions. Its pristine sandy shores, such as Baga and Calangute, attract sunseekers and water enthusiasts, while the historic churches and spice plantations reflect its diverse history. The state pulses with lively markets, beachfront shacks, and a laid-back atmosphere, making it a sought-after destination for both relaxation and revelry, offering a unique and dynamic fusion of East and West in the heart of India.")
                        ,)) ;
                 },
                ),
                 sizedBox(width: 20),
                
                 trentingPlacesNow(placeName: 'Munnar',
                 imageUrl:'https://plus.unsplash.com/premium_photo-1697730334419-fba83fe143b7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG11bm5hciUyMGtlcmFsYXxlbnwwfHwwfHx8MA%3D%3D',
                 buttonAction: (){
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>
                       trentingPlaceDetails(
                           placeName: 'Munnar',
                           location:"Kerala" , 
                           img1: 'https://images.pexels.com/photos/13260908/pexels-photo-13260908.jpeg?auto=compress&cs=tinysrgb&w=600',
                           img2: 'https://images.pexels.com/photos/3633950/pexels-photo-3633950.jpeg?auto=compress&cs=tinysrgb&w=600',     
                           img3:"https://images.unsplash.com/photo-1658051161493-1d311c4c7b4d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzh8fG11bm5hciUyMGhpbGxzfGVufDB8fDB8fHww",   
                           img4: 'https://images.unsplash.com/photo-1683744578044-1e33b1b32ef4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTh8fG11bm5hciUyMGhpbGxzfGVufDB8fDB8fHww',
                           descriptionTxt:"Nestled in the Western Ghats of Kerala, India, Munnar is a picturesque hill station renowned for its breathtaking landscapes and lush tea plantations. Surrounded by mist-covered hills, Munnar captivates with its serene beauty, cool climate, and diverse flora and fauna. The town is home to sprawling tea estates, where visitors can witness the intricate process of tea production. Attractions like the Eravikulam National Park, housing the endangered Nilgiri Tahr, and the mesmerizing Attukal Waterfalls add to Munnar's natural allure. With its tranquil ambiance and panoramic views, Munnar is a haven for nature enthusiasts seeking respite in the heart of Kerala's verdant embrace.")
                        ,)) ;
                 }
                ),

               

              ],
            ),
          ),
        ],
      ),
    );
  }
}
