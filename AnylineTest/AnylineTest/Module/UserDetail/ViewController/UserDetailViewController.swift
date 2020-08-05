//
//  UserDetailViewController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, ActivityIndicatorPresenter {
    
    var activityIndicator = UIActivityIndicatorView()
    var username: String?
    var profile: Profile? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followingsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getProfileDetails(username: username)
    }
        
    func updateView() {
        locationLabel.text = profile?.location
        nameLabel?.text = profile?.name
        followersCountLabel.text = "\(profile?.followers ?? 0)"
        followingsCountLabel.text = "\(profile?.followings ?? 0)"
        profile?.imageUrl?.image(completion: { [weak self] (image, data) in
            DispatchQueue.main.async {
                self?.avatarImageView?.image = image
            }
        })
        
        view.animateAllSubViews(direction: .left)
    }
    
    func getProfileDetails(username: String?) {
        guard let username = username else { return }
        showLoader()
        Profile.getDetails(username: username) { [weak self] (response) in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.profile = result
                }
            case .failure(let error):
                print(error)
            case .finally:
                self?.hideLoader()
            }
        }
    }

    @IBAction func profileButtonAction(_ sender: UIButton) {
        guard let profileUrl = profile?.profileUrl else { return }
        UIApplication.shared.open(profileUrl)
    }
}
