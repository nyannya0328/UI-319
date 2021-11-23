
import SwiftUI
struct Home: View {
    @State var currentIndex : Int = 3
    @State var next = false
    
    @State var titleText : [TextAnimation] = []
    @State var titles = [
    
    "Clean your mind from",//,need
    "Unique experience",
    "The ultimate program",
    "Butiful Mountain"
    ]
    
    @State var subTitles = [
    
    "Negativity - stress - Anxiety",
    "Prepare your mind for sweet dream",
    "Healty mind - better sleep - well being",
    "The Moring coffee"
    
    ]
    @State var subTitleAnimation = false
    @State var endAnimation = false
    var body: some View {
        ZStack{
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                Color.black
                
                ForEach(1...4,id:\.self){index in
               
                    
                    Image("p\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .opacity(currentIndex == (index - 1) ? 1 : 0)
                }
                
                LinearGradient(colors:[.clear,.black.opacity(0.3),.black], startPoint: .top, endPoint: .bottom)
                 
            }
            .ignoresSafeArea()
            
            VStack(spacing:20){
                
                HStack{
                    
                    ForEach(titleText){text in
                        
                        Text(text.text)
                            .offset(y: text.offset)
                        
                        
                    }
                    .font(.title3.bold())
                }
                .offset(y: endAnimation ? -100 : 0)
                .opacity(endAnimation ? 0 : 1)
                
                Text(subTitles[currentIndex])
                    .opacity(0.4)
                    .offset(y: !subTitleAnimation ? 80 : 0)
                    .offset(y: endAnimation ? -100 : 0)
                    .opacity(endAnimation ? 0 : 1)
                
                SignInButton(image: "applelogo", title: "Sing in With apple", isSystem: true) {
                    
                    
                    next.toggle()
                    
                }
                .padding(.top)
                
                SignInButton(image: "google", title: "Sing in With google", isSystem: false) {
                    
                    
                }
                
                SignInButton(image: "facebook", title: "Sing in With FB", isSystem: false) {
                    
                    
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .overlay(
        
            ZStack{
                if next{
                    
                    a()
                }
            }
        
        )
        .onAppear(perform: {
            currentIndex = 0
        })
        .onChange(of: currentIndex) { newValue in
            
            
            getSplitedText(text: titles[currentIndex], competition: {
                
                //competion
                
                withAnimation(.easeInOut(duration: 1)){
                    
                    endAnimation.toggle()
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    
                    
                    titleText.removeAll()
                    subTitleAnimation.toggle()
                    endAnimation.toggle()
                    
                    withAnimation(.easeInOut(duration: 0.6)){
                        
                        if currentIndex < (titles.count - 1){
                            
                            
                            currentIndex += 1
                        }
                        
                        else{
                            
                            
                            currentIndex = 0
                        }
                        
                    }
         
                }
             })
            
        }
    }
    func getSplitedText(text : String,competition : @escaping()->()){
        
        for (index,character) in text.enumerated(){
            
            titleText.append(TextAnimation(text: String(character)))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                
                withAnimation(.easeInOut(duration: 0.5)){
                    
                    
                 titleText[index].offset = 0
                }
             }
            
        }
        
        //end for
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) * 0.02) {
            
            withAnimation(.easeInOut(duration: 0.5)){
                subTitleAnimation.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.96) {
                
                
                competition()
            }
            
        }
    }
}

struct SignInButton : View{
    
    var image,title : String
   
    var isSystem : Bool
    var onClick : ()->()
    
    var body: some View{
        
        
        HStack{
            
          (
          
            isSystem ? Image(systemName: image) : Image(image)
          
          )
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            
            Text(title)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(!isSystem ? .white : .black)
        .padding(.vertical,15)
        .padding(.horizontal,40)
        .background(
            
        
            
        
            .white.opacity(isSystem ? 1 : 0.2),in: Capsule()
        
        )
        .onTapGesture {
            onClick()
        }
        
    }
}
