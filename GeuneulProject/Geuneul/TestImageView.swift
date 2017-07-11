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
        
        createView()
        
    }
    
    func createView()
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
                                  targetSize: CGSize(width: 1200, height: 1200),
                                  contentMode: PHImageContentMode.aspectFit,
                                  options: scOption,
                                  resultHandler: { image, _ in
                                    
                                    print(image!.size)
                                    self.imageView?.image = image
                                   
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
