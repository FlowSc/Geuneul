//
//  TestKolodaViewController.swift
//  KolodaTest
//
//  Created by Eunyeong Kim on 2017. 7. 5..
//  Copyright © 2017년 eunyeongkim. All rights reserved.
//

import UIKit
import Koloda
import Photos
import RealmSwift


class TestKolodaViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    
    private var numberOfCards: Int = 8
    private var imageManager = PHCachingImageManager.default()
    var scImageArray:PHFetchResult<PHAsset>!
    var realImageArray:[UIImage] = []
    static var sunnyArray:[UIImage] = []
    static var clowdyArray:[UIImage] = []
    let realm = try! Realm()
    

    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var titleDate: UILabel!
    
    
    @IBAction func sunnyBtn(_ sender: UIButton) {
        kolodaView.swipe(.left)
    }
    @IBAction func cloudBtn(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }

    func makeRealArray(){
        
        for i in 0..<self.scImageArray.count {
            
            let realImage = scImageArray.object(at: i)
            let scOption = PHImageRequestOptions.init()
            scOption.deliveryMode = .highQualityFormat
            let scImageSize = CGSize(width:realImage.pixelWidth, height:realImage.pixelHeight)

            imageManager.requestImage(for: realImage,
                                      targetSize: scImageSize,
                                      contentMode: PHImageContentMode.aspectFit,
                                      options: scOption,
                                      resultHandler: { image, _ in
                                        
                                        self.realImageArray.append(image!)
                                        if self.realImageArray.count == self.scImageArray.count
                                        {
                                            self.kolodaView.reloadData()
                                        }
                                        
            })

        }
        
        if self.realImageArray.count == self.scImageArray.count
        {
            self.kolodaView.reloadData()
        }

    }
   
    let today: Date = Date.init()
    var dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.delegate = self
        kolodaView.dataSource = self
        view.addSubview(kolodaView)
        print(realImageArray.count)
        dateFormatter.dateFormat = "M월 d일"
        titleDate.text = dateFormatter.string(from: today)
        loadImage()
        makeRealArray()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.kolodaView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        
        print(koloda.isRunOutOfCards)
        
        let outOfCardAlert = UIAlertController.init(title: "오늘들을 모두 살펴보셨습니다.", message: nil, preferredStyle: .alert)
        
        let outOfCardAlertBtn = UIAlertAction.init(title: "내일을 기다릴게요.", style: .default, handler: nil)
        outOfCardAlert.addAction(outOfCardAlertBtn)
        
        let reloadAction = UIAlertAction.init(title: "기억의 끝을 잡고..", style: .default) {[unowned self] (UIAlertAction) in

            self.kolodaView.revertAction()
        }
        
        outOfCardAlert.addAction(reloadAction)
        
        self.present(outOfCardAlert, animated: true, completion: nil)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        switch direction {
        case .left:
            TestKolodaViewController.sunnyArray.append(realImageArray[index])
        case .right:
            TestKolodaViewController.clowdyArray.append(realImageArray[index])
        default:
            print("did another direction")
        }
        
    }
    
    func loadImage(){
        let timeweekago1 = Date(timeIntervalSinceNow: -691200)
        let timeweekago2 = Date(timeIntervalSinceNow: -604800)
        let timeMonthago1 = Date(timeIntervalSinceNow: -2764800)
        let timeMonthago2 = Date(timeIntervalSinceNow: -2678400)
        let timeYearago1 = Date(timeIntervalSinceNow: -31622400)
        let timeYearago2 = Date(timeIntervalSinceNow: -31536000)
        let sixMonthAgo1 = Date(timeIntervalSinceNow: -15638400)
        let sixMonthAgo2 = Date(timeIntervalSinceNow: -15552000)
        let weekPredicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", timeweekago1 as CVarArg, timeweekago2  as CVarArg)
        let sixMonthPredicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", sixMonthAgo1 as CVarArg, sixMonthAgo2  as CVarArg)
        let monthPredicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", timeMonthago1 as CVarArg, timeMonthago2 as CVarArg)
        let yearPredicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", timeYearago1 as CVarArg, timeYearago2 as CVarArg)
        let scFetchOptions = PHFetchOptions()
        scFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                           ascending: false)]
        
        //NSPredicate 병합
        let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [weekPredicate, monthPredicate, yearPredicate, sixMonthPredicate])
//        scFetchOptions.predicate = weekPredicate
        scFetchOptions.predicate = orPredicate
//        scFetchOptions.predicate = yearPredicate
        scImageArray = PHAsset.fetchAssets(with: scFetchOptions)
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        
        return realImageArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let scView = TestImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        scView.setImageData(scImageArray.object(at: index))
        scView.setDate(scImageArray.object(at: index))
        
        return scView.imageView!
    }
    
    
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?.first as? OverlayView
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        if koloda.isRunOutOfCards == true {
            self.kolodaView.revertAction()
        }
    }
}

