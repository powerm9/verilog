
module fsm(input clk, rst, b, output x);
    
reg [10:0] s;
reg [10:0] ns;

parameter A = 11'b1, B = 11'b11, C = 11'b110, D = 11'b1101, E = 11'b11011, F = 11'b110111,
          G = 11'b1101111, H = 11'b11011111,  I = 11'b110111110, J = 11'b1101111101, K = 11'b11011111010;

always @ (posedge clk)
    if (rst)
        s <= rst;
    else
        s <= ns;
        
always @ (*)
    case(s)
       rst: if(b) ns = A;   
            else  ns = rst;
           
        A : if(b) ns = B;   //1
            else  ns = rst;
            
        B : if(b) ns = A;   //11    11 -> 11
            else  ns = C;
            
        C : if(b) ns = D;   //110
            else  ns = rst;
            
        D : if(b) ns = E;   //1101
            else  ns = rst;  
            
        E : if(b) ns = F;   //11011    110 -> 110
            else  ns = C;
            
        F : if(b) ns = G;   //110111   110 -> 110
            else  ns = C; 
         
        G : if(b) ns = H;   //1101111  110 -> 110
            else  ns = C;
            
        H : if(b) ns = rst; //11011111 
            else  ns = I;
            
        I : if(b) ns = J;   //110111110 
            else  ns = rst;
            
        J : if(b) ns = E;   //1101111101
            else  ns = K;     
            
        K : if(b) ns = B;   //11011111010 
            else  ns = rst;      
            
         default: ns = rst;       
    endcase        
    
    assign x = (s == K);
    
endmodule