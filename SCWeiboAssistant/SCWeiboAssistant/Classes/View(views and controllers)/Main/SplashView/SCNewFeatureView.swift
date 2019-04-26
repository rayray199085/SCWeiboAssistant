//
//  SCNewFeatureView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 25/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNewFeatureView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var enterButton: UIButton!
    class func newFeatureView()->SCNewFeatureView{
        let nib = UINib(nibName: "SCNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SCNewFeatureView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        let pageCount = 4
        for i in 0..<pageCount{
            let imageView = UIImageView(image: UIImage(named: "new_feature_\(i + 1)"))
            imageView.frame = CGRect(x: CGFloat(i) * UIScreen.screenWidth(), y: 0, width: UIScreen.screenWidth(), height: UIScreen.screenHeight())
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: UIScreen.screenWidth() * CGFloat(pageCount + 1), height: 0)
        scrollView.bounces = false
        scrollView.delegate = self
    }
    @IBAction func clickEnterButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}
extension SCNewFeatureView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int((scrollView.contentOffset.x + 0.5 * bounds.width) / bounds.width)
        enterButton.isHidden = true
        pageControl.isHidden = index == scrollView.subviews.count
        pageControl.currentPage = index
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int((scrollView.contentOffset.x + 0.5 * bounds.width) / bounds.width)
        enterButton.isHidden = index != scrollView.subviews.count - 1
        if index == scrollView.subviews.count{
            removeFromSuperview()
        }
    }
}
