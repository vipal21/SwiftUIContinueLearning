//
//  HashableBootcamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 29/09/22.
//

import SwiftUI

struct Model : Hashable {
    var title  :String
    var id = UUID().uuidString
    func hash(into hasher: inout Hasher) {
        hasher.combine(title) // combine one or more properties
    }
}
struct HashableBootcamp: View {
    let data : [Model] = [Model(title: "title 1"),Model(title: "title 2")]
    var body: some View {
        VStack{
            ForEach(data,id: \.self) { item in
                Text(item.title.hashValue.description)
            }
//            ForEach(data) { item in
//                Text(item.title)
//            }
        }
        
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
