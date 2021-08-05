//
//  TestViewController.swift
//  CrossStreet
//
//  Created by 김희진 on 2021/07/31.
//

import UIKit
import TheAnimation

class ViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds

    var nameArr:[String] = ["car1.png","car2.png","car3.png","car4.png","car5.png","car6.png","car7.png","car8.png","car9.png","car10.png","car11.png" ,"car12.png","car13.png","car14.png","car15.png","car16.png","car17.png","car18.png","car19.png","car20.png"]

    var nameArrReverse:[String] = ["rcar1.png","rcar2.png","rcar3.png","rcar4.png","rcar5.png","rcar6.png","rcar7.png","rcar8.png","rcar9.png","rcar10.png","rcar11.png" ,"rcar12.png","rcar13.png","rcar14.png","rcar15.png","rcar16.png","rcar17.png","rcar18.png","rcar19.png","rcar20.png"]


    let player1 = CALayer()
    
    var nowPika = 5

    
    @IBOutlet var viewLoad1: UIView!
    @IBOutlet var viewLoad2: UIView!
    @IBOutlet var viewLoad3: UIView!
    @IBOutlet var viewLoad4: UIView!
    
    @IBOutlet var txtTime: UILabel!
    @IBOutlet var modalView: UIView!
    @IBOutlet var txtStage: UILabel!
    
    
    var timer = Timer()
 
    var secondPassed1 = 0
    var saveTime = 0
    var difficulty = ""
    var stage = 0
    var character = ""


    var randomCarSpeend1 = 0
    var randomCarSpeend2 = 0
    var randomCarSpeend3 = 0
    var randomCarSpeend4 = 0
    
    
    @IBOutlet var modalImage: UIImageView!
    @IBOutlet var modalText: UILabel!
    @IBOutlet var modalText2: UILabel!
    
    @IBOutlet var modalBtn1: UIButton!
    @IBOutlet var modalBtn2: UIButton!
    
    
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        player1.contents = UIImage(named: character + ".png")?.cgImage
        player1.frame = CGRect(x: screenSize.width / 2 - 45 , y: screenSize.height / 2 - 45, width: 90, height: 90)

        view.layer.addSublayer(player1)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        secondPassed1 = saveTime
        
        stage += 1
        
        txtStage.text = "STAGE \(stage)"
        
        timer.invalidate()

        randomCarSpeend1 = Int.random(in: 8...20)
        randomCarSpeend2 = Int.random(in: 9...25)
        randomCarSpeend3 = Int.random(in: 10...15)
        randomCarSpeend4 = Int.random(in: 11...30)
        
        
        
        randomCarSpeend1 -= stage
        randomCarSpeend2 -= stage
        randomCarSpeend3 -= stage
        randomCarSpeend4 -= stage

        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {

                self.timer.invalidate()

                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.checkBomb(_:_:)), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        timer.invalidate()

        viewLoad1.removeFromSuperview()
        viewLoad2.removeFromSuperview()
        viewLoad3.removeFromSuperview()
        viewLoad4.removeFromSuperview()

    }
        


    @IBAction func btnLeft(_ sender: Any) {
        
        if(nowPika == 5){
            nowPika = 2
            player1.position.x = viewLoad2.layer.position.x
        }
        else {
            if(nowPika == 1){
                return
            }
            else if(nowPika == 2){
                player1.position.x = viewLoad1.layer.position.x
                checkAccd(viewLoad1!, randomCarSpeend1)
            }
            else if(nowPika == 3){
                player1.position.x = viewLoad2.layer.position.x
                checkAccd(viewLoad2!, randomCarSpeend2)
            }
            else if(nowPika == 4 ){
                player1.position.x = viewLoad3.layer.position.x
                checkAccd(viewLoad3!, randomCarSpeend3)
            }
            nowPika -= 1
        }
    }
    
    
    
    @IBAction func btnRight(_ sender: Any) {
        
        
        if(nowPika == 5){
            nowPika = 3
            player1.position.x = viewLoad3.layer.position.x
        }
        else {
            if(nowPika == 4){
                return
            }
            else if(nowPika == 3){
                player1.position.x = viewLoad4.layer.position.x
                checkAccd(viewLoad4!, randomCarSpeend4)
            }
            else if(nowPika == 2){
                player1.position.x = viewLoad3.layer.position.x
                checkAccd(viewLoad3!, randomCarSpeend3)
            }
            else if(nowPika == 1 ){
                player1.position.x = viewLoad2.layer.position.x
                checkAccd(viewLoad2!, randomCarSpeend2)
            }
            nowPika += 1
        }
    }
    
    
    @IBAction func btnUp(_ sender: Any) {
        
        player1.position.y -= 20
        
        if(nowPika == 1){
            checkAccd(viewLoad1!, randomCarSpeend1)

        }
        else if(nowPika == 2){
            checkAccd(viewLoad2!, randomCarSpeend2)

        }

        else if(nowPika == 3){
            checkAccd(viewLoad3!, randomCarSpeend3)
        }

        else if(nowPika == 4){
            checkAccd(viewLoad4!, randomCarSpeend4)
        }
        
    }
    
    
    @IBAction func btnDown(_ sender: Any) {
        
        player1.position.y += 20
        
        if(nowPika == 1){
            checkAccd(viewLoad1!, randomCarSpeend1)

        }
        else if(nowPika == 2){
            checkAccd(viewLoad2!, randomCarSpeend2)

        }

        else if(nowPika == 3){
            checkAccd(viewLoad3!, randomCarSpeend3)
        }

        else if(nowPika == 4){
            checkAccd(viewLoad4!, randomCarSpeend4)
        }

    }
    
    
    
    

    @objc func checkAccd(_ line:Any, _ speed: Int){
        
        print("thread checking Accident...")
        

        if((line as AnyObject).layer.sublayers != nil){
            for i in (line as AnyObject).layer.sublayers!{
                
                let a = i.presentation()?.position.y
                let c = (line as AnyObject).position.x
//                let playerx = player1.position.x
                if(a != nil && Int(a ?? 0) == 941 || Int(a ?? 0) < Int(player1.position.y)) {
                    continue
                }
                
                if (Int(c) == Int(player1.position.x) && a != nil && Int(a!) - Int(player1.position.y)  > -90 + (30 - speed) && Int(a!) - Int(player1.position.y) < 90 + (30 - speed)){
//                    print(Int(a!) - Int(player1.position.y))
                    print("!!!!!!!!!!!VVVVVaaaaaaaammmmm!!!!!!!!!!!!")
                    

                    timer.invalidate()

//                    viewLoad1.removeFromSuperview()
//                    viewLoad2.removeFromSuperview()
//                    viewLoad3.removeFromSuperview()
//                    viewLoad4.removeFromSuperview()
                    
                    showGameOver()
                }
            }

        }
    
    }


    
    @objc func checkBomb(_ idx:Int, _ speed: Int){

        print("------count down timer : \(secondPassed1)--------")
        
        if secondPassed1 > 0 {
                        
            if(secondPassed1 % 5 == 0) {

                DispatchQueue.global(qos: .userInitiated).async {
                    
                    
                    DispatchQueue.main.async { [self] in
                        self.makeFirstLine(viewLoad1! , randomCarSpeend1)
                    }
                    DispatchQueue.main.async { [self] in
                        self.makeFirstLine(viewLoad2! , randomCarSpeend2)
                    }

//                    DispatchQueue.main.async { [self] in
//                        self.makeFirstLine(viewLoad3!, randomCarSpeend3)
//                    }
//
//                    DispatchQueue.main.async { [self] in
//                        self.makeFirstLine(viewLoad4!, randomCarSpeend4)
//                    }

                    DispatchQueue.main.async { [self] in
                        self.makeSecondLine(viewLoad3!, randomCarSpeend3)
                    }

                    DispatchQueue.main.async { [self] in
                        self.makeSecondLine(viewLoad4!, randomCarSpeend4)
                    }

                }
            }
            DispatchQueue.main.async {
                self.checkAccd(self.viewLoad1!, self.randomCarSpeend1)
            }
            DispatchQueue.main.async {
                self.checkAccd(self.viewLoad2!, self.randomCarSpeend2)
            }
            DispatchQueue.main.async {
                self.checkAccd(self.viewLoad3!, self.randomCarSpeend3)
            }
            DispatchQueue.main.async {
                self.checkAccd(self.viewLoad4!, self.randomCarSpeend4)
            }
            secondPassed1 -= 1
            txtTime.text = String(secondPassed1)
            
            
        }else{
                        
           timer.invalidate()
  
            showClear()

        }
        
    }
    
    
    func label1( _ speed: Int, _ line: Any){
            
        print("\(line) make car")
        
        let subLayer = CALayer()
        
        let randomCarName = nameArr.randomElement()
        
        subLayer.contents = UIImage(named: randomCarName!)?.cgImage
        
        subLayer.frame = CGRect(x: 15 , y: self.screenSize.height , width: 60, height: 90)
                                    
        let animation = BasicAnimation(keyPath: .position)

            animation.fromValue = subLayer.position
            animation.toValue = CGPoint(x: subLayer.position.x , y: -45 )

        animation.duration = TimeInterval(speed)
            
        animation.animate(in: subLayer)
            
        (line as AnyObject).layer.addSublayer(subLayer)
        
    }

    
    func label2( _ speed: Int, _ line: Any){
            
        print("\(line) make car")
        
        let subLayer = CALayer()
        
        let randomCarName = nameArrReverse.randomElement()
        
        subLayer.contents = UIImage(named: randomCarName!)?.cgImage
        
        subLayer.frame = CGRect(x: 15 , y: self.screenSize.height , width: 60, height: 90)
                                    
        let animation = BasicAnimation(keyPath: .position)

            animation.fromValue = CGPoint(x: subLayer.position.x , y: -45 )
            animation.toValue = subLayer.position

        animation.duration = TimeInterval(speed)
            
        animation.animate(in: subLayer)
            
        (line as AnyObject).layer.addSublayer(subLayer)
        
    }

    
    func makeFirstLine(_ line: Any, _ sameSpeed: Int){
            
        if ( (secondPassed1 == 59  || secondPassed1 == 60)  || (secondPassed1 == 39 || secondPassed1 == 40) || (secondPassed1 == 29 || secondPassed1 == 39) ){

            self.label1(sameSpeed, line)

        }else{
            DispatchQueue.main.async() {
                self.label1(sameSpeed, line)

            }
        }
    }
    
    
    func makeSecondLine(_ line: Any, _ sameSpeed: Int){
        
        if ( (secondPassed1 == 59  || secondPassed1 == 60)  || (secondPassed1 == 39 || secondPassed1 == 40) || (secondPassed1 == 29 || secondPassed1 == 39) ){

            self.label2(sameSpeed, line)

        }else{
            
            DispatchQueue.main.async() {
                self.label2(sameSpeed, line)
            }
        }
    }
    
    
    
    func showGameOver(){

        modalImage.image = UIImage(named: "gameOver")
 
        modalText2.text = "\(difficulty) mode, stage \(stage)"
        modalText.text = "play time : \( (difficulty == "basic" ? 30 : difficulty == "intermediate" ? 40 : 60 ) * stage - secondPassed1 )s"
        
        modalBtn1.backgroundColor = UIColor.gray
        modalBtn1.setTitleColor(UIColor.black, for: .normal)
        modalBtn1.setTitle("Go Main", for: .normal)

        
        modalBtn2.backgroundColor = UIColor.red
        modalBtn2.setTitleColor(UIColor.yellow, for: .normal)
        modalBtn2.setTitle("Try again", for: .normal)

        modalView.isHidden = false

    }
    
    
    func showClear(){

        modalImage.image = UIImage(named: "stageClear")
 
        modalText2.text = "\(difficulty) mode, stage \(stage)"
        modalText.text = "play time : \( (difficulty == "basic" ? 30 : difficulty == "intermediate" ? 40 : 60 ) * stage - secondPassed1 )s"

        modalBtn1.backgroundColor = UIColor.gray
        modalBtn1.setTitleColor(UIColor.black, for: .normal)
        modalBtn1.setTitle("Go Main", for: .normal)

        
        modalBtn2.backgroundColor = UIColor.yellow
        modalBtn2.setTitleColor(UIColor.red, for: .normal)
        modalBtn2.setTitle("GO To Next Stage", for: .normal)

        modalView.isHidden = false

    }
    
  
    
    @IBAction func goToMain(_ sender: Any) {
        modalView.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func goToNextStage(_ sender: Any) {
        
        if (modalBtn2.titleLabel!.text == "GO To Next Stage"){
            viewWillAppear(true)
        }
        
        else if (modalBtn2.titleLabel!.text == "Try again"){
            stage = 0
            viewWillAppear(true)
        }
        
        modalView.isHidden = true

    }
}
