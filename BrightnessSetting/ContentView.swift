//
//  ContentView.swift
//  BrightnessSetting
//
//  Created by mac on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
            Spacer(minLength: 32)
            Text(viewModel.text)
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Slider(value: $viewModel.progress, in: 0...1) { _ in
                viewModel.handleSliderEditing()
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
