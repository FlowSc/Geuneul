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
    var scTextLabel:UILabel?
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
        
    }
    
    func createView()
    {
        imageView = UIImageView()
        scTextLabel = UILabel()
        self.addSubview(imageView!)
        self.addSubview(scTextLabel!)
        
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
//                                    if let data = UIImagePNGRepresentation(image!)
//                                    {
//                                        let filename = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)
//                                        
//                                        data.
//                                    }
                                    print(self.dateFormatter.string(from: realImage.creationDate!))
                                    self.scTextLabel?.text = self.dateFormatter.string(from: realImage.creationDate!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
