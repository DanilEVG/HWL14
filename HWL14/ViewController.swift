//
//  ViewController.swift
//  HWL14
//
//  Created by Даниил Евгеньевич on 12.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        view.endEditing(false)
    }
    
    
    @IBOutlet var stackViewHeightConstr: [NSLayoutConstraint]!
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        print("keyboard ")
        
        let keyboardTop = view.frame.height - view .convert(frame, from: nil).minY
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTop, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTop - scrollView.safeAreaInsets.bottom , right: 0)
        if keyboardTop > 0 {
            NSLayoutConstraint.deactivate(stackViewHeightConstr)
        } else {
            NSLayoutConstraint.activate(stackViewHeightConstr)
        }
    }
    
    
}

