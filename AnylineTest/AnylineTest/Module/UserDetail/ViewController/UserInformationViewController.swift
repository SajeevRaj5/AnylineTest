//
//  UserInformationViewController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 05/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController {
        
    var profile: Profile? {
        didSet {
            updateView()
        }
    }
    
    var username: String?

    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var centerSmallImageView: UIImageView!
    @IBOutlet weak var centerSmallView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followingsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var profileButton: UIButton?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getProfileDetails(username: username)
    }
    
    func getProfileDetails(username: String?) {
        guard let username = username else { return }
        Profile.getDetails(username: username) { [weak self] (response) in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.profile = result
                }
            case .failure(let error):
                print(error)
            case .finally:
                print("")
            }
        }
    }
    
    func updateView() {
        locationLabel.text = profile?.location
        nameLabel?.text = profile?.name
        followersCountLabel.text = "\(profile?.followers ?? 0)"
        followingsCountLabel.text = "\(profile?.followings ?? 0)"
        profileButton?.isHidden = profile?.profileUrl == nil
    }
    
    func configureView(user: User?) {
        user?.imageUrl?.image(completion: { (image, data) in
            DispatchQueue.main.async {
                self.backgroundImageView.image = image
                self.centerSmallImageView.image = image

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startAnimation()
                }            }
        })
        username = user?.username
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.backgroundImageView.layer.opacity = 0
        })
        centerSmallView.animateToTop()
        
        let padding: CGFloat = 10.0
        let yPosition = padding + CGFloat(centerSmallView.bounds.height)
        informationView.animateToTop(duration: 1.0, yPosition: yPosition)
    }
    
    @IBAction func imageButtonAction(_ sender: UIButton) {
        startAnimation()
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        guard let profileUrl = profile?.profileUrl else { return }
        UIApplication.shared.open(profileUrl)
    }

}
