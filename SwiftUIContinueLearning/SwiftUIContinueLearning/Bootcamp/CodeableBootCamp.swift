//
//  CodeableBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 30/09/22.
//

import SwiftUI
struct CustomerModel : Identifiable ,Codable{//Decodable ,Encodable
    let name:String
    let point : Int
    let isPremium : Bool
    let id : String
    
//    init(name:String,point : Int,isPremium : Bool,  id : String)
//    {
//        self.isPremium = isPremium
//        self.id = id
//        self.point = point
//        self.name = name
//    }
//    enum CodingKeys: CodingKey {
//        case name
//        case point
//        case isPremium
//        case id
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.point = try container.decode(Int.self, forKey: .point)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//        self.id = try container.decode(String.self, forKey: .id)
//    }
//    func encode(to encoder: Encoder) throws {
//        var container  = encoder.container(keyedBy: CodingKeys.self)
//        try  container.encode(id, forKey: .id)
//        try  container.encode(name, forKey: .name)
//        try  container.encode(isPremium, forKey: .isPremium)
//        try  container.encode(point, forKey: .point)
//    }
}
class CodeableBootCampViewModel:ObservableObject{
    @Published var customer:CustomerModel? = nil
    init() {
        getData()
    }
    func getData () {
        guard let data =  getJsonData() else {
            return
        }
        try?  self.customer = JSONDecoder().decode(CustomerModel.self, from: data)
//        do {
//            try  self.customer = JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print(error)
//        }
       
//       if  let localData = try?JSONSerialization.jsonObject(with:data,options: []),
//           let dict = localData as? [String:Any ],
//           let id = dict["id"] as? String,
//           let name = dict["name"] as? String,
//           let isPremium = dict["isPremium"] as? Bool,
//           let point = dict["point"] as? Int
//        {
//           let neeCustomer = CustomerModel(name: name, point: point, isPremium: isPremium, id: id)
//        }
//        let jsonString = String(data: data, encoding: .utf8)
//        print(jsonString)
    }
    func getJsonData () -> Data? {
//        let dic : [String:Any] = [
//            "id" : "1234",
//            "name": "vipal",
//            "isPremium" : true,
//            "point": 2000
//        ]
        let customer = CustomerModel(name: "ravan", point: 22, isPremium: false, id: "22")
        let jsonData = try? JSONEncoder().encode(customer)
       // let jsonData = try? JSONSerialization.data(withJSONObject:dic , options: [])
        return jsonData
    }
}
struct CodeableBootCamp: View {
    @StateObject var vm : CodeableBootCampViewModel = CodeableBootCampViewModel()
    var body: some View {
        VStack (spacing : 10 ) {
            if let customer = vm.customer {
                Text(customer.name)
                Text(customer.id)
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodeableBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CodeableBootCamp()
    }
}
 
