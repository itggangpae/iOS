//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Mac on 2021/02/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        .previewDisplayName("iPhone SE")
        .environment(\.colorScheme, .dark)
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        .previewDisplayName("iPhone 11")
        }
    }
}
