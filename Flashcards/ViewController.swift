//
//  ViewController.swift
//  Flashcards
//
//  Created by Princess Joy on 3/28/20.
//  Copyright © 2020 JoyTijani. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
}

class ViewController: UIViewController {

    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //current flashcard index
    var currentIndex = 0
    
    //Button to remember what the correct answer is
    var correctAnswerButton: UIButton!
    
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
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is a Class?", answer: "A Blueprint", extraAnswerOne: "An instance", extraAnswerTwo: "What you do at school", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionOne.alpha = 0.0
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionTwo.alpha = 0.0
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionThree.alpha = 0.0
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        //Animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            self.btnOptionOne.alpha = 1.0
            self.btnOptionOne.transform = CGAffineTransform.identity
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionTwo.transform = CGAffineTransform.identity
            self.btnOptionThree.alpha = 1.0
            self.btnOptionThree.transform = CGAffineTransform.identity
        })
    }
    
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        if currentIndex > 0 {
            currentIndex = currentIndex - 1
        
            //update buttons
            updateNextPrevButtons()
            
            animateCardOut()
            
            btnOptionOne.isEnabled = true
            btnOptionTwo.isEnabled = true
            btnOptionThree.isEnabled = true
            
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        
        if currentIndex < flashcards.count - 1 {
            currentIndex = currentIndex + 1
        
            //Update buttons
            updateNextPrevButtons()
            
            animateCardOut()
            
            btnOptionOne.isEnabled = true
            btnOptionTwo.isEnabled = true
            btnOptionThree.isEnabled = true
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        //show confirmation
        let alert = UIAlertController(title:"Delete flashcard", message:"Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    func deleteCurrentFlashcard() {
        //Delete current
        flashcards.remove(at: currentIndex)
        
        //Special card: Check if your last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
    }
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            //Update labels
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    func animateCardIn() {
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        }
    }
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if(self.frontLabel.isHidden == false){
                self.frontLabel.isHidden = true
            }else if(self.frontLabel.isHidden == true){
                self.frontLabel.isHidden = false
            }
        })
        
    }
    
    func updateFlashcard(question: String, answer: String,extraAnswerOne: String?,extraAnswerTwo: String?, isExisting: Bool){
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne!,extraAnswerTwo: extraAnswerTwo!)
        
        if isExisting {
            //Replace existing flashcard
            flashcards[currentIndex] = flashcard
        } else {
            //Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            //update current index
            currentIndex = flashcards.count - 1
        }
        
        print("Added new flashcard")
        print("we have \(flashcards.count) flashcards")
        
        //update buttons
        updateNextPrevButtons()
        
        //update labels
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if(currentIndex == 0){
            prevButton.isEnabled = false
        } else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        // Update multiple choice answer buttons
        let buttons = [btnOptionOne,btnOptionTwo,btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer,currentFlashcard.extraAnswerOne,currentFlashcard.extraAnswerTwo].shuffled()
        
        for(button,answer) in zip(buttons,answers) {
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
    }
    
    func saveAllFlashcardsToDisk() {
        //From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question":card.question,"answer":card.answer,"extraAnswerOne":card.extraAnswerOne,"extraAnswerTwo":card.extraAnswerTwo]
        }
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //Log it
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        flashcards = []
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!,extraAnswerOne: dictionary["extraAnswerOne"] ?? "",extraAnswerTwo: dictionary["extraAnswerTwo"] ?? "")
            }
            flashcards.append(contentsOf: savedCards)
        }
        print(flashcards)
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree == correctAnswerButton{
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //destination of segue is the Navigation Control
        let navigationController = segue.destination as! UINavigationController
        
        //navigation controller only contains a creation view controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //set flashcardsController property to self
        creationController.flashcardsController = self
        
        //pass existing question and answer
        if(segue.identifier=="EditSegue"){
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
}

