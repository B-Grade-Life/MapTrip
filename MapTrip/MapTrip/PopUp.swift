//
//  PopUp.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/29.
//

import UIKit

class PopUp: UIView {

    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        closeBtn.layer.masksToBounds = false
        closeBtn.layer.cornerRadius = 10
        closeBtn.clipsToBounds = true
        addBtn.layer.masksToBounds = false
        addBtn.layer.cornerRadius = 10
        addBtn.clipsToBounds = true
        
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXid()
        view.frame = frame
        addSubview(view)
    }
    
    func loadXid() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view!
    }

}
