//
//  ContentView.swift
//  TaskApp
//
//  Created by junhyeok KANG on 2023/02/01.
//

import SwiftUI
import CoreData

struct ContentView: View {
     
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var timerModel: TimerModel

    var body: some View {
//       Memo()
        Stimer()
            .environmentObject(timerModel)
        
    }

    
}

