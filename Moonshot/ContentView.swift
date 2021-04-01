//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Knox on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("me")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
