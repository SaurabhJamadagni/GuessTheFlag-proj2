//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Saurabh Jamadagni on 17/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("1")
                Text("2")
                Text("3")
            }
            
            HStack {
                Text("4")
                Text("5")
                Text("6")
            }
            
            HStack {
                Text("7")
                Text("8")
                Text("9")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
