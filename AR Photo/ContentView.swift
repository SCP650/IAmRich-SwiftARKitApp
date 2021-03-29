//
//  ContentView.swift
//  AR Photo
//
//  Created by Atlas on 3/20/21.
//

import SwiftUI


struct ContentView : View {
    @State private var propText = "Tap anywhere to place gold"
    @State private var disableUI = false
    var body: some View {
        VStack{
            ARViewRepresentable(disableUI: $disableUI).edgesIgnoringSafeArea(.all)
            if (!disableUI){
            VStack{
                Text(propText)
                Button("Screenshot Mode (will clear all objects)"){
                    disableUI = true
                }

            }}
                
        }.onTapGesture {
            propText = "I am rich"
        }
        }
       
    }




#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
