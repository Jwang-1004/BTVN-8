//
//  OnboardingItem.swift
//  UTH SmartTasks
//
//  Created by Giang Võ Nguyễn Trường on 6/1/26.
//


import SwiftUI

// 1. Model dữ liệu (OOP) - Định nghĩa nội dung của 1 trang
struct OnboardingItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct OnboardingScreen: View {
    // Binding để báo về RootAppView là đã xem xong
    @Binding var isCompleted: Bool
    @State private var currentPage = 0
    
    // 2. Dữ liệu mẫu (Lấy text từ ảnh bạn gửi)
    let pages: [OnboardingItem] = [
        OnboardingItem(
            image: "clock.badge.checkmark", // Dùng tạm SF Symbol, bạn thay tên ảnh thật vào đây
            title: "Easy Time Management",
            description: "With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first."
        ),
        OnboardingItem(
            image: "chart.bar.xaxis",
            title: "Increase Work Effectiveness",
            description: "Time management and the determination of more important tasks will give your job statistics better and always improve."
        ),
        OnboardingItem(
            image: "bell.badge",
            title: "Reminder Notification",
            description: "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments."
        )
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                // Header: Nút Skip
                HStack {
                    Spacer()
                    if currentPage < pages.count - 1 {
                        Button("Skip") {
                            withAnimation { currentPage = pages.count - 1 }
                        }
                        .foregroundColor(.gray)
                        .padding()
                    }
                }
                
                // Content: TabView vuốt trang
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(item: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Tắt chấm mặc định để tự làm đẹp hơn
                
                // Footer: Chấm tròn & Nút bấm
                VStack(spacing: 20) {
                    // Custom Dots Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(currentPage == index ? 1.2 : 1.0)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    
                    // Nút Next / Get Started
                    Button(action: {
                        if currentPage < pages.count - 1 {
                            withAnimation { currentPage += 1 }
                        } else {
                            // Kết thúc Onboarding
                            withAnimation { isCompleted = true }
                        }
                    }) {
                        Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// Subview: Giao diện chi tiết 1 trang
struct OnboardingPageView: View {
    let item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: item.image) // Thay bằng Image(item.image) nếu dùng ảnh Asset
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .foregroundColor(.blue) // Xóa dòng này nếu dùng ảnh thật
                .padding()
            
            Text(item.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            Text(item.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
        }
    }
}