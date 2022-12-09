//
//  ViewControllerHome.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/03.
//

import Foundation
import UIKit

class ViewControllerHome: UIViewController {
    @IBOutlet var cornerView: UIView!
    @IBOutlet var scheduleCornerView: UIView!
    @IBOutlet var lblCurrentWeekday: UILabel!
    @IBOutlet var lblCurrentDays: UILabel!
    
    
    @IBOutlet var collectionView: UICollectionView!
    
//    @IBOutlet var contentCornerView: UIView!
//    @IBOutlet var contentCornerView2: UIView!
//    @IBOutlet var contentCornerView3: UIView!
    
   
    
    var commercialPopUp: PopUp!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let date = NSDate()
        let dateFormatterWeekday = DateFormatter()
        let dateFormatterDays = DateFormatter()
        
        cornerView.layer.masksToBounds = false
        cornerView.layer.cornerRadius = 20
        cornerView.clipsToBounds = true
        
        scheduleCornerView.layer.masksToBounds = false
        scheduleCornerView.layer.cornerRadius = 5
        scheduleCornerView.clipsToBounds = true
        
//        contentCornerView.layer.masksToBounds = false
//        contentCornerView.layer.cornerRadius = 15
//        contentCornerView.clipsToBounds = true
//        contentCornerView2.layer.masksToBounds = false
//        contentCornerView2.layer.cornerRadius = 15
//        contentCornerView2.clipsToBounds = true
//        contentCornerView3.layer.masksToBounds = false
//        contentCornerView3.layer.cornerRadius = 15
//        contentCornerView3.clipsToBounds = true
        

        dateFormatterWeekday.dateFormat = "EEE"
        dateFormatterDays.dateFormat = "d"
        lblCurrentWeekday.text = dateFormatterWeekday.string(from: date as Date) + "요일"
        lblCurrentDays.text = dateFormatterDays.string(from: date as Date) +  "일"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 169, height: 156)
        collectionView.collectionViewLayout = layout
        collectionView.register(GroupCollectionViewCell.nib(), forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func addGroupTapped(_ sender: Any) {
        self.commercialPopUp = PopUp(frame: self.view.frame)
        self.commercialPopUp.closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.commercialPopUp.addBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }

    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func addBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    
    // Show TapBar 
    @IBAction func btnMoveMap(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

extension ViewControllerHome: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }
    
}
extension ViewControllerHome: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
        
        cell.configure(with: UIImage(named: "LA")!)
        
        return cell
    }
    
    
}
extension ViewControllerHome: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 169, height: 156)
    }
}
