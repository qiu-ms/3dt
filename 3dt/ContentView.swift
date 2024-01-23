//
//  ContentView.swift
//  3dt
//
//  Created by Qiu, Men Seng on 18.12.23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
                // Download contents of imageURL as Data.  Use a URLSession if you want to do this asynchronously.
                let data = try! Data(contentsOf: URL(string: "http://192.168.178.92:8080/hello")!)
                print(data)
                // Write the image Data to the file URL.
                try! data.write(to: fileURL)
        let texture = try? TextureResource.load(contentsOf: fileURL)

                    // Create a material with the texture
                    var material = SimpleMaterial()
        material.color.texture = MaterialParameters.Texture(texture!)

                    // Create a plane entity with the material
                    let plane = ModelEntity(mesh: .generatePlane(width: 0.4, height: 0.4), materials: [material])
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))

        
        sphereAnchor.addChild(plane)
        
        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(sphereAnchor)


        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

#Preview {
    ContentView()
}
