//
//  ViewController.swift
//  TMSHomework-Lesson41
//
//  Created by Наталья Мазур on 19.05.24.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    enum Constants {
        static let circleSide: CGFloat = 50
        static let circleRadius: CGFloat = circleSide / 2
    }
    
    let motionManager = CMMotionManager()
    
    private lazy var circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = .red
        circle.frame = CGRect(x: view.frame.midX - Constants.circleRadius, y: view.frame.midY - Constants.circleRadius, width: Constants.circleSide, height: Constants.circleSide)
        circle.layer.cornerRadius = Constants.circleRadius
        return circle
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 2
        label.frame = CGRect(x: view.frame.minX + 20, y: view.frame.maxY - 150, width: view.frame.width - 40, height: 60)
        return label
    }()
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(circle)
        view.addSubview(label)
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    private func moveCirle() {
        motionManager.startAccelerometerUpdates()
        
        let minX = min(max(circle.frame.minX - (motionManager.accelerometerData?.acceleration.x ?? 0 * 30), view.frame.minX), view.frame.maxX - Constants.circleSide)
        let minY = min(max(circle.frame.minY + (motionManager.accelerometerData?.acceleration.y ?? 0 * 30), view.frame.minY), view.frame.maxY - Constants.circleSide)
        
        label.text = "circle's min x: \(minX)\ncircle's min y: \(minY)"
        
        circle.frame = CGRect(x: minX, y: minY, width: Constants.circleSide, height: Constants.circleSide)
    }
    
    @objc func update() {
        moveCirle()
    }
    
}

