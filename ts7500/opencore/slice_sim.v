`timescale 100ps/1ps

module slice_sim(

clock_200,
reset,

coefficient_read_adr,
coefficient_write_adr,
coefficient_write_data,
coefficient_write_en,

state_write_adr,
state_read_adr,

sigma_delta_stream_A,
sigma_delta_stream_B,

log_trigger,
sigma_delta_out_trigger,

overflow_stage_1,
overflow_stage_2,

log_value,
sigma_delta_out

);

/* Inputs and Outputs */

input          clock_200;
input          reset;

input [9:0]    coefficient_read_adr;
input [9:0]    coefficient_write_adr;
input [35:0]   coefficient_write_data;
input          coefficient_write_en;

input [3:0]    state_write_adr;
input [3:0]    state_read_adr;

input          log_trigger;
input          sigma_delta_out_trigger;

input          sigma_delta_stream_A;      // Add/sub signal for first add/sub module
input          sigma_delta_stream_B;      // Add/sub signal for second add/sub module

output         overflow_stage_1, overflow_stage_2;

output [23:0]  log_value;
output [23:0]  sigma_delta_out;

/* Internal wires and registers */

wire                  state_write_en;
wire signed [23:0]    state_value;           // Output of the state RAM

wire signed [17:0]    coefficient_A;         // First half of the coefficient read port
wire signed [17:0]    coefficient_B;         // Second half of the coefficient read port
wire signed [23:0]    coefficient_A_sign_ext;
wire signed [23:0]    coefficient_B_sign_ext;
wire                  coefficient_read_clk_en;

wire signed [23:0]    add_sub_result_A;      // Intermediate add/sub result (state +/- coefficient A)
wire signed [23:0]    add_sub_result_B;      // Final add/sub result (result A +/- coefficient B)

wire                  overflow_1, overflow_2;
wire                  add_sub_2_en;

assign coefficient_A_sign_ext = { {6{coefficient_A[17]}}, coefficient_A[17:0] };
assign coefficient_B_sign_ext = { {6{coefficient_B[17]}}, coefficient_B[17:0] };

lattice_ram_24bit_16word state_ram(

.WrAddress(state_write_adr[3:0]), 
.Data(add_sub_result_B[23:0]), 
.WrClock(clock_200), 
.WE(state_write_en), 
.WrClockEn(state_write_en), 
.RdAddress(state_read_adr[3:0]),
.Q(state_value[23:0])

);

lattice_ram_36bit_512 coefficient_ram(

.WrAddress(coefficient_write_adr[9:0]), 
.RdAddress(coefficient_read_adr[9:0]), 
.Data(coefficient_write_data), 
.WE(coefficient_write_en), 
.RdClock(clock_200), 
.RdClockEn(coefficient_read_clk_en), 
.Reset(reset), 
.WrClock(clock_200),
.WrClockEn(coefficient_write_en), 
.Q({coefficient_A[17:0], coefficient_B[17:0]})

);

// Calculate state +/- coefficient A
add_sub_24bit_no_outreg add_sub_1(

.DataA(state_value[23:0]),
.DataB(coefficient_A_sign_ext[23:0]),      // Perform sign extension on the 18 bit coefficients to make them 24 bits
.Add_Sub(sigma_delta_stream_A),
.Result(add_sub_result_A),
.Overflow(overflow_1)

);

// Calculate result of add_sub_1 +/- coefficient B
// This adder/subtractor has output registers
add_sub_24bit_with_outreg add_sub_2(

.DataA(add_sub_result_A),
.DataB(coefficient_B_sign_ext[23:0]),
.Add_Sub(sigma_delta_stream_B),
.Clock(clock_200),
.Reset(reset),
.ClockEn(add_sub_2_en), 
.Result(add_sub_result_B),
.Overflow(overflow_2)

);

endmodule