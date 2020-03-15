//
//  SafariView.swift
//  NewsScreen_Example
//
//  Created by Artem Kufaev on 15.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.reuters.com/article/us-facebook-privacy/facebook-acknowledges-flaw-in-messenger-kids-app-idUSKCN1VJ08X")!)
    }
}
