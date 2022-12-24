//
//  EvaluationView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI
import AVKit // For Audio

struct TmpBeast {
    let player: String?
    let chara: String?
    
    let advices: String?
}

struct EvaluationView: View {
    @State var audioPlayer: AVAudioPlayer!
    
    let beast: Beast
    //let beast: TmpBeast
    let sound = Bundle.main.path(forResource: "Monster Girl Quest OST - 02 Ilias", ofType: "mp3")
    
    var body: some View {
        ZStack {
            Image("bg001")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                Spacer()
                Image("80_iriasu_st01")
                    .frame(maxWidth: .infinity)
                AdvicesView(advices: (beast.advices ?? "Git gud"))
            }
            .onAppear {
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
            }
        }
    }
}
/*
struct EvaluationView_Previews: PreviewProvider {
    
    static var previews: some View {
        EvaluationView(beast: TmpBeast(player: "Clement", chara: "Ganondorf", advices: "Heed my words\tGit gud"))
    }
}
*/
