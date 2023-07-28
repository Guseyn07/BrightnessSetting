//
//  ViewModel.swift
//  BrightnessSetting
//
//  Created by mac on 27.07.2023.
//

import SwiftUI
import Alloy

final class ViewModel: ObservableObject {
    private let defaultImage = UIImage(named: "foo")!
    private let context: MTLContext
    private let library: MTLLibrary
    private let brightness: Brightness
    private let inputTexture: MTLTexture
    
    private(set) var image: UIImage
    private(set) var text: String
    @Published var progress: Float
   
    init() {
        // FIXME: made only for a test project
        self.context = try! MTLContext()
        self.library = try! context.library(for: Brightness.self)
        self.brightness = try! Brightness(library: library)
        self.inputTexture = try! context.texture(from: defaultImage.cgImage!)
        self.progress = 0
        self.image = defaultImage
        self.text = "Intensity 0.0"
    }
    
    func handleSliderEditing() {
        do {
            let outputTexture = try inputTexture.matchingTexture(usage: [.shaderWrite])
            try context.scheduleAndWait({ buffer in
                brightness.encode(source: inputTexture,
                                  destination: outputTexture,
                                  intensity: progress + 1,
                                  commandBuffer: buffer)
            })
            self.image = try outputTexture.image()
            self.text = "Intensity \(round(progress * 10_000) / 100)"
        } catch {
            self.image = defaultImage
        }
    }
}
