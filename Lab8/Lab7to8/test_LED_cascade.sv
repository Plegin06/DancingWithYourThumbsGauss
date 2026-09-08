module test_LED_cascade #(
    parameter MAX_TILES = 3  // Change to 2 or 3 depending on your needs
)(
    input  logic               reset, clk, enable,
    input  logic               spawn_pulse, // Pulse high to drop a new random tile
    input  logic [1:0]         spawn_column,// The column chosen by your LFSR for the new tile
    output logic [15:0][15:0] pixels
);

    // Grid memory
    logic [15:0][3:0] pixel_div;
    
    // Arrays to track up to 3 tiles simultaneously
    logic [MAX_TILES-1:0][3:0] current_row;  // 3 independent row pointers
    logic [MAX_TILES-1:0][1:0] tile_column;  // 3 independent column trackers
    logic [MAX_TILES-1:0]      tile_active;  // High if that tile slot is currently on-screen

    // =====================================================================
    // 1. SEQUENTIAL LOGIC (Manages Spawning and Independent Falling)
    // =====================================================================
    always_ff @(posedge clk) begin
        if (reset) begin
            pixel_div   <= '0;
            current_row <= '0;
            tile_column <= '0;
            tile_active <= '0;
        end
        else begin
            // --- SPAWNING LOGIC ---
            // Look for an empty tracking slot to allocate to the new incoming tile
            if (spawn_pulse) begin
                if (!tile_active[0]) begin
                    tile_active[0] <= 1'b1;
                    current_row[0] <= '0;
                    tile_column[0] <= spawn_column;
                end
                else if (!tile_active[1]) begin
                    tile_active[1] <= 1'b1;
                    current_row[1] <= '0;
                    tile_column[1] <= spawn_column;
                end
                else if (MAX_TILES == 3 && !tile_active[2]) begin
                    tile_active[2] <= 1'b1;
                    current_row[2] <= '0;
                    tile_column[2] <= spawn_column;
                end
            end

            // --- MOVEMENT LOGIC ---
            if (enable) begin
                // Loop through and update every active tracker completely in parallel
                for (int t = 0; t < MAX_TILES; t++) begin
                    if (tile_active[t]) begin
                        
                        // 1. Standard Movement (Rows 0 to 14)
                        if (current_row[t] < 4'd15) begin
                            pixel_div[current_row[t]][tile_column[t]] <= 1'b1;
                            
                            if (current_row[t] > 4'd0) begin
                                pixel_div[current_row[t] - 1'b1][tile_column[t]] <= 1'b0;
                            end
                            
                            current_row[t] <= current_row[t] + 1'b1;
                        end
                        
                        // 2. Fall Off Screen & Reset Slot (Row 15)
                        else if (current_row[t] == 4'd15) begin
                            pixel_div[4'd15][tile_column[t]] <= 1'b0;
                            pixel_div[4'd14][tile_column[t]] <= 1'b0;
                            
                            // Free this channel slot up so a new tile can use it!
                            tile_active[t] <= 1'b0; 
                            current_row[t] <= '0;
                        end
                    end
                end
            end
        end
    end

    // =====================================================================
    // 2. COMBINATIONAL LOGIC (Assembles All Active Columns Simultaneously)
    // =====================================================================
    always_comb begin
        pixels = '0; // Default off to kill latches
        
        for (int i = 0; i < 16; i++) begin
            // Because multiple columns are now active at once, we map all 4 columns explicitly
            pixels[i][0  +: 4] = {4{pixel_div[i][0]}};
            pixels[i][4  +: 4] = {4{pixel_div[i][1]}};
            pixels[i][8  +: 4] = {4{pixel_div[i][2]}};
            pixels[i][12 +: 4] = {4{pixel_div[i][3]}};
        end
    end

endmodule
