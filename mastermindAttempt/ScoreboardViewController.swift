//
//  ScoreboardViewController.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-10.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


// MARK: PROTOCOL

protocol ScoreboardViewControllerDelegate: class {
    func doesQualify(score : Int, placement : Int)
}

class ScoreboardViewController: UIViewController {
    
    
    // MARK: VARIABLES
    
    weak var delegate : ScoreboardViewControllerDelegate?
    var db : Firestore!
    var auth : Auth!
        
    lazy var scoreboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
        
    lazy var scoreboardLabel: UILabel = {
        let label = UILabel()
        label.text = "SCOREBOARD"
        label.font = UIFont(name: "Quicksand-Regular", size: 22)
        label.textColor = .customRed
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
        
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(systemName: "multiply")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .customRed
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(close), for: .touchDown)
        return button
    }()
        
    @objc func close(sender: UIButton) {
        let transition: CATransition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: true)
    }
    
    let tableView = UITableView()
    var scoreboard = Array(repeating: ScoreboardPerson(name: "Name", score: 0), count: 10)

    
    // MARK: DID VIEW LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 60.0
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        
        
        // MARK: FIREBASE
        
        db = Firestore.firestore()
        
        self.view.backgroundColor = .customBackground
        self.view.addSubview(scoreboardView)
        self.scoreboardView.addSubview(scoreboardLabel)
        self.scoreboardView.addSubview(closeButton)
        self.scoreboardView.addSubview(tableView)
    }
    
    
    // MARK: VIEW DID APPEAR
    
    override func viewDidAppear(_ animated: Bool) {
        db = Firestore.firestore()
        
        let scoreboardRef = db.collection("scoreboard")
        scoreboardRef.order(by: "score", descending: true).limit(to: 10).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let scorer = ScoreboardPerson(name: document.get("name") as! String, score: document.get("score") as! Int)
                        self.scoreboard.append(scorer)
                        self.scoreboard.removeFirst()
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
  
    // MARK: UPDATE VIEW CONSTRAINTS
    
    override func updateViewConstraints() {
        scoreboardView.autoPinEdgesToSuperviewSafeArea()
        
        scoreboardLabel.autoAlignAxis(.horizontal, toSameAxisOf: closeButton)
        scoreboardLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
            
        closeButton.autoSetDimensions(to: CGSize(width: 40.0, height: 40.0))
        closeButton.autoPinEdge(.top, to: .top, of: scoreboardView, withOffset: 16.0)
        closeButton.autoPinEdge(.trailing, to: .trailing, of: scoreboardView, withOffset: -16.0)
        
        tableView.autoPinEdge(.top, to: .bottom, of: scoreboardLabel, withOffset: 32.0)
        tableView.autoPinEdge(.leading, to: .leading, of: scoreboardView, withOffset: 16.0)
        tableView.autoPinEdge(.trailing, to: .trailing, of: scoreboardView, withOffset: -16.0)
        tableView.autoPinEdge(.bottom, to: .bottom, of: scoreboardView, withOffset: -16.0)
        super.updateViewConstraints()
    }
    
    
    // MARK: CHECK IF QUALIFY
    
    func checkIfQualify(score: Int) {
        for i in 0..<scoreboard.count {
            if score > scoreboard[i].score {
                delegate?.doesQualify(score: score, placement: i)
                break
            }
        }
    }
    
    
    // MARK: UPDATE SCOREBOARD
    
    func updateScoreBoard(scorer : ScoreboardPerson) {
        
        db = Firestore.firestore()
        let newScorerRef = self.db.collection("scoreboard").document()
        
        do {
            try newScorerRef.setData(from: scorer)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
}


// MARK: DATASOURCE

extension ScoreboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.backgroundColor = .clear
        
        let imageName : String = "\(indexPath.row + 1).circle"
        let lightConfig = UIImage.SymbolConfiguration(weight: .thin)
        cell.imageView?.image = UIImage(systemName: imageName, withConfiguration: lightConfig)
        cell.imageView?.tintColor = .customRed
        cell.imageView?.autoSetDimensions(to: CGSize(width: 35.0, height: 35.0))
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.autoAlignAxis(.horizontal, toSameAxisOf: cell)
        
        cell.detailTextLabel?.text = String(scoreboard[indexPath.row].score)
        cell.detailTextLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        cell.textLabel?.textColor = .customCharcoal
        
        cell.textLabel?.text = scoreboard[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "Quicksand", size: 18)
        cell.textLabel?.textColor = .customBlack
        
        return cell
    }
}
