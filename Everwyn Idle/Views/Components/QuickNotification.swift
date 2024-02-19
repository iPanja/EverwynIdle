//
//  QuickNotification.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/11/23.
//

import SwiftUI

struct QuickNotification: View {
    @Binding var message: String?
    @State var fgColor: Color = .white
    @State var bgColor: Color = .lightGreen
    @State var duration: Double = 3.0
    
    @State var timer: Timer?
    
    var body: some View {
        if let msg = message{
            Rectangle()
                .fill(bgColor)
                .frame(maxHeight: 50)
                .overlay{
                    Text(msg)
                        .foregroundStyle(fgColor)
                }
                .transition(.move(edge: .top))
                .onAppear{
                    createTimer()
                }.onDisappear{
                    timer?.invalidate()
                }.onChange(of: message){
                    if message != .none{
                        timer?.invalidate()
                        createTimer()
                    }
                }
        }
    }
    
    func reset() {
        withAnimation{
            message = .none
        }
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: {_ in
            reset()
        })
    }
}

#Preview {
    QuickNotification(message: .constant("TEST"))
}
