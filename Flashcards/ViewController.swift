//
//  ViewController.swift
//  Flashcards
//
//  Created by Princess Joy on 3/28/20.
//  Copyright © 2020 JoyTijani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //rounded corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        //shadows
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        //button rounded edges
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.6106028324, green: 0.4600939403, blue: 0.658982351, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.6106028324, green: 0.4600939403, blue: 0.658982351, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.6106028324, green: 0.4600939403, blue: 0.658982351, alpha: 1)
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == false){
            frontLabel.isHidden = true
        }else if(frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        frontLabel.isHidden = false
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        frontLabel.isHidden = false
    }
    
}

