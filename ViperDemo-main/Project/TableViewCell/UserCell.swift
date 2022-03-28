//
//  UserCell.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class UserCell: UITableViewCell {
    
    var containerView: UIView?
    var userTitle: UILabel?
    
    var imageViewLogo: UIImageView?
    var subTitleLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let imageView = imageViewLogo {
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageView.bounds.height / 2
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Function
    func setVerifyYourIdentityData(with object: User) {
        if let imageView = imageViewLogo {
            imageView.kf.setImage(with: URL(string: object.avatar ?? ""), placeholder: UIImage(named: "ic_car_placeholder"))
        }
        if let title = userTitle {
            title.text = object.first_name
        }
        if let subTitle = subTitleLabel {
            subTitle.text = object.email
        }
    }
}

extension UserCell {
    func setupInitialState() {
        let container = UIView()
        container.backgroundColor = .white
        contentView.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        let imageViewIdentity = UIImageView()
        container.addSubview(imageViewIdentity)
        
        imageViewIdentity.snp.makeConstraints { make in
            make.leading.equalTo(container).offset(10)
            make.centerY.equalTo(container)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .left
        title.font = .boldSystemFont(ofSize: 15)
        title.adjustsFontSizeToFitWidth = true;
        title.numberOfLines = 0
        container.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalTo(self).offset(8)
            make.leading.equalTo(imageViewIdentity).offset(40 + 10)
            make.trailing.equalTo(container).offset(8)
            make.height.equalTo(25)
        }
        
        let subTitle = UILabel()
        subTitle.textColor = .black
        subTitle.textAlignment = .left
        subTitle.font = .systemFont(ofSize: 12)
        subTitle.numberOfLines = 0
        container.addSubview(subTitle)
        
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title).offset(10)
            make.leading.equalTo(title)
            make.trailing.equalTo(title)
            make.height.equalTo(20)
            make.bottom.greaterThanOrEqualTo(10)
        }
        
        imageViewLogo = imageViewIdentity
        subTitleLabel = subTitle
        userTitle = title
        containerView = container
    }
}
