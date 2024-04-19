//
//  VoiceRecorderViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 18.01.2024.
//

import UIKit
import AVFoundation
import AVKit

class VoiceRecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var player = AVAudioPlayer()
    
    let backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        return backButton
    }()
    
    private lazy var recordButton: CustomButton = {
        let recordButton = CustomButton(titleText: "Записать", titleColor: .white, backgroundColor: .systemBlue, tapAction: self.recordTapped)
        return recordButton
    }()
    
    private lazy var playRecordButton: CustomButton = {
        let playRecordButton = CustomButton(titleText: "Воспроизвести", titleColor: .black, backgroundColor: .white, tapAction: self.playRecord)
        return playRecordButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.addSubviews(recordButton, playRecordButton)
        setupUI()
    }
    
    @objc func recordTapped() {
        player.stop()
        player.currentTime = 0
        playRecordButton.backgroundColor = .systemRed
    }
    
    @objc func playRecord() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
            playRecordButton.backgroundColor = .white
        } else {
            player.play()
            playRecordButton.backgroundColor = .green
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            recordButton.heightAnchor.constraint(equalToConstant: 70),
            recordButton.widthAnchor.constraint(equalToConstant: 350),
            
            playRecordButton.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            playRecordButton.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor, constant: 90),
            playRecordButton.heightAnchor.constraint(equalToConstant: 70),
            playRecordButton.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}
