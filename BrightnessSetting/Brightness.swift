//
//  Brightness.swift
//  BrightnessSetting
//
//  Created by mac on 27.07.2023.
//

import Alloy

final class Brightness {
    let pipelineState: MTLComputePipelineState
    
    init(library: MTLLibrary) throws {
        self.pipelineState = try library.computePipelineState(function: "brightness")
    }
    
    func encode(source: MTLTexture,
                destination: MTLTexture,
                intensity: Float,
                commandBuffer: MTLCommandBuffer) {
        
        commandBuffer.compute { encoder in
            encoder.setTextures([source, destination])
            encoder.setValue(intensity, at: 0)
            encoder.dispatch2d(state: self.pipelineState, exactly: destination.size)
        }
    }
}
