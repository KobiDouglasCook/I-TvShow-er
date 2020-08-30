//
//  NoShowView.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import UIKit

class NoShowView: UIView {

    //MARK: OUTLETS
    @IBOutlet var noShowView: UIView!
    @IBOutlet weak var noShowLabel: UILabel!
    
    //MARK: Properties
    lazy var noShowViewFrame = CGRect(x: 0,
                                      y: 0,
                                      width: UIScreen.main.bounds.width,
                                      height: UIScreen.main.bounds.height)
    
    //MARK: LIFE CYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: FUNCTIONS
    private func setup() {
        
        Bundle.main.loadNibNamed(String(describing: NoShowView.self), owner: self, options: nil)
        addSubview(noShowView)
        noShowView.frame = self.bounds
        noShowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  
    }
    
    
    func getInstance() -> NoShowView {
        return NoShowView(frame: noShowViewFrame)
    }
    
    
}
