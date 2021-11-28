//
//  ErrorView.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import SwiftUI

struct ErrorView: View {
    let error: Error

    var body: some View {
        print(error)
        return Text("Error").font(.system(size: 60))    }
}
#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.generalError)
    }
}
#endif
