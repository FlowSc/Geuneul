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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createVeiw()
        
        
    }
    
    
    func createVeiw()
    {
        imageView = UIImageView()
        self.addSubview(imageView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = self.bounds
    }
    
    func setImageData(_ realImage:PHAsset)
    {
        
        
        let scOption = PHImageRequestOptions.init()
        scOption.deliveryMode = .highQualityFormat
        PHCachingImageManager.default().requestImage(for: realImage,
                                  targetSize: CGSize(width: 600, height: 800),
                                  contentMode: PHImageContentMode.aspectFill,
                                  options: scOption,
                                  resultHandler: { image, _ in
                                    
                                    print(image!.size)
                                    self.imageView?.image = image
//                                    self.realImageArray.append(image!)
//                                    if self.realImageArray.count == self.scImageArray.count
//                                    {
//                                        self.kolodaView.reloadData()
//                                    }
                                    
                                    
        })
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
