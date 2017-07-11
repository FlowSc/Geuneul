//
//  IntroViewController.swift
//  Geuneul
//
//  Created by Eunyeong Kim on 2017. 7. 6..
//  Copyright © 2017년 Kang Seongchan. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView.contentOffset.x = 0
        scrollView.contentOffset.y = 0
        updatePageNumb()
        scrollView.showsHorizontalScrollIndicator = false
        self.navigationController?.isNavigationBarHidden = true
        
        let loginStatus = UserDefaults.standard.bool(forKey: "autoLogin")
        print(loginStatus)
        //AutoLogin 구간
        if loginStatus == true {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
            
            self.present(vc, animated: false, completion: nil)
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePageNumb()
    }
    
    func updatePageNumb() {
        let pageNumb: Int = Int(scrollView.contentOffset.x - 20 / self.view.bounds.width)
        self.pageControl.currentPage = pageNumb
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        
        self.scrollView.contentOffset.x = CGFloat(sender.currentPage) * self.view.bounds.width
        
    }


}
