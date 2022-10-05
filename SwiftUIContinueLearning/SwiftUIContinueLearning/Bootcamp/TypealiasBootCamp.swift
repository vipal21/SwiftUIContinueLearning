//
//  TypealiasBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 30/09/22.
//

import SwiftUI

struct MovieModel {
    let title :String
    let director : String
    let count : Int
    
}

typealias TvModel = MovieModel
struct TypealiasBootCamp: View {
   // @State var item : MovieModel  = MovieModel(title: "MI4", director:"vipal", count: 200)
    @State var item : TvModel  = TvModel(title: "MI4", director:"vipal", count: 200)
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypealiasBootCamp_Previews: PreviewProvider {

    static var previews: some View {
        TypealiasBootCamp()
    }
}
