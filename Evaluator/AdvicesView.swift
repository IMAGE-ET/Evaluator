//
//  AdvicesView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI

struct AdvicesView: View {
    let advices: String
    let lines: [Substring]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var i = 0 // iterator for advices
    
    init(advices: String) {
        self.advices = advices
        self.lines = advices.split(separator: "\t")
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("DialogueBox"))
                .frame(height: 150)
            VStack {
                HStack {
                    Text(lines[i])
                        .font(.title)
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: 150)
        .onTapGesture {
            if (i == lines.count - 1) {
                print("Over")
                self.presentationMode.wrappedValue.dismiss()
            } else {
                i += 1
            }
        }
    }
}

struct AdvicesView_Previews: PreviewProvider {
    static var previews: some View {
        //let advices = "Hello\nThis is some advice\nGit Gud"
        let advices = "This is a very long advice, hero. First, you should avoid to buff yourself, since it will trigger his denying abilities. Items are no good too. Your only path is to overpower it fair and square."
        AdvicesView(advices: advices)
    }
}
