//
//  FlieManagerBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 03/10/22.
//

import SwiftUI
class LocalFileManager
{
    static let instance = LocalFileManager()
    let foldername:String = "MyAPP_Images"
    init() {
        createFolderifNeeded()
    }
    func deleteFolder (){
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: foldername)
            .path else {return}
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Sucess deleting folder")
        } catch (let error) {
            print("Error: \(error.localizedDescription)")
        }
    }
    func createFolderifNeeded (){
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: foldername)
            .path else {return}
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try   FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true,attributes: nil)
                print("Sucess creating folder")
            } catch (let error ) {
                print(error.localizedDescription)
            }
          
        }
    }
    func saveImage(image:UIImage , name : String) -> String{
       guard let data = image.jpegData(compressionQuality: 1.0),
             let path  = getpathForImage(name: name)
                //0.5 for 50% compress
        else{
          return "Error Getting Data"
          
       }
       // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      //  let directory3 = FileManager.default.temporaryDirectory
       // data.write(to: )
       
            do {
                try  data.write(to:path)
            } catch (let error) {
                return "\(error.localizedDescription)"
            }
        return "File saved"
    }
    func getpathForImage(name:String) -> URL? {
        guard
             let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(component: foldername)
                .appending(component:"\(name).jpg" )
        else {return nil}
        return path
    }
    func getImage(name:String) -> UIImage?{
        guard let path = getpathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else
                {
                    return nil
                }
        return UIImage(contentsOfFile: path)
    }
    func deleteImage (name:String) -> String {
        guard let path = getpathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path) else
                {
            return "Error Getting Path"
                }
        do {
            try  FileManager.default.removeItem(at: path)
            return "File Deleted"
        } catch (let error) {
            return "Error ; \(error.localizedDescription)"
        }
       
    }
}
class FlieManagerBootCampViewModel : ObservableObject {
    @Published var image: UIImage? = nil
    @Published var infofmessage : String = ""
    let fm = LocalFileManager.instance
    let imagename:String = "Screenshot"
    
    init(){
        //getImageFromAssestsFolder()
       getImagefromFilrmanager()
    }
    func getImageFromAssestsFolder(){
        image = UIImage(named: imagename)
    }
    func saveImage() {
        guard let image = image else {return}
        infofmessage = fm.saveImage(image: image, name: imagename)
    }
    func getImagefromFilrmanager(){
        image = fm.getImage(name: imagename)
    }
    func deleteImage ()
    {
        infofmessage =  fm.deleteImage(name: imagename)
        fm.deleteFolder() 
    }
}
struct FlieManagerBootCamp: View {
    @StateObject var vm :FlieManagerBootCampViewModel = FlieManagerBootCampViewModel()
    var body: some View {
 
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)

                        .resizable()
                        .frame(width: 200,height: 200)
                        .clipped()
                    .cornerRadius(20)
                }
                HStack (spacing:30){
                    Button("Save to FM") {
                        vm.saveImage()
                    }
                    Button("Delete from FM") {
                        vm.deleteImage()
                    }
                }
                Text(vm.infofmessage)
            
                Spacer()
            }
            .navigationTitle("FileManager")
            
        }
    }
}

struct FlieManagerBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        FlieManagerBootCamp()
    }
}
