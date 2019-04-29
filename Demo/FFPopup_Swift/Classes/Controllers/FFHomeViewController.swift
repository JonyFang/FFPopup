//
//  FFHomeViewController.swift
//  FFPopup_Swift
//
//  Created by JonyFang on 2019/4/28.
//  Copyright © 2019 JonyFang. All rights reserved.
//

import UIKit

class FFHomeViewController: UIViewController {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Private Methods
    fileprivate func setupViews() {
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPopup))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func showPopup() {
        let popup = FFPopup(contentView: self.alertView, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        let layout = FFPopupLayoutMake(.horizontalLayout_Center, .center)
        popup.show(with: layout)
    }
    
    // MARK: Properties
    fileprivate lazy var alertView: BLCustomContentView = {
        let w = UIScreen.main.bounds.size.width - 30
        let h = w * 3 / 4
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        let view = BLCustomContentView(frame: frame)
        view.backgroundColor = .purple
        return view
    }()

}

