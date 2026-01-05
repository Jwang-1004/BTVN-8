//
//  UTH_SmartTasksApp.swift
//  UTH SmartTasks
//
//  Created by Giang Võ Nguyễn Trường on 6/1/26.
//

import SwiftUI

@main
struct UTH_SmartTasksApp: App {
    var body: some Scene {
        WindowGroup {
            RootAppView()
        }
    }
}
import SwiftUI

struct RootAppView: View {
    // Trạng thái 1: Splash đã chạy xong chưa?
    @State private var isSplashFinished = false
    
    // Trạng thái 2: Đã xem hướng dẫn (Onboarding) chưa? (Lưu vào bộ nhớ máy)
    @AppStorage("isOnboardingDone") private var isOnboardingDone = false
    
    var body: some View {
        // Logic điều hướng luồng chính (Main Flow)
        if !isSplashFinished {
            // 1. Chưa xong Splash -> Hiện Splash
            SplashScreen(isActive: $isSplashFinished)
        } else {
            // 2. Splash xong rồi -> Kiểm tra Onboarding
            if isOnboardingDone {
                // 3. Đã xem Onboarding -> Vào App chính (có Navigation)
                AppNavigator()
            } else {
                // 4. Chưa xem Onboarding -> Hiện màn hình giới thiệu
                OnboardingScreen(isCompleted: $isOnboardingDone)
            }
        }
    }
}

// --- Màn hình Splash Tạm (Nếu bạn chưa có) ---
struct SplashScreen: View {
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Image("UT")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                Text("UTH SmartTasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            // Tự động chuyển màn sau 2 giây
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
