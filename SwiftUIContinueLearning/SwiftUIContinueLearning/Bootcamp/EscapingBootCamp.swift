//
//  EscapingBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 30/09/22.
//

import SwiftUI
class EscapingViewModel :ObservableObject {
    @Published var text:String = "Hello"
    typealias DownloadComplition = (DownloadResult) -> ()
    func getData(){
        downloadData5 {[weak self] reutrnResult in
            self?.text = reutrnResult.data
        }
//        downloadData3 { [weak self] returndata in
//            self?.text = returndata
//
//        }
    }
    func downloadData () -> String  {
        return "New Data..!"
    }
    func downloadData2 (complitionHandler: ( _ data : String) -> Void )  {
        complitionHandler("New Data..!")
    }
    func downloadData3 (complitionHandler: @escaping ( _ data : String) -> Void )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            complitionHandler("New Data..!")
        }
      
    }
    func downloadData4 (complitionHandler: @escaping (DownloadResult) -> Void )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let result =  DownloadResult(data: "New Data..!")
            complitionHandler(result)
        }
      
    }
    func downloadData5 (complitionHandler: @escaping DownloadComplition )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let result =  DownloadResult(data: "New Data..!")
            complitionHandler(result)
        }
      
    }
}
struct DownloadResult {
    let data : String
}
struct EscapingBootCamp: View {
    @StateObject var vm:EscapingViewModel = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
    }
}

struct EscapingBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootCamp()
    }
}
