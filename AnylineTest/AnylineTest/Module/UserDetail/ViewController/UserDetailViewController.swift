//
//  UserDetailViewController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    var user: User? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        nameLabel?.text = user?.name
        user?.imageUrl?.image(completion: { [weak self] (image, data) in
            DispatchQueue.main.async {
                self?.avatarImageView?.image = image
            }
        })
    }
    
    @IBAction func followersButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func reposButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func subscriptionButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func eventsButtonAction(_ sender: UIButton) {
    }

}
