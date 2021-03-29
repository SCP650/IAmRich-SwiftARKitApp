//
//  ARViewRepresentable.swift
//  AR Photo
//
//  Created by Atlas on 3/26/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewRepresentable: UIViewRepresentable {
    @Binding var disableUI: Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
        arView.enableTapGesture()
//        let floor = ModelEntity(mesh: .generateBox(size: [1000, 0, 1000]), materials: [SimpleMaterial()])
//        floor.generateCollisionShapes(recursive: true)
//        if let collisionComponent = floor.components[CollisionComponent] as? CollisionComponent {
//            floor.components[PhysicsBodyComponent] = PhysicsBodyComponent(shapes: collisionComponent.shapes, mass: 0, material: nil, mode: .static)
//            floor.components[ModelComponent] = nil // make the floor invisible
//        }
//        let anchorEntity = AnchorEntity(world: SIMD3<Float>(0,0,0))
//        anchorEntity.addChild(floor)
//        arView.scene.addAnchor(anchorEntity)
        return  arView
        
    }
    func placeCube(at position: SIMD3<Float>, uiView:ARView){
    
        
        let boxAnchor = try! Experience.loadBox()
//        boxAnchor.position = position
//        uiView.scene.addAnchor(boxAnchor)
        
       let boxModelEntity = boxAnchor.steelBox?.children[0] as! ModelEntity
       boxModelEntity.generateCollisionShapes(recursive: true)
//        if let collisionComponent = boxModelEntity.components[CollisionComponent] as? CollisionComponent {
//            boxModelEntity.components[PhysicsBodyComponent] = PhysicsBodyComponent(shapes: collisionComponent.shapes, mass: 1, material: nil, mode: .dynamic)
//            }
        
       
       let anchorEntity = AnchorEntity(world: position)
       anchorEntity.addChild(boxModelEntity)
       
       uiView.scene.addAnchor(anchorEntity)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
       
        if(disableUI){
          uiView.scene.anchors.removeAll()
        }
////            // Load the "Box" scene from the "Experience" Reality File
////        let boxAnchor = try! Experience.loadBox()
////            boxAnchor.position.y = 0.1
////////
////        let boxModelEntity = boxAnchor.steelBox?.children[0] as! ModelEntity
//////            let blueMaterial = SimpleMaterial(color: .yellow, isMetallic: true)
//////            boxModelEntity.model?.materials = [blueMaterial]
//////            // Add the box anchor to the scene
////            uiView.scene.anchors.append(boxAnchor)
//        let taplocation = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
//        guard let rayResult = uiView.ray(through: taplocation) else {return}
//        let results = uiView.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
//        if let firstResult = results.first{
//            var position = firstResult.position
//            position.y  += 0.004
//            placeCube(at: position,uiView: uiView)
//            print("Cube present")
//        }else{
//            let results = uiView.raycast(from: taplocation, allowing: .estimatedPlane, alignment: .any)
//            if let firstResult = results.first{
//                print("No cube present")
//                let position = simd_make_float3(firstResult.worldTransform.columns.3)
//                placeCube(at:position,uiView: uiView)
//            }
//        }
        
//
//
//        }
     
   
    }
    
}

extension CustomARView{
    func enableTapGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func handleTap(recognizer:UITapGestureRecognizer ){
        let taplocation = recognizer.location(in: self)

        guard let rayResult = self.ray(through: taplocation) else {return}
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        if let firstResult = results.first{
            var position = firstResult.position
            position.y  +=  0.004
            placeCube(at: position)
            print("Cube present")
        }else{
            let results = self.raycast(from: taplocation, allowing: .estimatedPlane, alignment: .any)
            if let firstResult = results.first{
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                placeCube(at:position)
                print("No Cube present")
            }
        }


    }
    func placeCube(at position: SIMD3<Float>){
        let boxAnchor = try! Experience.loadBox()
        let boxModelEntity = boxAnchor.steelBox?.children[0] as! ModelEntity
        boxModelEntity.generateCollisionShapes(recursive: true)
        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(boxModelEntity)
        self.scene.addAnchor(anchorEntity)
    }
}


