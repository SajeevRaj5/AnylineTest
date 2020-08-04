//
//  UserViewCell.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    var user: User? {
        didSet {
            configureView()
        }
    }

    @IBOutlet weak var scoreLabel: UILabel?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView?.clipsToBounds = true
        avatarImageView?.layer.cornerRadius = (avatarImageView?.bounds.width ?? 0)/2
        configureView()
    }

    func configureView() {
        userNameLabel?.text = user?.username
        scoreLabel?.text = "Score: \(user?.score ?? 0)"
        user?.imageUrl?.image(completion: { [weak self] (image, data) in
            DispatchQueue.main.async {
                self?.avatarImageView?.image = image
            }
        })
    }

}
