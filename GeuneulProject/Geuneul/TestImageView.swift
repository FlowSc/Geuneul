//
//  TestImageView.swift
//  Geuneul
//
//  Created by Kang Seongchan on 2017. 7. 10..
//  Copyright © 2017년 Kang Seongchan. All rights reserved.
//

import UIKit
import Photos

class TestImageView: UIView {

    var imageView:UIImageView?
    var scTextLabel:UILabel!
    let dateFormatter = DateFormatter()
    var scCreationDate:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
        
    }
    
    func createView()
    {
        imageView = UIImageView()
        scTextLabel = UILabel()
        self.addSubview(imageView!)
        self.addSubview(scTextLabel)
        imageView?.addSubview(scTextLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = self.bounds
    }
    
    func setImageData(_ realImage:PHAsset)
    {
        dateFormatter.dateFormat = "y년 M월 d일"
        let scImageSize = CGSize(width:realImage.pixelWidth, height:realImage.pixelHeight)
        let scOption = PHImageRequestOptions.init()
        scOption.deliveryMode = .highQualityFormat
        PHCachingImageManager.default().requestImage(for: realImage,
                                  targetSize: scImageSize,
                                  contentMode: PHImageContentMode.aspectFit,
                                  options: scOption,
                                  resultHandler: { image, _ in
                                    
                                    print(image!.size)
                                    self.imageView?.image = image
                                    self.scCreationDate = self.dateFormatter.string(from: realImage.creationDate!)
                                     })
        scTextLabel!.text = "\(realImage.creationDate!)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDate(_ realImage:PHAsset){
        
        self.scTextLabel?.text = "\(realImage.creationDate ?? Date())"
        print(realImage.creationDate!)
//        imageView?.addSubview(scTextLabel!)
   
    }
}
