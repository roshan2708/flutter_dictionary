import 'package:dictionary_app/Model/drctionary_model.dart';
import 'package:dictionary_app/Services/api_service.dart';
import 'package:flutter/material.dart';

class DictionaryHomePage extends StatefulWidget {
  const DictionaryHomePage({super.key});

  @override
  State<DictionaryHomePage> createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  DictionaryModel? myDictionaryModel;
  bool isLoading = false;
  String noDataFound = "Now you can search";
  searchContain(String word) async {

    setState(() {
      isLoading = true;
      
    });
    try {
      myDictionaryModel = await ApiService.fetchData(word);

    } catch (e) {
      myDictionaryModel = null;
      noDataFound = "No data found ";
      
    }finally{
      setState(() {
        isLoading = false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(65, 179, 162, 1.0),
      appBar: AppBar(title: Text("DefineIt" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),backgroundColor: Color.fromRGBO(242, 229, 191, 1.0)
,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 15,),
          SearchBar(hintText: "Search the word here",
          onSubmitted: (value) {
            searchContain(value);
          },),
          SizedBox(height: 15,),
          if(isLoading)
          const LinearProgressIndicator()
          else if(myDictionaryModel != null)
          Expanded(child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
            
            // Container(color:Colors.red , width: double.infinity, height: 45,child:  Text(myDictionaryModel!.word.toUpperCase(),style: TextStyle(fontSize: 25 , color: const Color.fromARGB(255, 23, 0, 57) , fontWeight: FontWeight.bold),)),
            Text(myDictionaryModel!.phonetics.isEmpty?myDictionaryModel!.phonetics[0].text??"" : ""),
           
            Expanded(child: ListView.builder(
              itemCount: myDictionaryModel!.meanings.length,
              itemBuilder: (context , index){
                return showMeaning(myDictionaryModel!.meanings[index]);

            }))
          ],),) else 
          Text(noDataFound , style: TextStyle(fontSize: 22),)
      
        ],),
      ),
    );
  }
}



showMeaning(Meaning meaning){
  String wordDefinition = '';
  for(var element in meaning.definitions){
    int index = meaning.definitions.indexOf(element);
    wordDefinition += "\n${index + 1}.${element.definition}\n";

  }
  return Padding(
    
    padding: const EdgeInsets.all(8.0),
    child: Material(
      
      color: Color.fromRGBO(255, 250, 230, 1),
      elevation: 2,
      borderRadius: BorderRadius.circular(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(meaning.partOfSpeech.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold , color: Color.fromRGBO(232, 141, 103,1),fontSize: 25),),
          ),
          Text("Definitions", style: TextStyle( fontSize: 22 , color: Color.fromRGBO (10, 104, 71,1)),),
          Text(wordDefinition, style: TextStyle( fontSize: 17),),
        ],
            
            
        ),
      ),
    ),
  );
}