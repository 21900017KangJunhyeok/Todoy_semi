//
//  DateButton.swift
//  TaskApp
//
//  Created by junhyeok KANG on 2023/02/02.
//

import SwiftUI

struct DateButton: View {
    
    var title : String
    @ObservedObject var memoData : MemoViewModel
    var body: some View {
        
        Button(action: {memoData.updateDate(value: title)}, label: {
            
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(memoData.checkDate() == title ? .white : .gray )
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(
                    memoData.checkDate() == title ?
                    LinearGradient(gradient: .init(colors: [Color.indigo,Color.blue]), startPoint: .leading, endPoint: .trailing)
                    :LinearGradient(gradient: .init(colors: [Color.white]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
        })
    }
}

