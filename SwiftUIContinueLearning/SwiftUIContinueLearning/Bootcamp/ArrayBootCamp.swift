//
//  ArrayBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 29/09/22.
//

import SwiftUI

struct UserModel : Identifiable {
    var id : String = UUID().uuidString
    var name :String
    var points : Int
    let isVarified : Bool
}
class ArrayBootCampViewModel: ObservableObject{
    @Published var data : [UserModel] = []
    @Published var filterdata : [UserModel] = []
    @Published var mapdata : [String] = []
    init(){
        getUser()
        getfilterUser ()
    }
    func getUser () {
        let user = UserModel(name: "name1", points: 1, isVarified: true)
        let user2 = UserModel(name: "name2", points: 2, isVarified: false)
        let user3 = UserModel(name: "name3", points: 3, isVarified: true)
        let user4 = UserModel(name: "name4", points: 4, isVarified: false)
        let user5 = UserModel(name: "name5", points: 5, isVarified: true)
        data.append(user)
        data.append(user2)
        data.append(user3)
        data.append(user4)
        data.append(user5)
    }
    func getfilterUser () {
        //sort

//        filterdata = data.sorted(by: { obj1, obj2 in
//           return obj1.points < obj2.points
//        })
//        filterdata = data.sorted(by : {$0.points > $1.points})
        
        
        //filter
        
        filterdata = data.filter({ user in
            return user.isVarified  // user.points > 3
        })
        filterdata = data.filter({$0.isVarified})
        
        //map
//       mapdata =  data.map ({ (user) -> String in
//            return user.name
//        })
        mapdata = data.map({$0.name})
        mapdata = data.compactMap({$0.name})
    }
}
struct ArrayBootCamp: View {
    @StateObject var vm : ArrayBootCampViewModel = ArrayBootCampViewModel()
    var body: some View {
        ScrollView {
            VStack  {
                //vm.data
                ForEach(vm.filterdata) { item in
                    VStack(spacing:10)
                    {
                        Text(item.name)
                        Text("\(item.points)")
                        Text("\(item.isVarified.description)")
                        
                    }
                    
                }
            }
            
        }
    }
}

struct ArrayBootCamp_Previews: PreviewProvider {
    
    static var previews: some View {
        ArrayBootCamp()
    }
}
