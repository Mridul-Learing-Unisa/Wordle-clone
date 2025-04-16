//
//  Global.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import UIKit

enum Global {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }
    
    static var minDimention: CGFloat {
        min(screenWidth, screenHeight)
    }
    
    static var boardWidth: CGFloat {
        switch minDimention {
            case 0...320:
                return screenWidth - 55
            
            case 321...430:
                return screenWidth - 50
            
            case 431...1000:
                return 300
            
            default :
                return 500
            
        }
    }
    static var keyBoardScale: CGFloat {
        switch minDimention {
            case 0...430:
                return screenWidth / 375
            
            case 431...1000:
                return CGFloat(1.2)
            default :
                return CGFloat(1.6)
        }
    }
}
