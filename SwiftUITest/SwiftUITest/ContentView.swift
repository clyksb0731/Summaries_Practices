//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Yongseok Choi on 2020/08/19.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(systemName: "arrow.down").font(.title).padding()
            }
            HStack {
                Spacer()
                Image(systemName: "arrow.right").font(.title).padding()
            }
            Circle().fill(Color.yellow.opacity(0.8))
//                .frame(width: 250, height: 250)
            Text("Joystick").font(.largeTitle)
            ZStack(alignment: .topTrailing) {
                Color.clear
                Image(systemName: "arrow.up.right.circle.fill").font(.title)
            }
            VStack {
                Image(systemName: "arrow.up").font(.title).padding()
                Spacer()
            }
            HStack {
                Image(systemName: "arrow.left").font(.title).padding()
                Spacer()
            }
        }
        .frame(width: 250, height: 250)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
