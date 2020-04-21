//
//  ReviewTableViewController.swift
//  Snacktacular
//
//  Created by Kyle Gangi on 4/15/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import UIKit
import Firebase

class ReviewTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var postedByLabel: UILabel!
    
    @IBOutlet weak var reviewTitleField: UITextField!
    
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var buttonsBackgroundView: UIView!
    
    var spot: Spot!
    var review: Review!
    
    let dateFormatter = DateFormatter()
    
    
    var rating = 0{
        didSet{
            for starButton in starButtonCollection{
                let image = UIImage(named: (starButton.tag < rating ? "star-filled": "star-empty"))
                starButton.setImage(image, for: .normal)
            }
            review.rating = rating
        }
    }
    
    
    @IBOutlet var starButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
        
        guard spot != nil else{
            print("Error, not valid spot in reviews")
            return
        }
   
        if review == nil {
            review = Review()
        }
        
        updateUserInterface()
    }
    
    func updateUserInterface(){
        nameLabel.text = spot.name
        addressLabel.text = spot.address
        rating = review.rating
        reviewTitleField.text = review.title
        enableDisbaleSaveButton()
        reviewTextView.text = review.text
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        reviewDateLabel.text = "posted: \(dateFormatter.string(from: review.date))"
        
        if review.documentID == ""{
            addBordersToEditableObjects()
        
        } else{
            if review.reviewerUserID == Auth.auth().currentUser?.email{
                self.navigationItem.leftItemsSupplementBackButton = false
                saveBarButton.title = "Update"
                addBordersToEditableObjects()
                deleteButton.isHidden = false
            }
            else{
                cancelBarButton.title = ""
                saveBarButton.title = ""
                postedByLabel.text = "Posted by: \(review.reviewerUserID)"
                for starButton in starButtonCollection{
                    starButton.backgroundColor = UIColor.white
                    starButton.adjustsImageWhenDisabled = false
                    starButton.isEnabled = false
                    reviewTitleField.isEnabled = false
                    reviewTextView.isEditable = false
                    reviewTitleField.backgroundColor = UIColor.white
                    reviewTextView.backgroundColor = UIColor.white
                }
            }
            
        }
        
        
        
        
    }
    
    func addBordersToEditableObjects(){
        reviewTitleField.addBorder(width: 0.5, radius: 5.0, color: .black)
        reviewTextView.addBorder(width: 0.5, radius: 5.0, color: .black)
        buttonsBackgroundView.addBorder(width: 0.5, radius: 5.0, color: .black)
    }
    
    func enableDisbaleSaveButton(){
        if reviewTitleField.text != ""{
            saveBarButton.isEnabled = true
        }
        else{
            saveBarButton.isEnabled = false
        }
    }
    
    func saveThenSegue(){
        review.title = reviewTitleField.text!
               review.text = reviewTextView.text!
               review.saveData(spot: spot) { (success) in
                   if success {
                       self.leaveViewController()
                   }else{
                     print("Error")
                   }
               }
    }
    
    func leaveViewController(){
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func starButtonPressed(_ sender: UIButton) {
        rating = Int(sender.tag + 1)
        
    }
    
    
    
    
    @IBAction func reviewTitleChanged(_ sender: UITextField) {
        enableDisbaleSaveButton()
    }
    
    
    @IBAction func returnTitleDonePressed(_ sender: UITextField) {
        saveThenSegue()
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
       saveThenSegue()
        }
    

  
}
