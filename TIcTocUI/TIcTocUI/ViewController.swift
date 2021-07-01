//
//  ViewController.swift
//  TIcTocUI
//
//  Created by Sam Chaudhari on 01/07/21.
//

import UIKit

private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                        2,2,2,2]
    
    private let winningCombinations = [[0, 1, 2,3], [4, 5, 6,7], [8, 9, 10,11], [12, 13, 14,15], [0, 4, 8,12], [1, 5, 9,13], [2, 6, 10,14], [3, 7, 11,15],[0,5,10,15],[3,6,9,12]]
    
    private var zeroFlag = false
    var xwin = 0
    var owin = 0
class ViewController: UIViewController {
    private let mycollectionview : UICollectionView = {
   let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
    layout.itemSize = CGSize(width: 70, height: 70)
        let collectview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectview;
    }()
    private let bgimg :UIImageView = {
        let bg = UIImageView(image: UIImage(named: "BG"))
        bg.contentMode = .scaleAspectFill
        bg.clipsToBounds = true
        return bg
    }()
    private let label1 : UILabel = {
        let lb = UILabel()
        lb.text = " X Player 1 "
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        return lb
    }()
    private let label2 : UILabel = {
        let lb = UILabel()
        lb.text = " O Player 2 "
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .orange
        return lb
    }()
    private let label3 : UILabel = {
        let lb = UILabel()
        lb.text = "0 pts"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        return lb
    }()
    private let label4 : UILabel = {
        let lb = UILabel()
        lb.text = "0 pts"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .orange
        return lb
    }()
    private let myview : UIView  = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view;
    }()
    private let label5 : UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .orange
        
        return lb
    }()
    private let myview1 : UIView  = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view;
    }()
    override func viewDidLoad() {
        self.mycollectionview.backgroundView = bgimg
        super.viewDidLoad()
        view.addSubview(bgimg)
        view.addSubview(mycollectionview)
        view.addSubview(label1)
        view.addSubview(myview)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(myview1)
        view.addSubview(label5)
        setupCollectionView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgimg.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        label1.frame = CGRect(x: 10, y: 30, width: view.width, height: 40)
        label2.frame = CGRect(x: 10, y: 80, width: view.width, height: 40)
        label3.frame = CGRect(x: view.width - 50, y: 30, width: view.width, height: 40)
        label4.frame = CGRect(x: view.width - 50, y: 80, width: view.width, height: 40)
        myview.frame = CGRect(x: 0, y: 30, width: view.width, height: 100)
        label5.frame = CGRect(x: 50, y:  view.height - 200, width: view.width - 30, height: 40)
        myview1.frame = CGRect(x: 20, y: view.height - 200, width: view.width - 50, height: 50)
        mycollectionview.frame = view.bounds
    }

}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        mycollectionview.register(TicTocVC.self, forCellWithReuseIdentifier: "TicTocVC")
        mycollectionview.dataSource = self
        mycollectionview.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        state.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTocVC", for: indexPath) as! TicTocVC
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                label5.text = "Its Your Trun Player X"
                state.insert(0, at: indexPath.row)
            } else {
                label5.text = "Its Your Trun Player O"
                state.insert(1, at: indexPath.row)
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    private func checkWinner() {
        
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations {
            if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2 {
                announceWinner(player: state[ i[0] ] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        if (player=="X"){
            xwin += 1
        }else {
            owin += 1
        }
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        label3.text = String(xwin) + " pts"
        label4.text = String(owin) + " pts"
        
    }
    
    private func resetState() {
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        mycollectionview.reloadData()
    }
}

