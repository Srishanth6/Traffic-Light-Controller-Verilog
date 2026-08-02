module traffic_light_controller (
    input clk,
    input reset,
    output reg NS_R,
    output reg NS_Y,
    output reg NS_G,
    output reg EW_R,
    output reg EW_Y,
    output reg EW_G
);
    // State encoding
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;
    parameter GREEN_TIME  = 10;
    parameter YELLOW_TIME = 3;
    reg [1:0] current_state;
    reg [1:0] next_state;
    reg [3:0] counter;
  
    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end
// Counter logic
always @(posedge clk or posedge reset)
begin
    if (reset)
        counter <= 0;
    else begin
        case (current_state)
            S0, S2: begin
                if (counter == GREEN_TIME - 1)
                    counter <= 0;
                else
                    counter <= counter + 1;
            end
            S1, S3: begin
                if (counter == YELLOW_TIME - 1)
                    counter <= 0;
                else
                    counter <= counter + 1;
            end
            default:
                counter <= 0;
        endcase
    end
end
  // Next-state logic
always @(*)
begin
    case (current_state)
        S0: begin
            if (counter == GREEN_TIME - 1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (counter == YELLOW_TIME - 1)
                next_state = S2;
            else
                next_state = S1;
        end
        S2: begin
            if (counter == GREEN_TIME - 1)
                next_state = S3;
            else
                next_state = S2;
        end
        S3: begin
            if (counter == YELLOW_TIME - 1)
                next_state = S0;
            else
                next_state = S3;
        end
        default: next_state = S0;
    endcase
end
  // Moore output logic
always @(*)
begin
    // Default outputs
    NS_R = 0;
    NS_Y = 0;
    NS_G = 0;
    EW_R = 0;
    EW_Y = 0;
    EW_G = 0;
    case (current_state)
        S0: begin
            NS_G = 1;
            EW_R = 1;
        end
        S1: begin
            NS_Y = 1;
            EW_R = 1;
        end
        S2: begin
            NS_R = 1;
            EW_G = 1;
        end
        S3: begin
            NS_R = 1;
            EW_Y = 1;
        end
        default: begin
            NS_R = 1;
            EW_R = 1;
        end
    endcase
end

endmodule
