import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import "dart:io";
import "dart:typed_data";
import "package:encrypt/encrypt.dart" as encrypt;
import 'encryptor.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import "loader.dart";
import "logo.dart";

void main(){
  return runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Logo(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File ogFile = File("");
  File hdFile = File("");
  var ogFilePath;
  num unFilledBytes = 0;
  var n = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("Home Page"),
      ),
      body:Container(
          alignment:Alignment.center,
          child:Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style:TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed:() async{
                      bool isExists = await  Directory("D:\\.hmf").exists();
                      if(isExists){
                      }
                      else{
                        Directory("D:\\.hmf").create();
                      }// this is how we create a empty directory .in starting we have to create a entire
                      //we have to create those entire directory in loading page when first the app is installed
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if(result != null) {
                        ogFile = File("${result.files[0].path}");
                      }
                      File encryptedFile = await MildEncryption.encryptFunc(ogFile);
                      Navigator.push(context,MaterialPageRoute(builder:(context) => const Loader()));
                      Navigator.pop(context);
                      ogFilePath = ogFile.path;
                      await encryptedFile.copy("D:\\.hmf\\${ogFile.path.split('\\').last}.hmfbd");
                      await ogFile.delete();
                    },
                    child:const Text("Pick file and Encrypt"),
                  ),
                  const SizedBox(height:25),
                  TextButton(
                    style:TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed:() async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if(result != null) {
                        hdFile = File("${result.files[0].path}");
                      }
                      var decryptedFile = await MildEncryption.decryptFunc(hdFile);
                      await decryptedFile.copy(ogFilePath);
                      // here we are going to decrypt the hdFile
                      decryptedFile.delete();
                    },
                    child:const Text("Pick file and Decrypt"),
                  ),
                ]
            ),
          )
      ),
    );
  }
}


/*
   Uint8List bytes = ogFile.readAsBytesSync();
    //list manipulation codes
    List bytesArrList = List.generate(n+1,(i)=> i);//extra one for balance item
    var oneArrLength = (bytes.length/n).toInt();
    var balanceElemLength = bytes.length%n;
    bytesArrList[n] = bytes.sublist(bytes.length-balanceElemLength,bytes.length);//11th place (index:10)
    unFilledBytes = n-bytesArrList[n].length;
    List fillingBytes = List<int>.generate(unFilledBytes.toInt(),(i)=>1);//generates the list of value 0
    //bytesArrList[n] +=fillingBytes;
    for(int i = 0;i<n;i++){
      bytesArrList[i] = bytes.sublist(i*oneArrLength,(i+1)*oneArrLength);//if we want 6(index:0to5) elements (0,6) ==> results (initIndex,finalIndex+1);
    }
    print(bytesArrList[n]);
    print(bytes.length);
    //list manipulation code ends here
    ogFile.writeAsStringSync("");//clearing the file
    File encryptedFile = File("");//initialising enc file var
    for(int i = 0;i<=n;i++) {
      var encryptedBytes = MyEncryption.myEncrypter.encryptBytes(bytesArrList[i], iv: MyEncryption.myIv);
      encryptedFile = await ogFile.writeAsBytes(encryptedBytes.bytes,mode:FileMode.append);
    }
    return encryptedFile;
  }
  Future<File> decryptFunc(File hdFile) async {
    Uint8List bytes = await hdFile.readAsBytes();
    List bytesArrList = List.generate(n+1,(index)=> index);//extra one for balance item
    var oneArrLength = bytes.length~/n;
    for(int i = 0;i<n;i++){
      bytesArrList[i] = bytes.sublist(i*oneArrLength,(i+1)*oneArrLength);//if we want 6(index:0to5) elements (0,6) ==> results (initIndex,finalIndex+1);
    }
    bytesArrList[n] = bytes.sublist(bytes.length-n,bytes.length);//11th place (index:10)
    print(bytesArrList[n].length);
    print(bytesArrList[n]);
    print(bytes.length);
    //list manipulation code ends here
    hdFile.writeAsStringSync("");//clearing the file
    File decryptedFile = File("");//initialising dec file var
    for(int i = 0;i<n;i++) {
      print(i);
        encrypt.Encrypted encryptedBytes = encrypt.Encrypted(bytesArrList[i]);
        var decryptedBytes = MyEncryption.myEncrypter.decryptBytes(encryptedBytes, iv: MyEncryption.myIv);
       if (i == n) bytesArrList[i] = bytesArrList.sublist(0, (bytesArrList[i].length - unFilledBytes).toInt());
        decryptedFile = await hdFile.writeAsBytes(decryptedBytes);
    }
    return decryptedFile;
  }

 */
