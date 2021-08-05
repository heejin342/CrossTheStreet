//
//  MainViewController.swift
//  CrossTheStreet
//
//  Created by 김희진 on 2021/08/03.
//

import UIKit
import TheAnimation


class MainViewController: UIViewController {

    
    @IBOutlet var imgView: UIView!
    
    @IBOutlet var characterModal: UIView!
    
    @IBOutlet var pika: UIImageView!
    
    @IBOutlet var sonic: UIImageView!
    
    @IBOutlet var naruto: UIImageView!
        
    @IBOutlet var basic: UIButton!
    
    @IBOutlet var intermediate: UIButton!
    
    @IBOutlet var advanced: UIButton!
    
    let vc: UIViewController? = nil
    
    var time : Int = 0
    var difficulty : String = ""
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        // logo animation
        let subLayer = CALayer()
        
        subLayer.contents = UIImage(named: "logo")?.cgImage
        
        subLayer.frame = CGRect(x: 50 , y: 50 , width: 350, height: 250)

        let animation = BasicAnimation(keyPath: .position)

        animation.fromValue = CGPoint(x: 225, y: 175)

        animation.toValue = CGPoint(x: 225, y: 270)
        animation.duration = 1
        animation.timingFunction = .easeInEaseOut
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        animation.autoreverses = true
        animation.repeatCount = 3
        animation.animate(in: subLayer)

        imgView.layer.addSublayer(subLayer)
        

        
        // manage character
        
        let tapPika = UITapGestureRecognizer(target: self, action: #selector(self.handleTapPika(_:)))

        pika.isUserInteractionEnabled = true
        pika.addGestureRecognizer(tapPika)

        
        let tapSonic = UITapGestureRecognizer(target: self, action: #selector(self.handleTapSonic(_:)))

        sonic.isUserInteractionEnabled = true
        sonic.addGestureRecognizer(tapSonic)

        let tapNaruto = UITapGestureRecognizer(target: self, action: #selector(self.handleTapNaruto(_:)))

        naruto.isUserInteractionEnabled = true
        naruto.addGestureRecognizer(tapNaruto)

        
    }
    
    @objc func handleTapPika(_ sender: UITapGestureRecognizer) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        vc.character = "pika"
        vc.saveTime = time
        vc.difficulty = difficulty
        
        
        characterModal.isHidden = true
        
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @objc func handleTapSonic(_ sender: UITapGestureRecognizer) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        vc.character = "sonic"
        vc.saveTime = time
        vc.difficulty = difficulty

        
        characterModal.isHidden = true
        
        self.navigationController?.pushViewController(vc, animated: true)


    }

    @objc func handleTapNaruto(_ sender: UITapGestureRecognizer) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        vc.saveTime = time
        vc.difficulty = difficulty

        
        vc.character = "naruto"


        characterModal.isHidden = true
        
        self.navigationController?.pushViewController(vc, animated: true)

        
    }

    
    
    

    @IBAction func goBasic(_ sender: UIButton) {

        intermediate.backgroundColor = nil
        
        advanced.backgroundColor = nil

        basic.backgroundColor = UIColor.gray
                

        characterModal.isHidden = false
        
        time = 30
        difficulty = "basic"
        
        
        
    }
    
    
    @IBAction func goIntermediate(_ sender: UIButton) {

        basic.backgroundColor = nil
        
        advanced.backgroundColor = nil
        
        intermediate.backgroundColor = UIColor.gray


        characterModal.isHidden = false

        time = 40
        difficulty = "intermediate"

    }
    
    
    @IBAction func goAdvanced(_ sender: UIButton) {
        
        basic.backgroundColor = nil
        
        intermediate.backgroundColor = nil
        
        advanced.backgroundColor = UIColor.gray

        characterModal.isHidden = false

        time = 60
        difficulty = "advanced"

    }
        
}

