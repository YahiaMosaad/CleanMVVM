//
//  LoaderView.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import SwiftUI


struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}
struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
