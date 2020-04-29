//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Princess Joy on 3/29/20.
//  Copyright © 2020 JoyTijani. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //get text in question text field
        let questionText = questionTextField.text
        
        //get text in answer text field
        let answerText = answerTextField.text
        let answerOneText = extraAnswerOne.text
        let answerTwoText = extraAnswerTwo.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            //show alert
        let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
        } else{
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!,extraAnswerOne: answerOneText,extraAnswerTwo: answerTwoText, isExisting: isExisting)
            
            dismiss(animated: true)
        }
        
        
    }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
