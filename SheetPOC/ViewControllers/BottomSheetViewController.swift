//
//  BottomSheetViewController.swift
//  SheetPOC
//
//  Created by Ireton, John on 3/13/20.
//  Copyright © 2020 Ireton, John (US - Seattle). All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet private weak var variableHeightView: UIView!
    @IBOutlet private weak var countyTableView: UITableView!
    
    static let maximumOffset = CGFloat(44) // Measured from top
    static let defaultOffset = CGFloat(200) // Measured from bottom

    private var shortView: ShortView?
    private var tallView: TallView?
    
    var rows = [
        "Adams",
        "Asotin",
        "Benton",
        "Chelan",
        "Clallam",
        "Clark",
        "Columbia",
        "Cowlitz",
        "Douglas",
        "Ferry",
        "Franklin",
        "Garfield",
        "Grant",
        "Grays Harbor",
        "Island",
        "Jefferson",
        "King",
        "Kitsap",
        "Kittitas",
        "Klickitat",
        "Lewis",
        "Lincoln",
        "Mason",
        "Okanogan",
        "Pacific",
        "Pend Oreille",
        "Pierce",
        "San Juan",
        "Skagit",
        "Skamania",
        "Snohomish",
        "Spokane",
        "Stevens",
        "Thurston",
        "Wahkiakum",
        "Walla Walla",
        "Whatcom",
        "Whitman",
        "Yakima"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSheetStyle()
        setupPanGesture()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        insertShortSheetHeader()
    }
    
    public func minimize() {
        animateDrawerToOffset(UIScreen.main.bounds.height - BottomSheetViewController.defaultOffset)
    }
    
    public func maximize() {
        animateDrawerToOffset(BottomSheetViewController.maximumOffset)
    }
    
    public func hide() {
        animateDrawerToOffset(UIScreen.main.bounds.height)
    }

    private func animateDrawerToOffset(_ newOffset: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: newOffset, width: frame.width, height: frame.height)
        }
    }
    
    private func setupSheetStyle() {
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.0
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func setupPanGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gesture)
    }
    
    private func insertShortSheetHeader() {
        tallView?.removeFromSuperview()
        shortView = ShortView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: ShortView.height))
        guard let shortView = shortView else { return }
        shortView.populate {
            self.insertTallSheetHeader()
        }
        shortView.translatesAutoresizingMaskIntoConstraints = false
        variableHeightView.addSubview(shortView)
        NSLayoutConstraint.activate([
            shortView.leadingAnchor.constraint(equalTo: variableHeightView.leadingAnchor),
            shortView.trailingAnchor.constraint(equalTo: variableHeightView.trailingAnchor),
            shortView.topAnchor.constraint(equalTo: variableHeightView.topAnchor),
            shortView.bottomAnchor.constraint(equalTo: variableHeightView.bottomAnchor)
        ])
    }
    
    private func insertTallSheetHeader() {
        shortView?.removeFromSuperview()
        tallView = TallView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: TallView.height))
        guard let tallView = tallView else { return }
        tallView.populate {
            self.insertShortSheetHeader()
        }
        tallView.translatesAutoresizingMaskIntoConstraints = false
        variableHeightView.addSubview(tallView)
        NSLayoutConstraint.activate([
            tallView.leadingAnchor.constraint(equalTo: variableHeightView.leadingAnchor),
            tallView.trailingAnchor.constraint(equalTo: variableHeightView.trailingAnchor),
            tallView.topAnchor.constraint(equalTo: variableHeightView.topAnchor),
            tallView.bottomAnchor.constraint(equalTo: variableHeightView.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        countyTableView.delegate = self
        countyTableView.dataSource = self
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: view)
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
}
