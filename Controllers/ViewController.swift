//
//  ViewController.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testlbl: UILabel!
    @IBOutlet weak var testIMG: UIImageView!
    @IBOutlet weak var testClv: UICollectionView!
    @IBOutlet weak var testtxt: UITextField!
    
    private let viewModel = CharacterListViewViewModel()
    let userDefaultsManager = UserDefaultsManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        testClvConfig()
        getConfig()
        fetchAllCharacterConfig()
    }
    
    
    func getConfig() {
        testtxt.delegate = self
        // Retrieve the name
        if let savedName = userDefaultsManager.getName(), !savedName.isEmpty {
                print("Saved name: \(savedName)")
            testlbl.text = savedName
            } else {
                testlbl.text = "This is custom font"
            }
        testlbl.font = CustomFont.font(style: .regular, size: 30)
        testlbl.textColor = ThemeColor.red.getColor
        testIMG.image = ThemeImage.test.getImage
    }
    
    func fetchAllCharacterConfig() {
        viewModel.fetchAllCharacter()
        viewModel.modelClosure = { [weak self] event  in
            guard let storngSelf = self else { return }
            switch event {
            case .valid:
                print(String(describing: storngSelf.viewModel.rmCharacter))
                DispatchQueue.main.async {
                    storngSelf.testClv.reloadData()
                }
            case .error(let error):
                print(String(describing: error))
            }
        }
    }
    
    func testClvConfig() {
        testClv.delegate = self
        testClv.dataSource = self
        testClv.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil),
                         forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        userDefaultsManager.saveName(textField.text ?? "This is custom font")
        textField.text = ""
    }
    
}
                                
                                
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rmCharacter?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.getConfig(with: self.viewModel.rmCharacter?.results?[indexPath.row].name ?? "",
                       image: self.viewModel.rmCharacter?.results?[indexPath.row].image ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/2
        return CGSize(width: width,
                      height: width * 1.5)
    }
    
}
