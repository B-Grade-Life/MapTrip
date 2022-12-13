//
//  ViewControllerHome.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/03.
//

import Foundation
import UIKit

class ViewControllerHome: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var cornerView: UIView!
    @IBOutlet var scheduleCornerView: UIView!
    @IBOutlet var lblCurrentWeekday: UILabel!
    @IBOutlet var lblCurrentDays: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    var commercialPopUp: PopUp!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let date = NSDate()
        let dateFormatterWeekday = DateFormatter()
        let dateFormatterDays = DateFormatter()
        
        //corner round
        cornerView.layer.masksToBounds = false
        cornerView.layer.cornerRadius = 20
        cornerView.clipsToBounds = true
        scheduleCornerView.layer.masksToBounds = false
        scheduleCornerView.layer.cornerRadius = 5
        scheduleCornerView.clipsToBounds = true
        
        //Current Days
        dateFormatterWeekday.dateFormat = "EEE"
        dateFormatterDays.dateFormat = "d"
        lblCurrentWeekday.text = dateFormatterWeekday.string(from: date as Date) + "요일"
        lblCurrentDays.text = dateFormatterDays.string(from: date as Date) +  "일"
        
        //Group
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
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
    
    // Group collectionVeiw
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as! GroupCollectionViewCell
        
        cell.setup(with: Groups[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 169, height: 156)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(Groups[indexPath.row])
    }
    
}




