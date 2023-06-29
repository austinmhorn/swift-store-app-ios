//
//  RoundedButton.swift
//  amh.co
//
//  Created by Austin Horn on 2/24/21.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
            didSet{
            self.layer.cornerRadius = cornerRadius
            }
        }

        @IBInspectable var borderWidth: CGFloat = 0{
            didSet{
                self.layer.borderWidth = borderWidth
            }
        }

        @IBInspectable var borderColor: UIColor = UIColor.clear{
            didSet{
                self.layer.borderColor = borderColor.cgColor
            }
        }

}
