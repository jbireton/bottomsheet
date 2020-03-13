//
//  ShortView.swift
//  SheetPOC
//
//  Created by Ireton, John on 3/13/20.
//  Copyright © 2020 Ireton, John (US - Seattle). All rights reserved.
//

import UIKit

class ShortView: UIView {
    static var height = CGFloat(75)
    
    @IBOutlet weak var containerView: UIView!
    
    private var didTapButton: (() -> Void)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("ShortView", owner: self, options: nil)
        addSubview(containerView)
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        Bundle.main.loadNibNamed("ShortView", owner: self, options: nil)
        containerView.frame = UIScreen.main.bounds
        self.addSubview(containerView)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = ShortView.height
        return size
    }

    func populate(didTapButton: @escaping(() -> Void)) {
        self.didTapButton = didTapButton
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        didTapButton?()
    }
}
