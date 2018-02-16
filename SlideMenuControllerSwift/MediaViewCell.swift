//
//  MediaViewCell.swift
//  Broadkazt
//
//  Created by Jeevan Sivagnanasuntharam on 10/10/2017.
//

import Foundation
import UIKit
import Photos
import SDWebImage


class CustomViewFlowLayout : UICollectionViewFlowLayout {
    
    let cellSpacing:CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}

class MediaViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblPage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var vwBottom: UIView!
    
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var bgSeconds: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var gradientLayer: CAGradientLayer? = nil
    
    @IBOutlet weak var playiconImage: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnClose.layer.cornerRadius = 15.0
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                select();
            } else {
                deselect();
            }
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
    
        
        
    }
    
    
    func select(){
//        let overlayImage = UIImage(named:"playicon")
//        let overlayImageView = UIImageView(image:overlayImage)
//        
//        self.imageView.addSubview(overlayImageView);
    }
    
    func deselect(){
//        for view in self.imageView.subviews {
//            view.removeFromSuperview()
//        }
    }
    
    func fillData(thumbUrl: AwsVideo)  {
 
        self.imageView.sd_setImage(with: URL(string: thumbUrl.thumbnail), placeholderImage: UIImage(named: "placeholder.png"));
        
        if(thumbUrl.awsUrl==nil || thumbUrl.awsUrl == "" ) {
            self.playiconImage.isHidden = true;
        }
        else {
            self.playiconImage.isHidden = false;
            
            
        }

        if thumbUrl.logo != nil || thumbUrl.logo != "" {
            self.imgLogo.sd_setImage(with: URL(string: thumbUrl.logo), completed: nil)
            self.imgLogo.contentMode = .scaleAspectFit
            self.imgLogo.clipsToBounds = true
            self.imgLogo.isHidden = false
        }
        else {
            self.imgLogo.isHidden = true
        }
        
        self.lblTitle.text = thumbUrl.videoName
        self.lblDescription.text = thumbUrl.description
        if thumbUrl.duration % 60 < 10 {
            self.lblDuration.text =  String(format: "%ld:0%ld", thumbUrl.duration/60, thumbUrl.duration % 60)
        }
        else {
            self.lblDuration.text =  String(format: "%ld:%ld", thumbUrl.duration/60, thumbUrl.duration % 60)
        }
                
        if gradientLayer == nil {
            self.createGradientLayer()
        }
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        var frame = self.vwBottom.frame
        frame.size.width = UIScreen.main.bounds.size.width
        gradientLayer?.frame = frame
        
        let startColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        let endColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
        self.vwBottom.layer.addSublayer(gradientLayer!)
    }
    
}
