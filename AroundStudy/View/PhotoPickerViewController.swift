//
//  PhotoPickerViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/21.
//

import UIKit
import Photos
import PhotosUI

class PhotoPickerViewController: BaseViewController {
    
    //MARK: Properties
    /// 멀티 셀렉트모드
    var isSingleSelectMode: Bool = false
    /// 사진 최대 선택 개수
    let maxAllowSelectCount: Int = 20
    /// 썸네일 사이즈
    var thumbnailSize: CGSize = .zero
    
    /// 전체 사진 배열
    var allPhotos: PHFetchResult<PHAsset>?
    let imageManager = PHCachingImageManager()
    /// 선택된 사진의 배열
    var selectedPhotos: [PhotoPicker] = []
    
    
    /// 네비게이션바 버튼
    let backButton: UIButton = UIButton(type: .custom)
    let completeButton: UIButton = UIButton(type: .custom)
    
    @IBOutlet weak var photoPickerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
        checkAuthorization()
    }
}

//MARK: - Layout & Functions
extension PhotoPickerViewController {
    /**
     초기 네비게이션바 설정
     > coder : **sanghyeon**
     */
    func setupNavigation() {
        /// 백버튼 설정
        backButton.setImage(.navigationBack, for: .normal)
        /// 우측 버튼 설정
        completeButton.setTitle("선택완료", for: .normal)
        completeButton.setTitleColor(.init(named: "94"), for: .normal)
        completeButton.titleLabel?.font = .setCustomFont(.regular, size: 15)
        completeButton.isHidden = isSingleSelectMode
        
        /// 네비게이션바 세팅
        setNavigationBar("사진선택", leftBarButton: [backButton], rightBarButton: [completeButton], isLeftSetting: true)
    }
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 컬렉션뷰 세팅
        let cellNib = UINib(nibName: "PhotoPickerCollectionViewCell", bundle: nil)
        photoPickerCollectionView.register(cellNib, forCellWithReuseIdentifier: "PhotoPickerCollectionViewCell")
        photoPickerCollectionView.delegate = self
        photoPickerCollectionView.dataSource = self
    }
    /**
     포토라이브러리 권한 체크
     > coder : **sanghyeon**
     */
    func checkAuthorization() {
        /// 포토 라이브러리 권한 요청
        authorization.requestPhotoLibraryAuthorization() { result in
            self.dataManager.isAuthorizationPhotoLibrary = result
            if let result = result {
                if result {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 허용")
                    self.fetchAllPhotos()
                } else {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 거부")
                }
            } else {
                print("*** ViewController.swift, 포토 라이브러리 권한: 설정하지 않음")
            }
        }
    }
    /**
     포토라이브러리 사진 가져오기
     > coder : **sanghyeon**
     >> 참고 : https://rhammer.tistory.com/230
     */
    func fetchAllPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        DispatchQueue.main.async {
            self.photoPickerCollectionView.reloadData()
        }
    }
    /**
     포토라이브러리 에셋 이미지 추출
    > coder : **sanghyeon**
     */
    func fetchPhotos(index: Int, completion: @escaping (UIImage?) -> ()) {
        if let asset = allPhotos?.object(at: index) {
            imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                completion(image)
            })
        }
    }
}

//MARK: - CollectionView
extension PhotoPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos?.count ?? 0 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setupCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell(indexPath: indexPath)
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let cellWidth = ceil((viewWidth - 6) / 3)
        thumbnailSize = CGSize(width: cellWidth, height: cellWidth)
        return thumbnailSize
    }
    
    /**
     컬렉션뷰 셀 설정 기본함수 대체
     > coder : **sanghyeon**
     */
    func setupCell(indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.item)
        guard let cell = photoPickerCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPickerCollectionViewCell", for: indexPath) as? PhotoPickerCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row > 0 {
            cell.setupCell(hideIcon: true, hideButton: isSingleSelectMode)
            
            if let asset = allPhotos?.object(at: indexPath.row - 1) {
                cell.representedAssetIdentifier = asset.localIdentifier
                fetchPhotos(index: indexPath.row - 1) { result in
                    if let image = result {
                        if cell.representedAssetIdentifier == asset.localIdentifier {
                            cell.setImage(image: image)
                        }
                    }
                }
            }
            
            if let _ = selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) {
                cell.selectCell(select: true)
            } else {
                cell.selectCell(select: false)
            }
        } else {
            cell.setupCell(hideIcon: false, hideButton: true)
        }
        return cell
    }
    
    /**
     컬렉션뷰 셀 선택 기본함수 대체
     > coder : **sanghyeon**
     */
    func selectCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("selectedPhotos: \(self.selectedPhotos)")
        default:
            print("셀 선택!")
            guard let cell = photoPickerCollectionView.cellForItem(at: indexPath) as? PhotoPickerCollectionViewCell else { return }
            
            if let targetIndex = selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) {
                selectedPhotos.remove(at: targetIndex)
                cell.selectCell(select: false)
            } else {
                if maxAllowSelectCount <= selectedPhotos.count {
                    print("최대 선택 개수를 초과함")
                    return
                }
                fetchPhotos(index: indexPath.row - 1) { result in
                    print("선택된 사진 가져오기 완료")
                    if let image = result {
                        let selectedPhoto: PhotoPicker = .init(index: indexPath.row, data: ImageData(original: image, processed: nil))
                        if let _ = self.selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) { } else {
                            self.selectedPhotos.append(selectedPhoto)
                        }
                        cell.selectCell(select: true)
                    }
                }
            }
            
            DispatchQueue.main.async {
                print("selectedPhotos: \(self.selectedPhotos)")
            }
        }
    }
}
