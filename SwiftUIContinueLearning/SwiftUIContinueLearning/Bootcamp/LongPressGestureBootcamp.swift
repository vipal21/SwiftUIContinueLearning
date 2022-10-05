//
//  LongPressGestureBootcamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 27/09/22.
//

import Foundation
import SwiftUI
struct LongPressGestureBootcamp: View {
    @State private var isComplated = false
    @State private var isSucess = false
    var body: some View {
        VStack {
            //EX -1
//            Text("Hello, world!")
//                .padding()
//                .padding(.horizontal)
//                .background( isComplated ? .green : .gray)
//                .cornerRadius(10)
//            //                .onTapGesture {
//            //                    isComplated.toggle()
//            //                }
//                .onLongPressGesture(minimumDuration: 2.0,
//                                    maximumDistance: 50) {
//                    isComplated.toggle()
//                }
            
            //EX : 2
            Rectangle()
                .fill(isSucess ? Color.green : Color.blue)
                .frame(maxWidth: isComplated ? .infinity : 0)
                .frame(height: 55)
                .background(Color.green)
                .frame(maxWidth:  .infinity ,alignment: .leading)
                .background(Color.gray)
                

            HStack (spacing: 10){
                Text("Click Here")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .onLongPressGesture(minimumDuration: 1.0,
                                        maximumDistance: 50) { (isPressing) in
                        // start of press to min duration
                       if isPressing {
                           withAnimation(.easeInOut(duration: 1.0)){
                               isComplated = true
                               
                           }
                           
                       }else {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                               if !isSucess {
                                   withAnimation(.easeIn(duration: 1.0)){
                                       isComplated = false
                                   }
                               }
                           }
                       }
                    } perform: {
                        // at min duration
                        withAnimation(.easeIn(duration: 1.0)){
                            isComplated = true
                            isSucess = true
                        }
                    }
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black).onTapGesture {
                        withAnimation(.easeIn(duration: 1.0)){
                            isComplated = false
                            isSucess = false
                        }
                    }
            }
            
           
               
        }
      
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
