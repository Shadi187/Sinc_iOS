
import SwiftUI

struct NotAdded: View {
    var content:String = "Failed to Create account"
    var body: some View {
        ZStack{
            Group{
            RoundedRectangle(cornerRadius: 12)
                .frame(width:190,height:180)
                .foregroundStyle(Color.white)
            VStack{
                ZStack{
                    Image(systemName:"xmark")
                        .font(.largeTitle)
                        .foregroundStyle(Color.red)
                        
                    
                    Circle()
                        .stroke(lineWidth:2.0)
                        .frame(width: 100, height:100)
                        .foregroundStyle(Color.red)
                        
                }
                
                Text(content)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(Color.red)
            }
            .foregroundStyle(Color.white)
            .bold()
            
        }
        }
    }
}

#Preview {
    NotAdded()
}
