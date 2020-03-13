//
//  MapViewController.swift
//  SheetPOC
//
//  Created by Ireton, John on 3/13/20.
//  Copyright © 2020 Ireton, John (US - Seattle). All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet private weak var bottomSheetButton: UIButton!
    
    private var bottomSheet = BottomSheetViewController()
    private var bottomSheetHidden = true {
        didSet {
            if bottomSheetHidden == true {
                bottomSheet.hide()
                bottomSheetButton.setTitle("Show Bottom Drawer", for: .normal)
            } else {
                bottomSheet.minimize()
                bottomSheetButton.setTitle("Hide Bottom Drawer", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheet()
    }
    
    private func styleButton() {
        bottomSheetButton.setTitle("Show Bottom Drawer", for: .normal)
    }
    
    private func addBottomSheet() {
        addChild(bottomSheet)
        view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
        
        bottomSheet.view.frame = CGRect(x: 0,
                                          y: view.frame.maxY,
                                          width:view.frame.width,
                                          height:view.frame.height)
    }
    
    @IBAction func didTapDrawerButton(_ sender: Any) {
        bottomSheetHidden = !bottomSheetHidden
    }
    
}
