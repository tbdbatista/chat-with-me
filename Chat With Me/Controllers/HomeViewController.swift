//
//  HomeViewController.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 06/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var labelMainTitle: UILabel!
    @IBOutlet weak var imageBalloon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mainLabelAnimation()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mainLabelAnimation(){
        
        labelMainTitle.text = ""
        let mainLabelText = K.appName
        var timerControl = 0.9
        for letter in mainLabelText {
            Timer.scheduledTimer(withTimeInterval: timerControl, repeats: false) { [self] (timer) in
                labelMainTitle.text?.append(letter)
            }
            timerControl += 0.1
        }
    }

}
