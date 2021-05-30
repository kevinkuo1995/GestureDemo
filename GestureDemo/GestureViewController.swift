//
//  GestureViewController.swift
//  GestureDemo
//
//  Created by DEVV on 2021/5/29.
//

import UIKit

enum GestureType: String, CaseIterable {
    case long = "long"
    case pinch = "pinch"
    case rotate = "rotate"
}

class GestureViewController: UIViewController {
    
    private lazy var gestureView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let type: GestureType
    
    init(type: GestureType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(gestureView)
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        gestureView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        gestureView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        gestureView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gestureView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        addGesture()
    }
    
    private func addGesture() {
        
        let gesture: UIGestureRecognizer
        
        switch type {
        case .long:
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))

            gesture = longPress
        case .pinch:
            let pinchPress = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
            gesture = pinchPress
        case .rotate:
            let longPress = UIRotationGestureRecognizer(target: self, action: #selector(rotateGesture))
            gesture = longPress
        }
        
        gestureView.addGestureRecognizer(gesture)
        gestureView.isUserInteractionEnabled = true
        
    }
    
    private var startPoint: CGPoint = .zero

    @objc private func longGesture(sender: UILongPressGestureRecognizer) {
        
        
        switch sender.state {
        
        case .began:
            startPoint = sender.location(in: view)
        case .changed:
            var center = gestureView.center
            let change = sender.location(in: view)
            let changeX = change.x - startPoint.x
            let changeY = change.y - startPoint.y
            center.x += changeX
            center.y += changeY
            gestureView.center = center
            startPoint = change
        case .ended:
            print("ended")
        default:
            break
        }
        
    }
    
    @objc private func pinchGesture(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        gestureView.transform = .init(scaleX: scale, y: scale)
    }
    
    @objc private func rotateGesture(sender: UIRotationGestureRecognizer) {
        let ratation = sender.rotation
        gestureView.transform = .init(rotationAngle: ratation)
    }

}
