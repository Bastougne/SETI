// (C) 1992-2014 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input [31:0] 		input_iterations,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		output 		lvb_bb0_cmp12,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb0_cmp12_inputs_ready;
 reg local_bb0_cmp12_wii_reg_NO_SHIFT_REG;
 reg local_bb0_cmp12_valid_out_NO_SHIFT_REG;
wire local_bb0_cmp12_stall_in;
wire local_bb0_cmp12_output_regs_ready;
 reg local_bb0_cmp12_NO_SHIFT_REG;
wire local_bb0_cmp12_causedstall;

assign local_bb0_cmp12_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_cmp12_output_regs_ready = (~(local_bb0_cmp12_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_cmp12_valid_out_NO_SHIFT_REG) | ~(local_bb0_cmp12_stall_in))));
assign merge_node_stall_in_0 = (~(local_bb0_cmp12_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp12_output_regs_ready) | ~(local_bb0_cmp12_inputs_ready)));
assign local_bb0_cmp12_causedstall = (local_bb0_cmp12_inputs_ready && (~(local_bb0_cmp12_output_regs_ready) && !(~(local_bb0_cmp12_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp12_NO_SHIFT_REG <= 'x;
		local_bb0_cmp12_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp12_NO_SHIFT_REG <= 'x;
			local_bb0_cmp12_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp12_output_regs_ready)
			begin
				local_bb0_cmp12_NO_SHIFT_REG <= (input_iterations == 32'hFFFFF869);
				local_bb0_cmp12_valid_out_NO_SHIFT_REG <= local_bb0_cmp12_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_cmp12_stall_in))
				begin
					local_bb0_cmp12_valid_out_NO_SHIFT_REG <= local_bb0_cmp12_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp12_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp12_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp12_inputs_ready)
			begin
				local_bb0_cmp12_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg lvb_bb0_cmp12_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_cmp12_valid_out_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_cmp12_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_cmp12 = lvb_bb0_cmp12_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb0_cmp12_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_cmp12_reg_NO_SHIFT_REG <= local_bb0_cmp12_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_iterations,
		input [63:0] 		input_frame_in,
		input [63:0] 		input_frame_out,
		input [31:0] 		input_threshold,
		input 		input_wii_cmp12,
		input 		valid_in_0,
		output 		stall_out_0,
		input 		input_forked_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input 		input_forked_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output 		valid_out_1,
		input 		stall_in_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input 		feedback_valid_in_0,
		output 		feedback_stall_out_0,
		input 		feedback_data_in_0,
		input 		feedback_valid_in_1,
		output 		feedback_stall_out_1,
		input 		feedback_data_in_1,
		output 		acl_pipelined_valid,
		input 		acl_pipelined_stall,
		output 		acl_pipelined_exiting_valid,
		output 		acl_pipelined_exiting_stall,
		input 		feedback_valid_in_11,
		output 		feedback_stall_out_11,
		input [3:0] 		feedback_data_in_11,
		input 		feedback_valid_in_13,
		output 		feedback_stall_out_13,
		input [3:0] 		feedback_data_in_13,
		input 		feedback_valid_in_10,
		output 		feedback_stall_out_10,
		input [63:0] 		feedback_data_in_10,
		input 		feedback_valid_in_12,
		output 		feedback_stall_out_12,
		input [10:0] 		feedback_data_in_12,
		output 		feedback_valid_out_11,
		input 		feedback_stall_in_11,
		output [3:0] 		feedback_data_out_11,
		output 		feedback_valid_out_0,
		input 		feedback_stall_in_0,
		output 		feedback_data_out_0,
		output 		feedback_valid_out_10,
		input 		feedback_stall_in_10,
		output [63:0] 		feedback_data_out_10,
		output 		feedback_valid_out_12,
		input 		feedback_stall_in_12,
		output [10:0] 		feedback_data_out_12,
		output 		feedback_valid_out_1,
		input 		feedback_stall_in_1,
		output 		feedback_data_out_1,
		output 		feedback_valid_out_13,
		input 		feedback_stall_in_13,
		output [3:0] 		feedback_data_out_13,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		output 		local_bb1_ld__active,
		input 		clock2x,
		input 		feedback_valid_in_6,
		output 		feedback_stall_out_6,
		input [31:0] 		feedback_data_in_6,
		input 		feedback_valid_in_7,
		output 		feedback_stall_out_7,
		input [31:0] 		feedback_data_in_7,
		input 		feedback_valid_in_3,
		output 		feedback_stall_out_3,
		input [31:0] 		feedback_data_in_3,
		output 		feedback_valid_out_3,
		input 		feedback_stall_in_3,
		output [31:0] 		feedback_data_out_3,
		output 		feedback_valid_out_6,
		input 		feedback_stall_in_6,
		output [31:0] 		feedback_data_out_6,
		input 		feedback_valid_in_2,
		output 		feedback_stall_out_2,
		input [31:0] 		feedback_data_in_2,
		output 		feedback_valid_out_5,
		input 		feedback_stall_in_5,
		output [31:0] 		feedback_data_out_5,
		output 		feedback_valid_out_7,
		input 		feedback_stall_in_7,
		output [31:0] 		feedback_data_out_7,
		input 		feedback_valid_in_4,
		output 		feedback_stall_out_4,
		input [31:0] 		feedback_data_in_4,
		input 		feedback_valid_in_5,
		output 		feedback_stall_out_5,
		input [31:0] 		feedback_data_in_5,
		output 		feedback_valid_out_4,
		input 		feedback_stall_in_4,
		output [31:0] 		feedback_data_out_4,
		input 		feedback_valid_in_8,
		output 		feedback_stall_out_8,
		input [31:0] 		feedback_data_in_8,
		input 		feedback_valid_in_9,
		output 		feedback_stall_out_9,
		input [31:0] 		feedback_data_in_9,
		output 		feedback_valid_out_8,
		input 		feedback_stall_in_8,
		output [31:0] 		feedback_data_out_8,
		output 		feedback_valid_out_2,
		input 		feedback_stall_in_2,
		output [31:0] 		feedback_data_out_2,
		output 		feedback_valid_out_9,
		input 		feedback_stall_in_9,
		output [31:0] 		feedback_data_out_9,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		output 		local_bb1_st_c0_exe1_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg input_forked_0_staging_reg_NO_SHIFT_REG;
 reg local_lvm_forked_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg input_forked_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_forked_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_forked_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_0_staging_reg_NO_SHIFT_REG <= input_forked_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_1_staging_reg_NO_SHIFT_REG <= input_forked_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c1_eni1_stall_local;
wire [15:0] local_bb1_c1_eni1;

assign local_bb1_c1_eni1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c1_eni1[8] = local_lvm_forked_NO_SHIFT_REG;
assign local_bb1_c1_eni1[15:9] = 7'bxxxxxxx;

// Register node:
//  * latency = 168
//  * capacity = 168
 logic rnode_1to169_forked_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_reg_169_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_1to169_forked_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_1to169_forked_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to169_forked_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to169_forked_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_1to169_forked_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_1to169_forked_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_lvm_forked_NO_SHIFT_REG),
	.data_out(rnode_1to169_forked_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_1to169_forked_0_reg_169_fifo.DEPTH = 169;
defparam rnode_1to169_forked_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_1to169_forked_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to169_forked_0_reg_169_fifo.IMPL = "ram";

assign rnode_1to169_forked_0_reg_169_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to169_forked_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_1to169_forked_0_NO_SHIFT_REG = rnode_1to169_forked_0_reg_169_NO_SHIFT_REG;
assign rnode_1to169_forked_0_stall_in_reg_169_NO_SHIFT_REG = rnode_1to169_forked_0_stall_in_NO_SHIFT_REG;
assign rnode_1to169_forked_0_valid_out_NO_SHIFT_REG = rnode_1to169_forked_0_valid_out_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_c1_ene1_valid_out_0;
wire local_bb1_c1_ene1_stall_in_0;
 reg local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG;
wire local_bb1_c1_ene1_valid_out_1;
wire local_bb1_c1_ene1_stall_in_1;
 reg local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG;
wire local_bb1_c1_enter_c1_eni1_inputs_ready;
wire local_bb1_c1_enter_c1_eni1_stall_local;
wire local_bb1_c1_enter_c1_eni1_input_accepted;
wire [15:0] local_bb1_c1_enter_c1_eni1;
wire local_bb1_c1_exit_c1_exi7_entry_stall;
wire local_bb1_c1_exit_c1_exi7_output_regs_ready;
wire [4:0] local_bb1_c1_exit_c1_exi7_valid_bits;
wire local_bb1_c1_exit_c1_exi7_phases;
wire local_bb1_c1_enter_c1_eni1_inc_pipelined_thread;
wire local_bb1_c1_enter_c1_eni1_dec_pipelined_thread;
wire local_bb1_c1_enter_c1_eni1_fu_stall_out;

assign local_bb1_c1_enter_c1_eni1_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_c1_enter_c1_eni1 = local_bb1_c1_eni1;
assign local_bb1_c1_enter_c1_eni1_input_accepted = (local_bb1_c1_enter_c1_eni1_inputs_ready && !(local_bb1_c1_exit_c1_exi7_entry_stall));
assign local_bb1_c1_enter_c1_eni1_inc_pipelined_thread = 1'b1;
assign local_bb1_c1_enter_c1_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c1_enter_c1_eni1_fu_stall_out = (~(local_bb1_c1_enter_c1_eni1_inputs_ready) | local_bb1_c1_exit_c1_exi7_entry_stall);
assign local_bb1_c1_enter_c1_eni1_stall_local = ((local_bb1_c1_ene1_stall_in_0 & ~(local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG)) | (local_bb1_c1_ene1_stall_in_1 & ~(local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG)));
assign local_bb1_c1_ene1_valid_out_0 = (local_bb1_c1_enter_c1_eni1_inputs_ready & ~(local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG));
assign local_bb1_c1_ene1_valid_out_1 = (local_bb1_c1_enter_c1_eni1_inputs_ready & ~(local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (|local_bb1_c1_enter_c1_eni1_fu_stall_out);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG <= (local_bb1_c1_enter_c1_eni1_inputs_ready & (local_bb1_c1_ene1_consumed_0_NO_SHIFT_REG | ~(local_bb1_c1_ene1_stall_in_0)) & local_bb1_c1_enter_c1_eni1_stall_local);
		local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG <= (local_bb1_c1_enter_c1_eni1_inputs_ready & (local_bb1_c1_ene1_consumed_1_NO_SHIFT_REG | ~(local_bb1_c1_ene1_stall_in_1)) & local_bb1_c1_enter_c1_eni1_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_forked_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_forked_1_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_stall_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_forked_0_reg_170_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_169to170_forked_0_reg_170_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_169to170_forked_0_reg_170_NO_SHIFT_REG),
	.valid_in(rnode_169to170_forked_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_forked_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.data_out(rnode_169to170_forked_0_reg_170_NO_SHIFT_REG_fa),
	.valid_out({rnode_169to170_forked_0_valid_out_0_NO_SHIFT_REG, rnode_169to170_forked_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_169to170_forked_0_stall_in_0_NO_SHIFT_REG, rnode_169to170_forked_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_169to170_forked_0_reg_170_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_169to170_forked_0_reg_170_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_169to170_forked_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_forked_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_forked_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_forked_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_forked_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_1to169_forked_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_forked_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_forked_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_forked_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_forked_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_forked_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_forked_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_1to169_forked_0_valid_out_NO_SHIFT_REG;
assign rnode_1to169_forked_0_stall_in_NO_SHIFT_REG = rnode_169to170_forked_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_forked_0_NO_SHIFT_REG = rnode_169to170_forked_0_reg_170_NO_SHIFT_REG_fa;
assign rnode_169to170_forked_1_NO_SHIFT_REG = rnode_169to170_forked_0_reg_170_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_c1_ene1_stall_local;
wire local_bb1_c1_ene1;

assign local_bb1_c1_ene1 = local_bb1_c1_enter_c1_eni1[8];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_stall_local;
wire [95:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c0_eni1[8] = rnode_169to170_forked_0_NO_SHIFT_REG;
assign local_bb1_c0_eni1[95:9] = 87'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

// This section implements a registered operation.
// 
wire local_bb1_keep_going_c1_ene1_inputs_ready;
 reg local_bb1_keep_going_c1_ene1_valid_out_0_NO_SHIFT_REG;
wire local_bb1_keep_going_c1_ene1_stall_in_0;
 reg local_bb1_keep_going_c1_ene1_valid_out_1_NO_SHIFT_REG;
wire local_bb1_keep_going_c1_ene1_stall_in_1;
 reg local_bb1_keep_going_c1_ene1_valid_out_2_NO_SHIFT_REG;
wire local_bb1_keep_going_c1_ene1_stall_in_2;
wire local_bb1_keep_going_c1_ene1_output_regs_ready;
wire local_bb1_keep_going_c1_ene1_keep_going;
wire local_bb1_keep_going_c1_ene1_fu_valid_out;
wire local_bb1_keep_going_c1_ene1_fu_stall_out;
 reg local_bb1_keep_going_c1_ene1_NO_SHIFT_REG;
wire local_bb1_keep_going_c1_ene1_feedback_pipelined;
wire local_bb1_keep_going_c1_ene1_causedstall;

acl_pipeline local_bb1_keep_going_c1_ene1_pipelined (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c1_ene1),
	.stall_out(local_bb1_keep_going_c1_ene1_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[0]),
	.valid_out(local_bb1_keep_going_c1_ene1_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_keep_going_c1_ene1_keep_going),
	.initeration_in(feedback_data_in_0),
	.initeration_valid_in(feedback_valid_in_0),
	.initeration_stall_out(feedback_stall_out_0),
	.not_exitcond_in(feedback_data_in_1),
	.not_exitcond_valid_in(feedback_valid_in_1),
	.not_exitcond_stall_out(feedback_stall_out_1),
	.pipeline_valid_out(acl_pipelined_valid),
	.pipeline_stall_in(acl_pipelined_stall),
	.exiting_valid_out(acl_pipelined_exiting_valid)
);

defparam local_bb1_keep_going_c1_ene1_pipelined.FIFO_DEPTH = 1;
defparam local_bb1_keep_going_c1_ene1_pipelined.STYLE = "SPECULATIVE";

assign local_bb1_keep_going_c1_ene1_inputs_ready = 1'b1;
assign local_bb1_keep_going_c1_ene1_output_regs_ready = 1'b1;
assign acl_pipelined_exiting_stall = acl_pipelined_stall;
assign local_bb1_c1_ene1_stall_in_0 = 1'b0;
assign local_bb1_keep_going_c1_ene1_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[0] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_keep_going_c1_ene1_NO_SHIFT_REG <= 'x;
		local_bb1_keep_going_c1_ene1_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_keep_going_c1_ene1_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_keep_going_c1_ene1_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_keep_going_c1_ene1_output_regs_ready)
		begin
			local_bb1_keep_going_c1_ene1_NO_SHIFT_REG <= local_bb1_keep_going_c1_ene1_keep_going;
			local_bb1_keep_going_c1_ene1_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_keep_going_c1_ene1_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_keep_going_c1_ene1_valid_out_2_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_keep_going_c1_ene1_stall_in_0))
			begin
				local_bb1_keep_going_c1_ene1_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_keep_going_c1_ene1_stall_in_1))
			begin
				local_bb1_keep_going_c1_ene1_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_keep_going_c1_ene1_stall_in_2))
			begin
				local_bb1_keep_going_c1_ene1_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_1_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c1_ene1_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_c1_ene1_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_c1_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_c1_ene1_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_c1_ene1_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_c1_ene1_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_c1_ene1),
	.data_out(rnode_1to2_bb1_c1_ene1_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_c1_ene1_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb1_c1_ene1_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb1_c1_ene1_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb1_c1_ene1_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb1_c1_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c1_ene1_stall_in_1 = 1'b0;
assign rnode_1to2_bb1_c1_ene1_0_stall_in_0_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_c1_ene1_0_NO_SHIFT_REG = rnode_1to2_bb1_c1_ene1_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_c1_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_c1_ene1_1_NO_SHIFT_REG = rnode_1to2_bb1_c1_ene1_0_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_keep_going_c1_ene1_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_0_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb1_keep_going_c1_ene1_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb1_keep_going_c1_ene1_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_keep_going_c1_ene1_stall_in_2 = 1'b0;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG = rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG = rnode_2to3_bb1_keep_going_c1_ene1_0_reg_3_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_initerations_pop11_acl_pop_i4_7_stall_local;
wire [3:0] local_bb1_initerations_pop11_acl_pop_i4_7;
wire local_bb1_initerations_pop11_acl_pop_i4_7_fu_valid_out;
wire local_bb1_initerations_pop11_acl_pop_i4_7_fu_stall_out;

acl_pop local_bb1_initerations_pop11_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_1to2_bb1_c1_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_initerations_pop11_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[1]),
	.valid_out(local_bb1_initerations_pop11_acl_pop_i4_7_fu_valid_out),
	.stall_in(local_bb1_initerations_pop11_acl_pop_i4_7_stall_local),
	.data_out(local_bb1_initerations_pop11_acl_pop_i4_7),
	.feedback_in(feedback_data_in_11),
	.feedback_valid_in(feedback_valid_in_11),
	.feedback_stall_out(feedback_stall_out_11)
);

defparam local_bb1_initerations_pop11_acl_pop_i4_7_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_initerations_pop11_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_pop11_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_pop11_acl_pop_i4_7_stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_1_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_2_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_valid_out_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_c1_ene1_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb1_c1_ene1_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb1_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb1_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb1_c1_ene1_0_valid_out_0_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb1_c1_ene1_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(rnode_1to2_bb1_c1_ene1_1_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb1_c1_ene1_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb1_c1_ene1_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb1_c1_ene1_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb1_c1_ene1_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb1_c1_ene1_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb1_c1_ene1_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_c1_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb1_c1_ene1_0_stall_in_0_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_c1_ene1_0_NO_SHIFT_REG = rnode_2to3_bb1_c1_ene1_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb1_c1_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_c1_ene1_1_NO_SHIFT_REG = rnode_2to3_bb1_c1_ene1_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb1_c1_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_c1_ene1_2_NO_SHIFT_REG = rnode_2to3_bb1_c1_ene1_0_reg_3_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_2_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_keep_going_c1_ene1_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_0_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_0_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb1_keep_going_c1_ene1_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_0_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG = rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG = rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_keep_going_c1_ene1_2_NO_SHIFT_REG = rnode_3to4_bb1_keep_going_c1_ene1_0_reg_4_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_stall_local;
wire [3:0] local_bb1_next_initerations;

assign local_bb1_next_initerations = (local_bb1_initerations_pop11_acl_pop_i4_7 >> 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cleanups_pop13_acl_pop_i4_7_valid_out;
wire local_bb1_cleanups_pop13_acl_pop_i4_7_stall_in;
wire local_bb1_cleanups_pop13_acl_pop_i4_7_inputs_ready;
wire local_bb1_cleanups_pop13_acl_pop_i4_7_stall_local;
wire [3:0] local_bb1_cleanups_pop13_acl_pop_i4_7;
wire local_bb1_cleanups_pop13_acl_pop_i4_7_fu_valid_out;
wire local_bb1_cleanups_pop13_acl_pop_i4_7_fu_stall_out;

acl_pop local_bb1_cleanups_pop13_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_2to3_bb1_c1_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_cleanups_pop13_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[2]),
	.valid_out(local_bb1_cleanups_pop13_acl_pop_i4_7_fu_valid_out),
	.stall_in(local_bb1_cleanups_pop13_acl_pop_i4_7_stall_local),
	.data_out(local_bb1_cleanups_pop13_acl_pop_i4_7),
	.feedback_in(feedback_data_in_13),
	.feedback_valid_in(feedback_valid_in_13),
	.feedback_stall_out(feedback_stall_out_13)
);

defparam local_bb1_cleanups_pop13_acl_pop_i4_7_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_cleanups_pop13_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_pop13_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_pop13_acl_pop_i4_7_inputs_ready = rnode_2to3_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cleanups_pop13_acl_pop_i4_7_stall_local = 1'b0;
assign local_bb1_cleanups_pop13_acl_pop_i4_7_valid_out = 1'b1;
assign rnode_2to3_bb1_c1_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_local;
wire [63:0] local_bb1_indvars_iv22_pop10_acl_pop_i64__1943;
wire local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_fu_valid_out;
wire local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_fu_stall_out;

acl_pop local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_2to3_bb1_c1_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(64'hFFFFFFFFFFFFF869),
	.stall_out(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[2]),
	.valid_out(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_fu_valid_out),
	.stall_in(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_local),
	.data_out(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943),
	.feedback_in(feedback_data_in_10),
	.feedback_valid_in(feedback_valid_in_10),
	.feedback_stall_out(feedback_stall_out_10)
);

defparam local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb1_c1_ene1_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_c1_ene1_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb1_c1_ene1_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb1_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb1_c1_ene1_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb1_c1_ene1_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb1_c1_ene1_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb1_c1_ene1_2_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb1_c1_ene1_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb1_c1_ene1_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb1_c1_ene1_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_3to4_bb1_c1_ene1_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb1_c1_ene1_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb1_c1_ene1_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_c1_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_c1_ene1_0_NO_SHIFT_REG = rnode_3to4_bb1_c1_ene1_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_c1_ene1_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_c1_ene1_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_stall_in_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_keep_going_c1_ene1_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_keep_going_c1_ene1_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_keep_going_c1_ene1_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_keep_going_c1_ene1_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb1_keep_going_c1_ene1_2_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG = rnode_4to5_bb1_keep_going_c1_ene1_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_keep_going_c1_ene1_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_keep_going_c1_ene1_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [3:0] local_bb1_var_;

assign local_bb1_var_ = (local_bb1_next_initerations & 4'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_0_NO_SHIFT_REG;
 logic [3:0] rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_1_NO_SHIFT_REG;
 logic [3:0] rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_1_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_0_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_0_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb1_cleanups_pop13_acl_pop_i4_7),
	.data_out(rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_fifo.DATA_WIDTH = 4;
defparam rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cleanups_pop13_acl_pop_i4_7_stall_in = 1'b0;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_0_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_NO_SHIFT_REG = rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_1_NO_SHIFT_REG = rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_reg_4_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv_next23_stall_local;
wire [63:0] local_bb1_indvars_iv_next23;

assign local_bb1_indvars_iv_next23 = (local_bb1_indvars_iv22_pop10_acl_pop_i64__1943 + 64'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_local;
wire [10:0] local_bb1_coalesce_counter_pop12_acl_pop_i11_967;
wire local_bb1_coalesce_counter_pop12_acl_pop_i11_967_fu_valid_out;
wire local_bb1_coalesce_counter_pop12_acl_pop_i11_967_fu_stall_out;

acl_pop local_bb1_coalesce_counter_pop12_acl_pop_i11_967_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_3to4_bb1_c1_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(11'h3C7),
	.stall_out(local_bb1_coalesce_counter_pop12_acl_pop_i11_967_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[3]),
	.valid_out(local_bb1_coalesce_counter_pop12_acl_pop_i11_967_fu_valid_out),
	.stall_in(local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_local),
	.data_out(local_bb1_coalesce_counter_pop12_acl_pop_i11_967),
	.feedback_in(feedback_data_in_12),
	.feedback_valid_in(feedback_valid_in_12),
	.feedback_stall_out(feedback_stall_out_12)
);

defparam local_bb1_coalesce_counter_pop12_acl_pop_i11_967_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_coalesce_counter_pop12_acl_pop_i11_967_feedback.DATA_WIDTH = 11;
defparam local_bb1_coalesce_counter_pop12_acl_pop_i11_967_feedback.STYLE = "REGULAR";

assign local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_valid_out_0;
wire local_bb1_next_initerations_stall_in_0;
 reg local_bb1_next_initerations_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_valid_out;
wire local_bb1_last_initeration_stall_in;
 reg local_bb1_last_initeration_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_inputs_ready;
wire local_bb1_last_initeration_stall_local;
wire local_bb1_last_initeration;

assign local_bb1_last_initeration_inputs_ready = rnode_1to2_bb1_c1_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_last_initeration = (local_bb1_var_ != 4'h0);
assign local_bb1_next_initerations_valid_out_0 = 1'b1;
assign local_bb1_last_initeration_valid_out = 1'b1;
assign rnode_1to2_bb1_c1_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_next_initerations_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_initerations_stall_in_0)) & local_bb1_last_initeration_stall_local);
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_last_initeration_consumed_0_NO_SHIFT_REG | ~(local_bb1_last_initeration_stall_in)) & local_bb1_last_initeration_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_var__u0_stall_local;
wire [3:0] local_bb1_var__u0;

assign local_bb1_var__u0 = (rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_NO_SHIFT_REG & 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_lftr_wideiv24_stall_local;
wire [31:0] local_bb1_lftr_wideiv24;

assign local_bb1_lftr_wideiv24 = local_bb1_indvars_iv_next23[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_coalesce_counter_lobit_stall_local;
wire [10:0] local_bb1_coalesce_counter_lobit;

assign local_bb1_coalesce_counter_lobit = (local_bb1_coalesce_counter_pop12_acl_pop_i11_967 >> 11'hA);

// This section implements a registered operation.
// 
wire local_bb1_initerations_push11_next_initerations_inputs_ready;
 reg local_bb1_initerations_push11_next_initerations_valid_out_NO_SHIFT_REG;
wire local_bb1_initerations_push11_next_initerations_stall_in;
wire local_bb1_initerations_push11_next_initerations_output_regs_ready;
wire [3:0] local_bb1_initerations_push11_next_initerations_result;
wire local_bb1_initerations_push11_next_initerations_fu_valid_out;
wire local_bb1_initerations_push11_next_initerations_fu_stall_out;
 reg [3:0] local_bb1_initerations_push11_next_initerations_NO_SHIFT_REG;
wire local_bb1_initerations_push11_next_initerations_causedstall;

acl_push local_bb1_initerations_push11_next_initerations_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_keep_going_c1_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_next_initerations),
	.stall_out(local_bb1_initerations_push11_next_initerations_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[1]),
	.valid_out(local_bb1_initerations_push11_next_initerations_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_initerations_push11_next_initerations_result),
	.feedback_out(feedback_data_out_11),
	.feedback_valid_out(feedback_valid_out_11),
	.feedback_stall_in(feedback_stall_in_11)
);

defparam local_bb1_initerations_push11_next_initerations_feedback.STALLFREE = 1;
defparam local_bb1_initerations_push11_next_initerations_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_push11_next_initerations_feedback.FIFO_DEPTH = 1;
defparam local_bb1_initerations_push11_next_initerations_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_initerations_push11_next_initerations_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_push11_next_initerations_inputs_ready = 1'b1;
assign local_bb1_initerations_push11_next_initerations_output_regs_ready = 1'b1;
assign local_bb1_next_initerations_stall_in_0 = 1'b0;
assign local_bb1_keep_going_c1_ene1_stall_in_0 = 1'b0;
assign local_bb1_initerations_push11_next_initerations_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[1] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_initerations_push11_next_initerations_NO_SHIFT_REG <= 'x;
		local_bb1_initerations_push11_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_initerations_push11_next_initerations_output_regs_ready)
		begin
			local_bb1_initerations_push11_next_initerations_NO_SHIFT_REG <= local_bb1_initerations_push11_next_initerations_result;
			local_bb1_initerations_push11_next_initerations_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_initerations_push11_next_initerations_stall_in))
			begin
				local_bb1_initerations_push11_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_lastiniteration_last_initeration_inputs_ready;
 reg local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_stall_in;
wire local_bb1_lastiniteration_last_initeration_output_regs_ready;
wire local_bb1_lastiniteration_last_initeration_result;
wire local_bb1_lastiniteration_last_initeration_fu_valid_out;
wire local_bb1_lastiniteration_last_initeration_fu_stall_out;
 reg local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_causedstall;

acl_push local_bb1_lastiniteration_last_initeration_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_keep_going_c1_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_last_initeration),
	.stall_out(local_bb1_lastiniteration_last_initeration_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[1]),
	.valid_out(local_bb1_lastiniteration_last_initeration_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_lastiniteration_last_initeration_result),
	.feedback_out(feedback_data_out_0),
	.feedback_valid_out(feedback_valid_out_0),
	.feedback_stall_in(feedback_stall_in_0)
);

defparam local_bb1_lastiniteration_last_initeration_feedback.STALLFREE = 1;
defparam local_bb1_lastiniteration_last_initeration_feedback.DATA_WIDTH = 1;
defparam local_bb1_lastiniteration_last_initeration_feedback.FIFO_DEPTH = 1;
defparam local_bb1_lastiniteration_last_initeration_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_lastiniteration_last_initeration_feedback.STYLE = "REGULAR";

assign local_bb1_lastiniteration_last_initeration_inputs_ready = 1'b1;
assign local_bb1_lastiniteration_last_initeration_output_regs_ready = 1'b1;
assign local_bb1_last_initeration_stall_in = 1'b0;
assign local_bb1_keep_going_c1_ene1_stall_in_1 = 1'b0;
assign local_bb1_lastiniteration_last_initeration_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[1] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= 'x;
		local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_lastiniteration_last_initeration_output_regs_ready)
		begin
			local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= local_bb1_lastiniteration_last_initeration_result;
			local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_lastiniteration_last_initeration_stall_in))
			begin
				local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_stall_local;
wire local_bb1_first_cleanup;

assign local_bb1_first_cleanup = (local_bb1_var__u0 != 4'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_valid_out_1;
wire local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_in_1;
 reg local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_consumed_1_NO_SHIFT_REG;
wire local_bb1_indvars_iv_next23_valid_out_0;
wire local_bb1_indvars_iv_next23_stall_in_0;
 reg local_bb1_indvars_iv_next23_consumed_0_NO_SHIFT_REG;
wire local_bb1_exitcond25_valid_out;
wire local_bb1_exitcond25_stall_in;
 reg local_bb1_exitcond25_consumed_0_NO_SHIFT_REG;
wire local_bb1_exitcond25_inputs_ready;
wire local_bb1_exitcond25_stall_local;
wire local_bb1_exitcond25;

assign local_bb1_exitcond25_inputs_ready = rnode_2to3_bb1_c1_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_exitcond25 = (local_bb1_lftr_wideiv24 == input_iterations);
assign local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_valid_out_1 = 1'b1;
assign local_bb1_indvars_iv_next23_valid_out_0 = 1'b1;
assign local_bb1_exitcond25_valid_out = 1'b1;
assign rnode_2to3_bb1_c1_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_indvars_iv_next23_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_exitcond25_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_consumed_1_NO_SHIFT_REG <= (local_bb1_exitcond25_inputs_ready & (local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_consumed_1_NO_SHIFT_REG | ~(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_in_1)) & local_bb1_exitcond25_stall_local);
		local_bb1_indvars_iv_next23_consumed_0_NO_SHIFT_REG <= (local_bb1_exitcond25_inputs_ready & (local_bb1_indvars_iv_next23_consumed_0_NO_SHIFT_REG | ~(local_bb1_indvars_iv_next23_stall_in_0)) & local_bb1_exitcond25_stall_local);
		local_bb1_exitcond25_consumed_0_NO_SHIFT_REG <= (local_bb1_exitcond25_inputs_ready & (local_bb1_exitcond25_consumed_0_NO_SHIFT_REG | ~(local_bb1_exitcond25_stall_in)) & local_bb1_exitcond25_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_next_coalesce_select_stall_local;
wire [10:0] local_bb1_next_coalesce_select;

assign local_bb1_next_coalesce_select = (local_bb1_coalesce_counter_lobit ^ 11'h1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_3to5_bb1_initerations_push11_next_initerations_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_initerations_push11_next_initerations_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_initerations_push11_next_initerations_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_fifo.DATA_WIDTH = 4;
defparam rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_initerations_push11_next_initerations_stall_in = 1'b0;
assign rnode_3to5_bb1_initerations_push11_next_initerations_0_NO_SHIFT_REG = rnode_3to5_bb1_initerations_push11_next_initerations_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_initerations_push11_next_initerations_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_lastiniteration_last_initeration_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lastiniteration_last_initeration_stall_in = 1'b0;
assign rnode_3to5_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG = rnode_3to5_bb1_lastiniteration_last_initeration_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_xor_stall_local;
wire local_bb1_xor;

assign local_bb1_xor = (local_bb1_first_cleanup ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_1_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_2_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_2_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_0_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_0_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_indvars_iv22_pop10_acl_pop_i64__1943),
	.data_out(rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_indvars_iv22_pop10_acl_pop_i64__1943_stall_in_1 = 1'b0;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_0_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_NO_SHIFT_REG = rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_1_NO_SHIFT_REG = rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_2_NO_SHIFT_REG = rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_reg_5_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_inputs_ready;
 reg local_bb1_indvars_iv22_push10_indvars_iv_next23_valid_out_NO_SHIFT_REG;
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_stall_in;
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_output_regs_ready;
wire [63:0] local_bb1_indvars_iv22_push10_indvars_iv_next23_result;
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_fu_valid_out;
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_fu_stall_out;
 reg [63:0] local_bb1_indvars_iv22_push10_indvars_iv_next23_NO_SHIFT_REG;
wire local_bb1_indvars_iv22_push10_indvars_iv_next23_causedstall;

acl_push local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_2to3_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_indvars_iv_next23),
	.stall_out(local_bb1_indvars_iv22_push10_indvars_iv_next23_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[2]),
	.valid_out(local_bb1_indvars_iv22_push10_indvars_iv_next23_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_indvars_iv22_push10_indvars_iv_next23_result),
	.feedback_out(feedback_data_out_10),
	.feedback_valid_out(feedback_valid_out_10),
	.feedback_stall_in(feedback_stall_in_10)
);

defparam local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback.STALLFREE = 1;
defparam local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback.FIFO_DEPTH = 1;
defparam local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_indvars_iv22_push10_indvars_iv_next23_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv22_push10_indvars_iv_next23_inputs_ready = 1'b1;
assign local_bb1_indvars_iv22_push10_indvars_iv_next23_output_regs_ready = 1'b1;
assign local_bb1_indvars_iv_next23_stall_in_0 = 1'b0;
assign rnode_2to3_bb1_keep_going_c1_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_indvars_iv22_push10_indvars_iv_next23_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv22_push10_indvars_iv_next23_NO_SHIFT_REG <= 'x;
		local_bb1_indvars_iv22_push10_indvars_iv_next23_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_indvars_iv22_push10_indvars_iv_next23_output_regs_ready)
		begin
			local_bb1_indvars_iv22_push10_indvars_iv_next23_NO_SHIFT_REG <= local_bb1_indvars_iv22_push10_indvars_iv_next23_result;
			local_bb1_indvars_iv22_push10_indvars_iv_next23_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_indvars_iv22_push10_indvars_iv_next23_stall_in))
			begin
				local_bb1_indvars_iv22_push10_indvars_iv_next23_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb1_exitcond25_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond25_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb1_exitcond25_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb1_exitcond25_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb1_exitcond25_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb1_exitcond25_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb1_exitcond25_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb1_exitcond25),
	.data_out(rnode_3to4_bb1_exitcond25_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb1_exitcond25_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb1_exitcond25_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_3to4_bb1_exitcond25_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb1_exitcond25_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb1_exitcond25_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_exitcond25_stall_in = 1'b0;
assign rnode_3to4_bb1_exitcond25_0_NO_SHIFT_REG = rnode_3to4_bb1_exitcond25_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_exitcond25_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_exitcond25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_coalesce_counter_pop12_acl_pop_i11_967_valid_out_2;
wire local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_in_2;
 reg local_bb1_coalesce_counter_pop12_acl_pop_i11_967_consumed_2_NO_SHIFT_REG;
wire local_bb1_next_coalesce_valid_out;
wire local_bb1_next_coalesce_stall_in;
 reg local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_coalesce_inputs_ready;
wire local_bb1_next_coalesce_stall_local;
wire [10:0] local_bb1_next_coalesce;

assign local_bb1_next_coalesce_inputs_ready = rnode_3to4_bb1_c1_ene1_0_valid_out_NO_SHIFT_REG;
assign local_bb1_next_coalesce = (local_bb1_coalesce_counter_pop12_acl_pop_i11_967 - local_bb1_next_coalesce_select);
assign local_bb1_coalesce_counter_pop12_acl_pop_i11_967_valid_out_2 = 1'b1;
assign local_bb1_next_coalesce_valid_out = 1'b1;
assign rnode_3to4_bb1_c1_ene1_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_coalesce_counter_pop12_acl_pop_i11_967_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_coalesce_counter_pop12_acl_pop_i11_967_consumed_2_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_coalesce_counter_pop12_acl_pop_i11_967_consumed_2_NO_SHIFT_REG | ~(local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_in_2)) & local_bb1_next_coalesce_stall_local);
		local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_coalesce_stall_in)) & local_bb1_next_coalesce_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_var__u1_stall_local;
wire [31:0] local_bb1_var__u1;

assign local_bb1_var__u1 = rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_NO_SHIFT_REG[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx6_stall_local;
wire [63:0] local_bb1_arrayidx6;

assign local_bb1_arrayidx6 = (input_frame_in + (rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_1_NO_SHIFT_REG << 6'h2));

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx52_stall_local;
wire [63:0] local_bb1_arrayidx52;

assign local_bb1_arrayidx52 = (input_frame_out + (rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_2_NO_SHIFT_REG << 6'h2));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_indvars_iv22_push10_indvars_iv_next23_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_indvars_iv22_push10_indvars_iv_next23_stall_in = 1'b0;
assign rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_NO_SHIFT_REG = rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u2_stall_local;
wire local_bb1_var__u2;

assign local_bb1_var__u2 = (input_wii_cmp12 | rnode_3to4_bb1_exitcond25_0_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_coalesce_counter_pop12_acl_pop_i11_967),
	.data_out(rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_fifo.DATA_WIDTH = 11;
defparam rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_coalesce_counter_pop12_acl_pop_i11_967_stall_in_2 = 1'b0;
assign rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_NO_SHIFT_REG = rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_coalesce_counter_push12_next_coalesce_inputs_ready;
 reg local_bb1_coalesce_counter_push12_next_coalesce_valid_out_NO_SHIFT_REG;
wire local_bb1_coalesce_counter_push12_next_coalesce_stall_in;
wire local_bb1_coalesce_counter_push12_next_coalesce_output_regs_ready;
wire [10:0] local_bb1_coalesce_counter_push12_next_coalesce_result;
wire local_bb1_coalesce_counter_push12_next_coalesce_fu_valid_out;
wire local_bb1_coalesce_counter_push12_next_coalesce_fu_stall_out;
 reg [10:0] local_bb1_coalesce_counter_push12_next_coalesce_NO_SHIFT_REG;
wire local_bb1_coalesce_counter_push12_next_coalesce_causedstall;

acl_push local_bb1_coalesce_counter_push12_next_coalesce_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_3to4_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_next_coalesce),
	.stall_out(local_bb1_coalesce_counter_push12_next_coalesce_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[3]),
	.valid_out(local_bb1_coalesce_counter_push12_next_coalesce_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_coalesce_counter_push12_next_coalesce_result),
	.feedback_out(feedback_data_out_12),
	.feedback_valid_out(feedback_valid_out_12),
	.feedback_stall_in(feedback_stall_in_12)
);

defparam local_bb1_coalesce_counter_push12_next_coalesce_feedback.STALLFREE = 1;
defparam local_bb1_coalesce_counter_push12_next_coalesce_feedback.DATA_WIDTH = 11;
defparam local_bb1_coalesce_counter_push12_next_coalesce_feedback.FIFO_DEPTH = 1;
defparam local_bb1_coalesce_counter_push12_next_coalesce_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_coalesce_counter_push12_next_coalesce_feedback.STYLE = "REGULAR";

assign local_bb1_coalesce_counter_push12_next_coalesce_inputs_ready = 1'b1;
assign local_bb1_coalesce_counter_push12_next_coalesce_output_regs_ready = 1'b1;
assign local_bb1_next_coalesce_stall_in = 1'b0;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_coalesce_counter_push12_next_coalesce_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_coalesce_counter_push12_next_coalesce_NO_SHIFT_REG <= 'x;
		local_bb1_coalesce_counter_push12_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_coalesce_counter_push12_next_coalesce_output_regs_ready)
		begin
			local_bb1_coalesce_counter_push12_next_coalesce_NO_SHIFT_REG <= local_bb1_coalesce_counter_push12_next_coalesce_result;
			local_bb1_coalesce_counter_push12_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_coalesce_counter_push12_next_coalesce_stall_in))
			begin
				local_bb1_coalesce_counter_push12_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp4_stall_local;
wire local_bb1_cmp4;

assign local_bb1_cmp4 = ($signed(local_bb1_var__u1) > $signed(32'hFFFFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb1_notexit_stall_local;
wire local_bb1_notexit;

assign local_bb1_notexit = (local_bb1_var__u2 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_stall_local;
wire local_bb1_or;

assign local_bb1_or = (local_bb1_var__u2 | local_bb1_xor);

// This section implements an unregistered operation.
// 
wire local_bb1_masked_stall_local;
wire local_bb1_masked;

assign local_bb1_masked = (local_bb1_var__u2 & local_bb1_first_cleanup);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi1_stall_local;
wire [319:0] local_bb1_c1_exi1;

assign local_bb1_c1_exi1[15:0] = 16'bxxxxxxxxxxxxxxxx;
assign local_bb1_c1_exi1[26:16] = rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_NO_SHIFT_REG;
assign local_bb1_c1_exi1[319:27] = 293'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp4_xor_stall_local;
wire local_bb1_cmp4_xor;

assign local_bb1_cmp4_xor = (local_bb1_cmp4 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_cleanups_shl_stall_local;
wire [3:0] local_bb1_cleanups_shl;

assign local_bb1_cleanups_shl[3:1] = 3'h0;
assign local_bb1_cleanups_shl[0] = local_bb1_or;

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi2_stall_local;
wire [319:0] local_bb1_c1_exi2;

assign local_bb1_c1_exi2[31:0] = local_bb1_c1_exi1[31:0];
assign local_bb1_c1_exi2[32] = rnode_4to5_bb1_keep_going_c1_ene1_0_NO_SHIFT_REG;
assign local_bb1_c1_exi2[319:33] = local_bb1_c1_exi1[319:33];

// This section implements an unregistered operation.
// 
wire local_bb1_cmp12_phi_decision595_or_stall_local;
wire local_bb1_cmp12_phi_decision595_or;

assign local_bb1_cmp12_phi_decision595_or = (input_wii_cmp12 | local_bb1_cmp4_xor);

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_valid_out_1;
wire local_bb1_first_cleanup_stall_in_1;
 reg local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG;
wire local_bb1_xor_valid_out_1;
wire local_bb1_xor_stall_in_1;
 reg local_bb1_xor_consumed_1_NO_SHIFT_REG;
wire local_bb1_masked_valid_out;
wire local_bb1_masked_stall_in;
 reg local_bb1_masked_consumed_0_NO_SHIFT_REG;
wire local_bb1_notexit_valid_out;
wire local_bb1_notexit_stall_in;
 reg local_bb1_notexit_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_cleanups_valid_out;
wire local_bb1_next_cleanups_stall_in;
 reg local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_cleanups_inputs_ready;
wire local_bb1_next_cleanups_stall_local;
wire [3:0] local_bb1_next_cleanups;

assign local_bb1_next_cleanups_inputs_ready = (rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_0_NO_SHIFT_REG & rnode_3to4_bb1_exitcond25_0_valid_out_NO_SHIFT_REG & rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_next_cleanups = (rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_1_NO_SHIFT_REG << local_bb1_cleanups_shl);
assign local_bb1_first_cleanup_valid_out_1 = 1'b1;
assign local_bb1_xor_valid_out_1 = 1'b1;
assign local_bb1_masked_valid_out = 1'b1;
assign local_bb1_notexit_valid_out = 1'b1;
assign local_bb1_next_cleanups_valid_out = 1'b1;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_exitcond25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_cleanups_pop13_acl_pop_i4_7_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_xor_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG | ~(local_bb1_first_cleanup_stall_in_1)) & local_bb1_next_cleanups_stall_local);
		local_bb1_xor_consumed_1_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_xor_consumed_1_NO_SHIFT_REG | ~(local_bb1_xor_stall_in_1)) & local_bb1_next_cleanups_stall_local);
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_masked_consumed_0_NO_SHIFT_REG | ~(local_bb1_masked_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_notexit_consumed_0_NO_SHIFT_REG | ~(local_bb1_notexit_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_cleanups_stall_in)) & local_bb1_next_cleanups_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi3_stall_local;
wire [319:0] local_bb1_c1_exi3;

assign local_bb1_c1_exi3[39:0] = local_bb1_c1_exi2[39:0];
assign local_bb1_c1_exi3[40] = local_bb1_cmp4;
assign local_bb1_c1_exi3[319:41] = local_bb1_c1_exi2[319:41];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_xor_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_stall_in_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_xor_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_xor_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_xor_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_xor_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_xor_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_xor_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_xor),
	.data_out(rnode_4to5_bb1_xor_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_xor_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_xor_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_4to5_bb1_xor_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_xor_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_xor_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_xor_stall_in_1 = 1'b0;
assign rnode_4to5_bb1_xor_0_NO_SHIFT_REG = rnode_4to5_bb1_xor_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_xor_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_xor_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_masked_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_stall_in_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_masked_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_masked_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_masked_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_masked_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_masked_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_masked_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_masked),
	.data_out(rnode_4to5_bb1_masked_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_masked_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_masked_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_4to5_bb1_masked_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_masked_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_masked_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_masked_stall_in = 1'b0;
assign rnode_4to5_bb1_masked_0_NO_SHIFT_REG = rnode_4to5_bb1_masked_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_masked_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_masked_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_notexitcond_notexit_inputs_ready;
 reg local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_stall_in;
wire local_bb1_notexitcond_notexit_output_regs_ready;
wire local_bb1_notexitcond_notexit_result;
wire local_bb1_notexitcond_notexit_fu_valid_out;
wire local_bb1_notexitcond_notexit_fu_stall_out;
 reg local_bb1_notexitcond_notexit_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_causedstall;

acl_push local_bb1_notexitcond_notexit_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_first_cleanup),
	.predicate(1'b0),
	.data_in(local_bb1_notexit),
	.stall_out(local_bb1_notexitcond_notexit_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[3]),
	.valid_out(local_bb1_notexitcond_notexit_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_notexitcond_notexit_result),
	.feedback_out(feedback_data_out_1),
	.feedback_valid_out(feedback_valid_out_1),
	.feedback_stall_in(feedback_stall_in_1)
);

defparam local_bb1_notexitcond_notexit_feedback.STALLFREE = 1;
defparam local_bb1_notexitcond_notexit_feedback.DATA_WIDTH = 1;
defparam local_bb1_notexitcond_notexit_feedback.FIFO_DEPTH = 3;
defparam local_bb1_notexitcond_notexit_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_notexitcond_notexit_feedback.STYLE = "REGULAR";

assign local_bb1_notexitcond_notexit_inputs_ready = 1'b1;
assign local_bb1_notexitcond_notexit_output_regs_ready = 1'b1;
assign local_bb1_notexit_stall_in = 1'b0;
assign local_bb1_first_cleanup_stall_in_1 = 1'b0;
assign local_bb1_notexitcond_notexit_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_notexitcond_notexit_NO_SHIFT_REG <= 'x;
		local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_notexitcond_notexit_output_regs_ready)
		begin
			local_bb1_notexitcond_notexit_NO_SHIFT_REG <= local_bb1_notexitcond_notexit_result;
			local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_notexitcond_notexit_stall_in))
			begin
				local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_cleanups_push13_next_cleanups_inputs_ready;
 reg local_bb1_cleanups_push13_next_cleanups_valid_out_NO_SHIFT_REG;
wire local_bb1_cleanups_push13_next_cleanups_stall_in;
wire local_bb1_cleanups_push13_next_cleanups_output_regs_ready;
wire [3:0] local_bb1_cleanups_push13_next_cleanups_result;
wire local_bb1_cleanups_push13_next_cleanups_fu_valid_out;
wire local_bb1_cleanups_push13_next_cleanups_fu_stall_out;
 reg [3:0] local_bb1_cleanups_push13_next_cleanups_NO_SHIFT_REG;
wire local_bb1_cleanups_push13_next_cleanups_causedstall;

acl_push local_bb1_cleanups_push13_next_cleanups_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_3to4_bb1_keep_going_c1_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_next_cleanups),
	.stall_out(local_bb1_cleanups_push13_next_cleanups_fu_stall_out),
	.valid_in(local_bb1_c1_exit_c1_exi7_valid_bits[3]),
	.valid_out(local_bb1_cleanups_push13_next_cleanups_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_cleanups_push13_next_cleanups_result),
	.feedback_out(feedback_data_out_13),
	.feedback_valid_out(feedback_valid_out_13),
	.feedback_stall_in(feedback_stall_in_13)
);

defparam local_bb1_cleanups_push13_next_cleanups_feedback.STALLFREE = 1;
defparam local_bb1_cleanups_push13_next_cleanups_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_push13_next_cleanups_feedback.FIFO_DEPTH = 1;
defparam local_bb1_cleanups_push13_next_cleanups_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_cleanups_push13_next_cleanups_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_push13_next_cleanups_inputs_ready = 1'b1;
assign local_bb1_cleanups_push13_next_cleanups_output_regs_ready = 1'b1;
assign local_bb1_next_cleanups_stall_in = 1'b0;
assign rnode_3to4_bb1_keep_going_c1_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_cleanups_push13_next_cleanups_causedstall = (local_bb1_c1_exit_c1_exi7_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cleanups_push13_next_cleanups_NO_SHIFT_REG <= 'x;
		local_bb1_cleanups_push13_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_cleanups_push13_next_cleanups_output_regs_ready)
		begin
			local_bb1_cleanups_push13_next_cleanups_NO_SHIFT_REG <= local_bb1_cleanups_push13_next_cleanups_result;
			local_bb1_cleanups_push13_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_cleanups_push13_next_cleanups_stall_in))
			begin
				local_bb1_cleanups_push13_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi4_stall_local;
wire [319:0] local_bb1_c1_exi4;

assign local_bb1_c1_exi4[63:0] = local_bb1_c1_exi3[63:0];
assign local_bb1_c1_exi4[127:64] = local_bb1_arrayidx6;
assign local_bb1_c1_exi4[319:128] = local_bb1_c1_exi3[319:128];

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_xor_or_stall_local;
wire local_bb1_first_cleanup_xor_or;

assign local_bb1_first_cleanup_xor_or = (local_bb1_cmp12_phi_decision595_or | rnode_4to5_bb1_xor_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi5_stall_local;
wire [319:0] local_bb1_c1_exi5;

assign local_bb1_c1_exi5[127:0] = local_bb1_c1_exi4[127:0];
assign local_bb1_c1_exi5[128] = local_bb1_first_cleanup_xor_or;
assign local_bb1_c1_exi5[319:129] = local_bb1_c1_exi4[319:129];

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi6_stall_local;
wire [319:0] local_bb1_c1_exi6;

assign local_bb1_c1_exi6[191:0] = local_bb1_c1_exi5[191:0];
assign local_bb1_c1_exi6[255:192] = local_bb1_arrayidx52;
assign local_bb1_c1_exi6[319:256] = local_bb1_c1_exi5[319:256];

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exi7_valid_out;
wire local_bb1_c1_exi7_stall_in;
wire local_bb1_c1_exi7_inputs_ready;
wire local_bb1_c1_exi7_stall_local;
wire [319:0] local_bb1_c1_exi7;

assign local_bb1_c1_exi7_inputs_ready = (rnode_4to5_bb1_keep_going_c1_ene1_0_valid_out_NO_SHIFT_REG & rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_1_NO_SHIFT_REG & rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_0_NO_SHIFT_REG & rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_valid_out_NO_SHIFT_REG & rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_valid_out_2_NO_SHIFT_REG & rnode_4to5_bb1_masked_0_valid_out_NO_SHIFT_REG & rnode_4to5_bb1_xor_0_valid_out_NO_SHIFT_REG);
assign local_bb1_c1_exi7[255:0] = local_bb1_c1_exi6[255:0];
assign local_bb1_c1_exi7[256] = rnode_4to5_bb1_masked_0_NO_SHIFT_REG;
assign local_bb1_c1_exi7[319:257] = local_bb1_c1_exi6[319:257];
assign local_bb1_c1_exi7_valid_out = 1'b1;
assign rnode_4to5_bb1_keep_going_c1_ene1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_coalesce_counter_pop12_acl_pop_i11_967_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_indvars_iv22_pop10_acl_pop_i64__1943_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_masked_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_xor_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c1_exit_c1_exi7_inputs_ready;
 reg local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_0;
 reg local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_1;
 reg local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_2;
 reg local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_3;
 reg local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_4;
 reg local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_5;
 reg local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG;
wire local_bb1_c1_exit_c1_exi7_stall_in_6;
 reg [319:0] local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG;
wire [319:0] local_bb1_c1_exit_c1_exi7_in;
wire local_bb1_c1_exit_c1_exi7_valid;
wire local_bb1_c1_exit_c1_exi7_causedstall;

acl_stall_free_sink local_bb1_c1_exit_c1_exi7_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c1_exi7),
	.data_out(local_bb1_c1_exit_c1_exi7_in),
	.input_accepted(local_bb1_c1_enter_c1_eni1_input_accepted),
	.valid_out(local_bb1_c1_exit_c1_exi7_valid),
	.stall_in(~(local_bb1_c1_exit_c1_exi7_output_regs_ready)),
	.stall_entry(local_bb1_c1_exit_c1_exi7_entry_stall),
	.valids(local_bb1_c1_exit_c1_exi7_valid_bits),
	.IIphases(local_bb1_c1_exit_c1_exi7_phases),
	.inc_pipelined_thread(local_bb1_c1_enter_c1_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c1_enter_c1_eni1_dec_pipelined_thread)
);

defparam local_bb1_c1_exit_c1_exi7_instance.DATA_WIDTH = 320;
defparam local_bb1_c1_exit_c1_exi7_instance.PIPELINE_DEPTH = 9;
defparam local_bb1_c1_exit_c1_exi7_instance.SHARINGII = 1;
defparam local_bb1_c1_exit_c1_exi7_instance.SCHEDULEII = 1;

assign local_bb1_c1_exit_c1_exi7_inputs_ready = 1'b1;
assign local_bb1_c1_exit_c1_exi7_output_regs_ready = ((~(local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_0)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_1)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_2)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_3)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_4)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_5)) & (~(local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG) | ~(local_bb1_c1_exit_c1_exi7_stall_in_6)));
assign local_bb1_c1_exi7_stall_in = 1'b0;
assign local_bb1_coalesce_counter_push12_next_coalesce_stall_in = 1'b0;
assign local_bb1_notexitcond_notexit_stall_in = 1'b0;
assign local_bb1_cleanups_push13_next_cleanups_stall_in = 1'b0;
assign rnode_3to5_bb1_initerations_push11_next_initerations_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_indvars_iv22_push10_indvars_iv_next23_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb1_c1_exit_c1_exi7_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c1_exit_c1_exi7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG <= 'x;
		local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c1_exit_c1_exi7_output_regs_ready)
		begin
			local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_in;
			local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
			local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG <= local_bb1_c1_exit_c1_exi7_valid;
		end
		else
		begin
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_0))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_1))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_2))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_3))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_4))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_5))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c1_exit_c1_exi7_stall_in_6))
			begin
				local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe1_valid_out;
wire local_bb1_c1_exe1_stall_in;
wire local_bb1_c1_exe1_inputs_ready;
wire local_bb1_c1_exe1_stall_local;
wire [10:0] local_bb1_c1_exe1;

assign local_bb1_c1_exe1_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_0_NO_SHIFT_REG;
assign local_bb1_c1_exe1 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[26:16];
assign local_bb1_c1_exe1_valid_out = local_bb1_c1_exe1_inputs_ready;
assign local_bb1_c1_exe1_stall_local = local_bb1_c1_exe1_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_0 = (|local_bb1_c1_exe1_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe2_valid_out;
wire local_bb1_c1_exe2_stall_in;
wire local_bb1_c1_exe2_inputs_ready;
wire local_bb1_c1_exe2_stall_local;
wire local_bb1_c1_exe2;

assign local_bb1_c1_exe2_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_1_NO_SHIFT_REG;
assign local_bb1_c1_exe2 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[32];
assign local_bb1_c1_exe2_valid_out = local_bb1_c1_exe2_inputs_ready;
assign local_bb1_c1_exe2_stall_local = local_bb1_c1_exe2_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_1 = (|local_bb1_c1_exe2_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe3_valid_out;
wire local_bb1_c1_exe3_stall_in;
wire local_bb1_c1_exe3_inputs_ready;
wire local_bb1_c1_exe3_stall_local;
wire local_bb1_c1_exe3;

assign local_bb1_c1_exe3_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_2_NO_SHIFT_REG;
assign local_bb1_c1_exe3 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[40];
assign local_bb1_c1_exe3_valid_out = local_bb1_c1_exe3_inputs_ready;
assign local_bb1_c1_exe3_stall_local = local_bb1_c1_exe3_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_2 = (|local_bb1_c1_exe3_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe4_valid_out;
wire local_bb1_c1_exe4_stall_in;
wire local_bb1_c1_exe4_inputs_ready;
wire local_bb1_c1_exe4_stall_local;
wire [63:0] local_bb1_c1_exe4;

assign local_bb1_c1_exe4_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_3_NO_SHIFT_REG;
assign local_bb1_c1_exe4 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[127:64];
assign local_bb1_c1_exe4_valid_out = local_bb1_c1_exe4_inputs_ready;
assign local_bb1_c1_exe4_stall_local = local_bb1_c1_exe4_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_3 = (|local_bb1_c1_exe4_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe5_valid_out;
wire local_bb1_c1_exe5_stall_in;
wire local_bb1_c1_exe5_inputs_ready;
wire local_bb1_c1_exe5_stall_local;
wire local_bb1_c1_exe5;

assign local_bb1_c1_exe5_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_4_NO_SHIFT_REG;
assign local_bb1_c1_exe5 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[128];
assign local_bb1_c1_exe5_valid_out = local_bb1_c1_exe5_inputs_ready;
assign local_bb1_c1_exe5_stall_local = local_bb1_c1_exe5_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_4 = (|local_bb1_c1_exe5_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe6_valid_out;
wire local_bb1_c1_exe6_stall_in;
wire local_bb1_c1_exe6_inputs_ready;
wire local_bb1_c1_exe6_stall_local;
wire [63:0] local_bb1_c1_exe6;

assign local_bb1_c1_exe6_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_5_NO_SHIFT_REG;
assign local_bb1_c1_exe6 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[255:192];
assign local_bb1_c1_exe6_valid_out = local_bb1_c1_exe6_inputs_ready;
assign local_bb1_c1_exe6_stall_local = local_bb1_c1_exe6_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_5 = (|local_bb1_c1_exe6_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_c1_exe7_valid_out;
wire local_bb1_c1_exe7_stall_in;
wire local_bb1_c1_exe7_inputs_ready;
wire local_bb1_c1_exe7_stall_local;
wire local_bb1_c1_exe7;

assign local_bb1_c1_exe7_inputs_ready = local_bb1_c1_exit_c1_exi7_valid_out_6_NO_SHIFT_REG;
assign local_bb1_c1_exe7 = local_bb1_c1_exit_c1_exi7_NO_SHIFT_REG[256];
assign local_bb1_c1_exe7_valid_out = local_bb1_c1_exe7_inputs_ready;
assign local_bb1_c1_exe7_stall_local = local_bb1_c1_exe7_stall_in;
assign local_bb1_c1_exit_c1_exi7_stall_in_6 = (|local_bb1_c1_exe7_stall_local);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_10to169_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_10to169_bb1_c1_exe1_0_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe1_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_10to169_bb1_c1_exe1_0_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe1_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe1_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe1_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_10to169_bb1_c1_exe1_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to169_bb1_c1_exe1_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to169_bb1_c1_exe1_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_10to169_bb1_c1_exe1_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_10to169_bb1_c1_exe1_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_c1_exe1),
	.data_out(rnode_10to169_bb1_c1_exe1_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_10to169_bb1_c1_exe1_0_reg_169_fifo.DEPTH = 160;
defparam rnode_10to169_bb1_c1_exe1_0_reg_169_fifo.DATA_WIDTH = 11;
defparam rnode_10to169_bb1_c1_exe1_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to169_bb1_c1_exe1_0_reg_169_fifo.IMPL = "ram";

assign rnode_10to169_bb1_c1_exe1_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_c1_exe1_valid_out;
assign local_bb1_c1_exe1_stall_in = rnode_10to169_bb1_c1_exe1_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe1_0_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe1_0_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe1_0_stall_in_reg_169_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe1_0_valid_out_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_10to169_bb1_c1_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_10to169_bb1_c1_exe2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to169_bb1_c1_exe2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to169_bb1_c1_exe2_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_10to169_bb1_c1_exe2_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_10to169_bb1_c1_exe2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_c1_exe2),
	.data_out(rnode_10to169_bb1_c1_exe2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_10to169_bb1_c1_exe2_0_reg_169_fifo.DEPTH = 160;
defparam rnode_10to169_bb1_c1_exe2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_10to169_bb1_c1_exe2_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to169_bb1_c1_exe2_0_reg_169_fifo.IMPL = "ram";

assign rnode_10to169_bb1_c1_exe2_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_c1_exe2_valid_out;
assign local_bb1_c1_exe2_stall_in = rnode_10to169_bb1_c1_exe2_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe2_0_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe2_0_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe2_0_stall_in_reg_169_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe2_0_valid_out_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe2_0_valid_out_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_10to169_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_10to169_bb1_c1_exe3_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_10to169_bb1_c1_exe3_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to169_bb1_c1_exe3_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to169_bb1_c1_exe3_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_10to169_bb1_c1_exe3_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_10to169_bb1_c1_exe3_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_c1_exe3),
	.data_out(rnode_10to169_bb1_c1_exe3_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_10to169_bb1_c1_exe3_0_reg_169_fifo.DEPTH = 160;
defparam rnode_10to169_bb1_c1_exe3_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_10to169_bb1_c1_exe3_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to169_bb1_c1_exe3_0_reg_169_fifo.IMPL = "ram";

assign rnode_10to169_bb1_c1_exe3_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_c1_exe3_valid_out;
assign local_bb1_c1_exe3_stall_in = rnode_10to169_bb1_c1_exe3_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe3_0_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe3_0_reg_169_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe3_0_stall_in_reg_169_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe3_0_valid_out_reg_169_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_10to10_bb1_c1_exe5_valid_out_0;
wire rstag_10to10_bb1_c1_exe5_stall_in_0;
 reg rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG;
wire rstag_10to10_bb1_c1_exe5_valid_out_1;
wire rstag_10to10_bb1_c1_exe5_stall_in_1;
 reg rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG;
wire rstag_10to10_bb1_c1_exe5_inputs_ready;
wire rstag_10to10_bb1_c1_exe5_stall_local;
 reg rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG;
wire rstag_10to10_bb1_c1_exe5_combined_valid;
 reg rstag_10to10_bb1_c1_exe5_staging_reg_NO_SHIFT_REG;
wire rstag_10to10_bb1_c1_exe5;

assign rstag_10to10_bb1_c1_exe5_inputs_ready = local_bb1_c1_exe5_valid_out;
assign rstag_10to10_bb1_c1_exe5 = (rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG ? rstag_10to10_bb1_c1_exe5_staging_reg_NO_SHIFT_REG : local_bb1_c1_exe5);
assign rstag_10to10_bb1_c1_exe5_combined_valid = (rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG | rstag_10to10_bb1_c1_exe5_inputs_ready);
assign rstag_10to10_bb1_c1_exe5_stall_local = ((rstag_10to10_bb1_c1_exe5_stall_in_0 & ~(rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG)) | (rstag_10to10_bb1_c1_exe5_stall_in_1 & ~(rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG)));
assign rstag_10to10_bb1_c1_exe5_valid_out_0 = (rstag_10to10_bb1_c1_exe5_combined_valid & ~(rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG));
assign rstag_10to10_bb1_c1_exe5_valid_out_1 = (rstag_10to10_bb1_c1_exe5_combined_valid & ~(rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG));
assign local_bb1_c1_exe5_stall_in = (|rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_10to10_bb1_c1_exe5_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_10to10_bb1_c1_exe5_stall_local)
		begin
			if (~(rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG))
			begin
				rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG <= rstag_10to10_bb1_c1_exe5_inputs_ready;
			end
		end
		else
		begin
			rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_10to10_bb1_c1_exe5_staging_valid_NO_SHIFT_REG))
		begin
			rstag_10to10_bb1_c1_exe5_staging_reg_NO_SHIFT_REG <= local_bb1_c1_exe5;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG <= (rstag_10to10_bb1_c1_exe5_combined_valid & (rstag_10to10_bb1_c1_exe5_consumed_0_NO_SHIFT_REG | ~(rstag_10to10_bb1_c1_exe5_stall_in_0)) & rstag_10to10_bb1_c1_exe5_stall_local);
		rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG <= (rstag_10to10_bb1_c1_exe5_combined_valid & (rstag_10to10_bb1_c1_exe5_consumed_1_NO_SHIFT_REG | ~(rstag_10to10_bb1_c1_exe5_stall_in_1)) & rstag_10to10_bb1_c1_exe5_stall_local);
	end
end


// Register node:
//  * latency = 174
//  * capacity = 174
 logic rnode_10to184_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_10to184_bb1_c1_exe6_0_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe6_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_10to184_bb1_c1_exe6_0_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe6_0_valid_out_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe6_0_stall_in_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe6_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_10to184_bb1_c1_exe6_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to184_bb1_c1_exe6_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to184_bb1_c1_exe6_0_stall_in_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_10to184_bb1_c1_exe6_0_valid_out_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_10to184_bb1_c1_exe6_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(local_bb1_c1_exe6),
	.data_out(rnode_10to184_bb1_c1_exe6_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_10to184_bb1_c1_exe6_0_reg_184_fifo.DEPTH = 175;
defparam rnode_10to184_bb1_c1_exe6_0_reg_184_fifo.DATA_WIDTH = 64;
defparam rnode_10to184_bb1_c1_exe6_0_reg_184_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to184_bb1_c1_exe6_0_reg_184_fifo.IMPL = "ram";

assign rnode_10to184_bb1_c1_exe6_0_reg_184_inputs_ready_NO_SHIFT_REG = local_bb1_c1_exe6_valid_out;
assign local_bb1_c1_exe6_stall_in = rnode_10to184_bb1_c1_exe6_0_stall_out_reg_184_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe6_0_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe6_0_reg_184_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe6_0_stall_in_reg_184_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe6_0_valid_out_reg_184_NO_SHIFT_REG;

// Register node:
//  * latency = 178
//  * capacity = 178
 logic rnode_10to188_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_reg_188_inputs_ready_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_reg_188_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_valid_out_reg_188_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_stall_in_reg_188_NO_SHIFT_REG;
 logic rnode_10to188_bb1_c1_exe7_0_stall_out_reg_188_NO_SHIFT_REG;

acl_data_fifo rnode_10to188_bb1_c1_exe7_0_reg_188_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to188_bb1_c1_exe7_0_reg_188_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to188_bb1_c1_exe7_0_stall_in_reg_188_NO_SHIFT_REG),
	.valid_out(rnode_10to188_bb1_c1_exe7_0_valid_out_reg_188_NO_SHIFT_REG),
	.stall_out(rnode_10to188_bb1_c1_exe7_0_stall_out_reg_188_NO_SHIFT_REG),
	.data_in(local_bb1_c1_exe7),
	.data_out(rnode_10to188_bb1_c1_exe7_0_reg_188_NO_SHIFT_REG)
);

defparam rnode_10to188_bb1_c1_exe7_0_reg_188_fifo.DEPTH = 179;
defparam rnode_10to188_bb1_c1_exe7_0_reg_188_fifo.DATA_WIDTH = 1;
defparam rnode_10to188_bb1_c1_exe7_0_reg_188_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to188_bb1_c1_exe7_0_reg_188_fifo.IMPL = "ram";

assign rnode_10to188_bb1_c1_exe7_0_reg_188_inputs_ready_NO_SHIFT_REG = local_bb1_c1_exe7_valid_out;
assign local_bb1_c1_exe7_stall_in = rnode_10to188_bb1_c1_exe7_0_stall_out_reg_188_NO_SHIFT_REG;
assign rnode_10to188_bb1_c1_exe7_0_NO_SHIFT_REG = rnode_10to188_bb1_c1_exe7_0_reg_188_NO_SHIFT_REG;
assign rnode_10to188_bb1_c1_exe7_0_stall_in_reg_188_NO_SHIFT_REG = rnode_10to188_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_10to188_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG = rnode_10to188_bb1_c1_exe7_0_valid_out_reg_188_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_169to170_bb1_c1_exe1_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe1_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_169to170_bb1_c1_exe1_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe1_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe1_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe1_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_c1_exe1_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_c1_exe1_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_c1_exe1_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_c1_exe1_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c1_exe1_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_10to169_bb1_c1_exe1_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c1_exe1_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_c1_exe1_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_c1_exe1_0_reg_170_fifo.DATA_WIDTH = 11;
defparam rnode_169to170_bb1_c1_exe1_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_c1_exe1_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_c1_exe1_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe1_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe1_0_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe1_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe1_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe1_0_valid_out_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_c1_exe2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_stall_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_169to170_bb1_c1_exe2_0_reg_170_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG),
	.valid_in(rnode_169to170_bb1_c1_exe2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c1_exe2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG_fa),
	.valid_out({rnode_169to170_bb1_c1_exe2_0_valid_out_0_NO_SHIFT_REG, rnode_169to170_bb1_c1_exe2_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_169to170_bb1_c1_exe2_0_stall_in_0_NO_SHIFT_REG, rnode_169to170_bb1_c1_exe2_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_169to170_bb1_c1_exe2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_c1_exe2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_c1_exe2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_c1_exe2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c1_exe2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_10to169_bb1_c1_exe2_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_c1_exe2_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_c1_exe2_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe2_0_valid_out_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe2_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe2_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe2_0_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG_fa;
assign rnode_169to170_bb1_c1_exe2_1_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe2_0_reg_170_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c1_exe3_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_c1_exe3_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_c1_exe3_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_c1_exe3_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_c1_exe3_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c1_exe3_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_10to169_bb1_c1_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c1_exe3_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_c1_exe3_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_c1_exe3_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_c1_exe3_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_c1_exe3_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_c1_exe3_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_10to169_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_10to169_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe3_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe3_0_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe3_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe3_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_c1_exe3_0_valid_out_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 174
//  * capacity = 174
 logic rnode_10to184_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_valid_out_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_stall_in_reg_184_NO_SHIFT_REG;
 logic rnode_10to184_bb1_c1_exe5_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_10to184_bb1_c1_exe5_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_10to184_bb1_c1_exe5_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_10to184_bb1_c1_exe5_0_stall_in_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_10to184_bb1_c1_exe5_0_valid_out_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_10to184_bb1_c1_exe5_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(rstag_10to10_bb1_c1_exe5),
	.data_out(rnode_10to184_bb1_c1_exe5_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_10to184_bb1_c1_exe5_0_reg_184_fifo.DEPTH = 175;
defparam rnode_10to184_bb1_c1_exe5_0_reg_184_fifo.DATA_WIDTH = 1;
defparam rnode_10to184_bb1_c1_exe5_0_reg_184_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_10to184_bb1_c1_exe5_0_reg_184_fifo.IMPL = "ram";

assign rnode_10to184_bb1_c1_exe5_0_reg_184_inputs_ready_NO_SHIFT_REG = rstag_10to10_bb1_c1_exe5_valid_out_0;
assign rstag_10to10_bb1_c1_exe5_stall_in_0 = rnode_10to184_bb1_c1_exe5_0_stall_out_reg_184_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe5_0_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe5_0_reg_184_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe5_0_stall_in_reg_184_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe5_0_valid_out_reg_184_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld__inputs_ready;
 reg local_bb1_ld__valid_out_NO_SHIFT_REG;
wire local_bb1_ld__stall_in;
wire local_bb1_ld__output_regs_ready;
wire local_bb1_ld__fu_stall_out;
wire local_bb1_ld__fu_valid_out;
wire [31:0] local_bb1_ld__lsu_dataout;
 reg [31:0] local_bb1_ld__NO_SHIFT_REG;
wire local_bb1_ld__causedstall;

lsu_top lsu_local_bb1_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld__fu_stall_out),
	.i_valid(local_bb1_ld__inputs_ready),
	.i_address(local_bb1_c1_exe4),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_10to10_bb1_c1_exe5),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld__output_regs_ready)),
	.o_valid(local_bb1_ld__fu_valid_out),
	.o_readdata(local_bb1_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld__active),
	.avm_address(avm_local_bb1_ld__address),
	.avm_read(avm_local_bb1_ld__read),
	.avm_readdata(avm_local_bb1_ld__readdata),
	.avm_write(avm_local_bb1_ld__write),
	.avm_writeack(avm_local_bb1_ld__writeack),
	.avm_burstcount(avm_local_bb1_ld__burstcount),
	.avm_writedata(avm_local_bb1_ld__writedata),
	.avm_byteenable(avm_local_bb1_ld__byteenable),
	.avm_waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_ld_.AWIDTH = 30;
defparam lsu_local_bb1_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb1_ld_.READ = 1;
defparam lsu_local_bb1_ld_.ATOMIC = 0;
defparam lsu_local_bb1_ld_.WIDTH = 32;
defparam lsu_local_bb1_ld_.MWIDTH = 256;
defparam lsu_local_bb1_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_.MEMORY_SIDE_MEM_LATENCY = 73;
defparam lsu_local_bb1_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_.USECACHING = 0;
defparam lsu_local_bb1_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_.STYLE = "BURST-COALESCED";

assign local_bb1_ld__inputs_ready = (local_bb1_c1_exe4_valid_out & rstag_10to10_bb1_c1_exe5_valid_out_1);
assign local_bb1_ld__output_regs_ready = (&(~(local_bb1_ld__valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__stall_in)));
assign local_bb1_c1_exe4_stall_in = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign rstag_10to10_bb1_c1_exe5_stall_in_1 = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign local_bb1_ld__causedstall = (local_bb1_ld__inputs_ready && (local_bb1_ld__fu_stall_out && !(~(local_bb1_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld__NO_SHIFT_REG <= 'x;
		local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld__output_regs_ready)
		begin
			local_bb1_ld__NO_SHIFT_REG <= local_bb1_ld__lsu_dataout;
			local_bb1_ld__valid_out_NO_SHIFT_REG <= local_bb1_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld__stall_in))
			begin
				local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_184to185_bb1_c1_exe6_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe6_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_184to185_bb1_c1_exe6_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe6_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe6_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe6_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_c1_exe6_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_c1_exe6_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_c1_exe6_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_c1_exe6_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_c1_exe6_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_10to184_bb1_c1_exe6_0_NO_SHIFT_REG),
	.data_out(rnode_184to185_bb1_c1_exe6_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_c1_exe6_0_reg_185_fifo.DEPTH = 2;
defparam rnode_184to185_bb1_c1_exe6_0_reg_185_fifo.DATA_WIDTH = 64;
defparam rnode_184to185_bb1_c1_exe6_0_reg_185_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_184to185_bb1_c1_exe6_0_reg_185_fifo.IMPL = "ll_reg";

assign rnode_184to185_bb1_c1_exe6_0_reg_185_inputs_ready_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe6_0_stall_out_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe6_0_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe6_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe6_0_stall_in_reg_185_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe6_0_valid_out_reg_185_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_188to189_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_reg_189_inputs_ready_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_reg_189_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_valid_out_reg_189_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_stall_in_reg_189_NO_SHIFT_REG;
 logic rnode_188to189_bb1_c1_exe7_0_stall_out_reg_189_NO_SHIFT_REG;

acl_data_fifo rnode_188to189_bb1_c1_exe7_0_reg_189_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_188to189_bb1_c1_exe7_0_reg_189_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_188to189_bb1_c1_exe7_0_stall_in_reg_189_NO_SHIFT_REG),
	.valid_out(rnode_188to189_bb1_c1_exe7_0_valid_out_reg_189_NO_SHIFT_REG),
	.stall_out(rnode_188to189_bb1_c1_exe7_0_stall_out_reg_189_NO_SHIFT_REG),
	.data_in(rnode_10to188_bb1_c1_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_188to189_bb1_c1_exe7_0_reg_189_NO_SHIFT_REG)
);

defparam rnode_188to189_bb1_c1_exe7_0_reg_189_fifo.DEPTH = 2;
defparam rnode_188to189_bb1_c1_exe7_0_reg_189_fifo.DATA_WIDTH = 1;
defparam rnode_188to189_bb1_c1_exe7_0_reg_189_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_188to189_bb1_c1_exe7_0_reg_189_fifo.IMPL = "ll_reg";

assign rnode_188to189_bb1_c1_exe7_0_reg_189_inputs_ready_NO_SHIFT_REG = rnode_10to188_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_10to188_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG = rnode_188to189_bb1_c1_exe7_0_stall_out_reg_189_NO_SHIFT_REG;
assign rnode_188to189_bb1_c1_exe7_0_NO_SHIFT_REG = rnode_188to189_bb1_c1_exe7_0_reg_189_NO_SHIFT_REG;
assign rnode_188to189_bb1_c1_exe7_0_stall_in_reg_189_NO_SHIFT_REG = rnode_188to189_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_188to189_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG = rnode_188to189_bb1_c1_exe7_0_valid_out_reg_189_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni2_stall_local;
wire [95:0] local_bb1_c0_eni2;

assign local_bb1_c0_eni2[15:0] = local_bb1_c0_eni1[15:0];
assign local_bb1_c0_eni2[26:16] = rnode_169to170_bb1_c1_exe1_0_NO_SHIFT_REG;
assign local_bb1_c0_eni2[95:27] = local_bb1_c0_eni1[95:27];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_c1_exe5_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_c1_exe5_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_c1_exe5_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_c1_exe5_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_c1_exe5_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_c1_exe5_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_10to184_bb1_c1_exe5_0_NO_SHIFT_REG),
	.data_out(rnode_184to185_bb1_c1_exe5_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_c1_exe5_0_reg_185_fifo.DEPTH = 2;
defparam rnode_184to185_bb1_c1_exe5_0_reg_185_fifo.DATA_WIDTH = 1;
defparam rnode_184to185_bb1_c1_exe5_0_reg_185_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_184to185_bb1_c1_exe5_0_reg_185_fifo.IMPL = "ll_reg";

assign rnode_184to185_bb1_c1_exe5_0_reg_185_inputs_ready_NO_SHIFT_REG = rnode_10to184_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG;
assign rnode_10to184_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe5_0_stall_out_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe5_0_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe5_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe5_0_stall_in_reg_185_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG;
assign rnode_184to185_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG = rnode_184to185_bb1_c1_exe5_0_valid_out_reg_185_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_170to170_bb1_ld__valid_out;
wire rstag_170to170_bb1_ld__stall_in;
wire rstag_170to170_bb1_ld__inputs_ready;
wire rstag_170to170_bb1_ld__stall_local;
 reg rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG;
wire rstag_170to170_bb1_ld__combined_valid;
 reg [31:0] rstag_170to170_bb1_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_170to170_bb1_ld_;

assign rstag_170to170_bb1_ld__inputs_ready = local_bb1_ld__valid_out_NO_SHIFT_REG;
assign rstag_170to170_bb1_ld_ = (rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG ? rstag_170to170_bb1_ld__staging_reg_NO_SHIFT_REG : local_bb1_ld__NO_SHIFT_REG);
assign rstag_170to170_bb1_ld__combined_valid = (rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG | rstag_170to170_bb1_ld__inputs_ready);
assign rstag_170to170_bb1_ld__valid_out = rstag_170to170_bb1_ld__combined_valid;
assign rstag_170to170_bb1_ld__stall_local = rstag_170to170_bb1_ld__stall_in;
assign local_bb1_ld__stall_in = (|rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_170to170_bb1_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_170to170_bb1_ld__stall_local)
		begin
			if (~(rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG <= rstag_170to170_bb1_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_170to170_bb1_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_170to170_bb1_ld__staging_reg_NO_SHIFT_REG <= local_bb1_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni3_stall_local;
wire [95:0] local_bb1_c0_eni3;

assign local_bb1_c0_eni3[31:0] = local_bb1_c0_eni2[31:0];
assign local_bb1_c0_eni3[32] = rnode_169to170_bb1_c1_exe2_0_NO_SHIFT_REG;
assign local_bb1_c0_eni3[95:33] = local_bb1_c0_eni2[95:33];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni4_stall_local;
wire [95:0] local_bb1_c0_eni4;

assign local_bb1_c0_eni4[39:0] = local_bb1_c0_eni3[39:0];
assign local_bb1_c0_eni4[40] = rnode_169to170_bb1_c1_exe3_0_NO_SHIFT_REG;
assign local_bb1_c0_eni4[95:41] = local_bb1_c0_eni3[95:41];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni5_valid_out;
wire local_bb1_c0_eni5_stall_in;
wire local_bb1_c0_eni5_inputs_ready;
wire local_bb1_c0_eni5_stall_local;
wire [95:0] local_bb1_c0_eni5;

assign local_bb1_c0_eni5_inputs_ready = (rnode_169to170_forked_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_c1_exe1_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_c1_exe2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_c1_exe3_0_valid_out_NO_SHIFT_REG & rstag_170to170_bb1_ld__valid_out);
assign local_bb1_c0_eni5[63:0] = local_bb1_c0_eni4[63:0];
assign local_bb1_c0_eni5[95:64] = rstag_170to170_bb1_ld_;
assign local_bb1_c0_eni5_valid_out = local_bb1_c0_eni5_inputs_ready;
assign local_bb1_c0_eni5_stall_local = local_bb1_c0_eni5_stall_in;
assign rnode_169to170_forked_0_stall_in_0_NO_SHIFT_REG = (local_bb1_c0_eni5_stall_local | ~(local_bb1_c0_eni5_inputs_ready));
assign rnode_169to170_bb1_c1_exe1_0_stall_in_NO_SHIFT_REG = (local_bb1_c0_eni5_stall_local | ~(local_bb1_c0_eni5_inputs_ready));
assign rnode_169to170_bb1_c1_exe2_0_stall_in_0_NO_SHIFT_REG = (local_bb1_c0_eni5_stall_local | ~(local_bb1_c0_eni5_inputs_ready));
assign rnode_169to170_bb1_c1_exe3_0_stall_in_NO_SHIFT_REG = (local_bb1_c0_eni5_stall_local | ~(local_bb1_c0_eni5_inputs_ready));
assign rstag_170to170_bb1_ld__stall_in = (local_bb1_c0_eni5_stall_local | ~(local_bb1_c0_eni5_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni5_inputs_ready;
 reg local_bb1_c0_enter_c0_eni5_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_stall_in_0;
 reg local_bb1_c0_enter_c0_eni5_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_stall_in_1;
 reg local_bb1_c0_enter_c0_eni5_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_stall_in_2;
 reg local_bb1_c0_enter_c0_eni5_valid_out_3_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_stall_in_3;
 reg local_bb1_c0_enter_c0_eni5_valid_out_4_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_stall_in_4;
wire local_bb1_c0_enter_c0_eni5_output_regs_ready;
 reg [95:0] local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni5_input_accepted;
wire local_bb1_c0_exit_c0_exi1_entry_stall;
wire local_bb1_c0_exit_c0_exi1_output_regs_ready;
wire [10:0] local_bb1_c0_exit_c0_exi1_valid_bits;
wire local_bb1_c0_exit_c0_exi1_phases;
wire local_bb1_c0_enter_c0_eni5_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni5_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni5_causedstall;

assign local_bb1_c0_enter_c0_eni5_inputs_ready = (local_bb1_c0_eni5_valid_out & rnode_169to170_forked_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_c1_exe2_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_c0_enter_c0_eni5_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni5_input_accepted = (local_bb1_c0_enter_c0_eni5_inputs_ready && !(local_bb1_c0_exit_c0_exi1_entry_stall));
assign local_bb1_c0_enter_c0_eni5_inc_pipelined_thread = rnode_169to170_forked_1_NO_SHIFT_REG;
assign local_bb1_c0_enter_c0_eni5_dec_pipelined_thread = ~(rnode_169to170_bb1_c1_exe2_1_NO_SHIFT_REG);
assign local_bb1_c0_eni5_stall_in = ((~(local_bb1_c0_enter_c0_eni5_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign rnode_169to170_forked_0_stall_in_1_NO_SHIFT_REG = ((~(local_bb1_c0_enter_c0_eni5_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign rnode_169to170_bb1_c1_exe2_0_stall_in_1_NO_SHIFT_REG = ((~(local_bb1_c0_enter_c0_eni5_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni5_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni5_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni5_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni5_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni5_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni5_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni5_valid_out_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni5_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG <= local_bb1_c0_eni5;
			local_bb1_c0_enter_c0_eni5_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni5_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni5_valid_out_2_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni5_valid_out_3_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni5_valid_out_4_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni5_stall_in_0))
			begin
				local_bb1_c0_enter_c0_eni5_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni5_stall_in_1))
			begin
				local_bb1_c0_enter_c0_eni5_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni5_stall_in_2))
			begin
				local_bb1_c0_enter_c0_eni5_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni5_stall_in_3))
			begin
				local_bb1_c0_enter_c0_eni5_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni5_stall_in_4))
			begin
				local_bb1_c0_enter_c0_eni5_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_stall_local;
wire local_bb1_c0_ene1;

assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG[8];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene2_stall_local;
wire [10:0] local_bb1_c0_ene2;

assign local_bb1_c0_ene2 = local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG[26:16];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene3_valid_out_0;
wire local_bb1_c0_ene3_stall_in_0;
 reg local_bb1_c0_ene3_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_ene3_valid_out_1;
wire local_bb1_c0_ene3_stall_in_1;
 reg local_bb1_c0_ene3_consumed_1_NO_SHIFT_REG;
wire local_bb1_c0_ene3_valid_out_2;
wire local_bb1_c0_ene3_stall_in_2;
 reg local_bb1_c0_ene3_consumed_2_NO_SHIFT_REG;
wire local_bb1_c0_ene3_inputs_ready;
wire local_bb1_c0_ene3_stall_local;
wire local_bb1_c0_ene3;

assign local_bb1_c0_ene3_inputs_ready = local_bb1_c0_enter_c0_eni5_valid_out_2_NO_SHIFT_REG;
assign local_bb1_c0_ene3 = local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG[32];
assign local_bb1_c0_ene3_valid_out_0 = 1'b1;
assign local_bb1_c0_ene3_valid_out_1 = 1'b1;
assign local_bb1_c0_ene3_valid_out_2 = 1'b1;
assign local_bb1_c0_enter_c0_eni5_stall_in_2 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_ene3_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene3_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene3_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_c0_ene3_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_ene3_inputs_ready & (local_bb1_c0_ene3_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_ene3_stall_in_0)) & local_bb1_c0_ene3_stall_local);
		local_bb1_c0_ene3_consumed_1_NO_SHIFT_REG <= (local_bb1_c0_ene3_inputs_ready & (local_bb1_c0_ene3_consumed_1_NO_SHIFT_REG | ~(local_bb1_c0_ene3_stall_in_1)) & local_bb1_c0_ene3_stall_local);
		local_bb1_c0_ene3_consumed_2_NO_SHIFT_REG <= (local_bb1_c0_ene3_inputs_ready & (local_bb1_c0_ene3_consumed_2_NO_SHIFT_REG | ~(local_bb1_c0_ene3_stall_in_2)) & local_bb1_c0_ene3_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene4_stall_local;
wire local_bb1_c0_ene4;

assign local_bb1_c0_ene4 = local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG[40];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene5_stall_local;
wire [31:0] local_bb1_c0_ene5;

assign local_bb1_c0_ene5 = local_bb1_c0_enter_c0_eni5_NO_SHIFT_REG[95:64];

// This section implements an unregistered operation.
// 
wire local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_rows_1_0_pop6_acl_pop_i32_0;
wire local_bb1_rows_1_0_pop6_acl_pop_i32_0_fu_valid_out;
wire local_bb1_rows_1_0_pop6_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_rows_1_0_pop6_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_rows_1_0_pop6_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_1_0_pop6_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_rows_1_0_pop6_acl_pop_i32_0),
	.feedback_in(feedback_data_in_6),
	.feedback_valid_in(feedback_valid_in_6),
	.feedback_stall_out(feedback_stall_out_6)
);

defparam local_bb1_rows_1_0_pop6_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_rows_1_0_pop6_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_1_0_pop6_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_rows_0_0_pop7_acl_pop_i32_0;
wire local_bb1_rows_0_0_pop7_acl_pop_i32_0_fu_valid_out;
wire local_bb1_rows_0_0_pop7_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_rows_0_0_pop7_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_rows_0_0_pop7_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_0_0_pop7_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_rows_0_0_pop7_acl_pop_i32_0),
	.feedback_in(feedback_data_in_7),
	.feedback_valid_in(feedback_valid_in_7),
	.feedback_stall_out(feedback_stall_out_7)
);

defparam local_bb1_rows_0_0_pop7_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_rows_0_0_pop7_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_0_0_pop7_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_not_select1494_stall_local;
wire local_bb1_not_select1494;

assign local_bb1_not_select1494 = ($signed(local_bb1_c0_ene2) > $signed(11'h7FF));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene3_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_c0_ene3_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_c0_ene3_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_c0_ene3_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_c0_ene3_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_c0_ene3_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene3),
	.data_out(rnode_171to172_bb1_c0_ene3_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_c0_ene3_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_c0_ene3_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb1_c0_ene3_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_c0_ene3_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_c0_ene3_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene3_stall_in_2 = 1'b0;
assign rnode_171to172_bb1_c0_ene3_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene3_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene3_1_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene3_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_c0_ene3_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene3_2_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene3_0_reg_172_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1___stall_local;
wire [31:0] local_bb1__;

assign local_bb1__ = (local_bb1_c0_ene4 ? local_bb1_c0_ene5 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_2_stall_local;
wire [31:0] local_bb1_shr17_2;

assign local_bb1_shr17_2 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_2_stall_local;
wire [31:0] local_bb1_shr19_2;

assign local_bb1_shr19_2 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u3_stall_local;
wire [31:0] local_bb1_var__u3;

assign local_bb1_var__u3 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u4_stall_local;
wire [31:0] local_bb1_var__u4;

assign local_bb1_var__u4 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u5_stall_local;
wire [31:0] local_bb1_var__u5;

assign local_bb1_var__u5 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u6_stall_local;
wire [31:0] local_bb1_var__u6;

assign local_bb1_var__u6 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u7_stall_local;
wire [31:0] local_bb1_var__u7;

assign local_bb1_var__u7 = (local_bb1_rows_1_0_pop6_acl_pop_i32_0 >> 32'h14);

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_1_stall_local;
wire [31:0] local_bb1_shr17_1;

assign local_bb1_shr17_1 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_1_stall_local;
wire [31:0] local_bb1_shr19_1;

assign local_bb1_shr19_1 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u8_stall_local;
wire [31:0] local_bb1_var__u8;

assign local_bb1_var__u8 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u9_stall_local;
wire [31:0] local_bb1_var__u9;

assign local_bb1_var__u9 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u10_stall_local;
wire [31:0] local_bb1_var__u10;

assign local_bb1_var__u10 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u11_stall_local;
wire [31:0] local_bb1_var__u11;

assign local_bb1_var__u11 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u12_stall_local;
wire [31:0] local_bb1_var__u12;

assign local_bb1_var__u12 = (local_bb1_rows_0_0_pop7_acl_pop_i32_0 >> 32'h14);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0;
wire local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_fu_valid_out;
wire local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_not_select1494),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0),
	.feedback_in(feedback_data_in_3),
	.feedback_valid_in(feedback_valid_in_3),
	.feedback_stall_out(feedback_stall_out_3)
);

defparam local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 968;
defparam local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_feedback.STYLE = "COALESCE";

assign local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene3_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_c0_ene3_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_c0_ene3_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_c0_ene3_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_c0_ene3_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_c0_ene3_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb1_c0_ene3_2_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_c0_ene3_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_c0_ene3_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_c0_ene3_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_c0_ene3_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_c0_ene3_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_c0_ene3_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene3_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_c0_ene3_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_172to173_bb1_c0_ene3_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_c0_ene3_1_NO_SHIFT_REG = rnode_172to173_bb1_c0_ene3_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_stall_local;
wire [31:0] local_bb1_shr17;

assign local_bb1_shr17 = (local_bb1__ >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_stall_local;
wire [31:0] local_bb1_shr19;

assign local_bb1_shr19 = (local_bb1__ >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u13_stall_local;
wire [31:0] local_bb1_var__u13;

assign local_bb1_var__u13 = (local_bb1__ >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u14_stall_local;
wire [31:0] local_bb1_var__u14;

assign local_bb1_var__u14 = (local_bb1__ >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u15_stall_local;
wire [31:0] local_bb1_var__u15;

assign local_bb1_var__u15 = (local_bb1__ >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u16_stall_local;
wire [31:0] local_bb1_var__u16;

assign local_bb1_var__u16 = (local_bb1__ >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u17_stall_local;
wire [31:0] local_bb1_var__u17;

assign local_bb1_var__u17 = (local_bb1__ >> 32'h14);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_masked_stall_local;
wire [31:0] local_bb1_mul22_2_masked;

assign local_bb1_mul22_2_masked = (local_bb1_shr17_2 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u18_stall_local;
wire [31:0] local_bb1_var__u18;

assign local_bb1_var__u18 = (local_bb1_var__u3 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u19_stall_local;
wire [31:0] local_bb1_var__u19;

assign local_bb1_var__u19 = (local_bb1_var__u4 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u20_stall_local;
wire [31:0] local_bb1_var__u20;

assign local_bb1_var__u20 = (local_bb1_var__u5 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u21_stall_local;
wire [31:0] local_bb1_var__u21;

assign local_bb1_var__u21 = (local_bb1_var__u6 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u22_stall_local;
wire [31:0] local_bb1_var__u22;

assign local_bb1_var__u22 = (local_bb1_var__u7 & 32'hFF0);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_1_masked_stall_local;
wire [31:0] local_bb1_mul22_1_masked;

assign local_bb1_mul22_1_masked = (local_bb1_shr17_1 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u23_stall_local;
wire [31:0] local_bb1_var__u23;

assign local_bb1_var__u23 = (local_bb1_var__u8 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u24_stall_local;
wire [31:0] local_bb1_var__u24;

assign local_bb1_var__u24 = (local_bb1_var__u9 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u25_stall_local;
wire [31:0] local_bb1_var__u25;

assign local_bb1_var__u25 = (local_bb1_var__u10 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u26_stall_local;
wire [31:0] local_bb1_var__u26;

assign local_bb1_var__u26 = (local_bb1_var__u11 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u27_stall_local;
wire [31:0] local_bb1_var__u27;

assign local_bb1_var__u27 = (local_bb1_var__u12 & 32'hFF0);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_131_stall_local;
wire [31:0] local_bb1_shr19_131;

assign local_bb1_shr19_131 = (local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u28_stall_local;
wire [31:0] local_bb1_var__u28;

assign local_bb1_var__u28 = (local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_masked_stall_local;
wire [31:0] local_bb1_mul22_masked;

assign local_bb1_mul22_masked = (local_bb1_shr17 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u29_stall_local;
wire [31:0] local_bb1_var__u29;

assign local_bb1_var__u29 = (local_bb1_var__u13 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u30_stall_local;
wire [31:0] local_bb1_var__u30;

assign local_bb1_var__u30 = (local_bb1_var__u14 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u31_stall_local;
wire [31:0] local_bb1_var__u31;

assign local_bb1_var__u31 = (local_bb1_var__u15 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u32_stall_local;
wire [31:0] local_bb1_var__u32;

assign local_bb1_var__u32 = (local_bb1_var__u16 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u33_stall_local;
wire [31:0] local_bb1_var__u33;

assign local_bb1_var__u33 = (local_bb1_var__u17 & 32'hFF0);

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_2_add310_stall_local;
wire [31:0] local_bb1_mul21_2_add310;

assign local_bb1_mul21_2_add310 = (local_bb1_var__u18 + local_bb1_var__u19);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_add372_stall_local;
wire [31:0] local_bb1_mul22_2_add372;

assign local_bb1_mul22_2_add372 = (local_bb1_mul22_2_masked + local_bb1_var__u20);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_add1122_stall_local;
wire [31:0] local_bb1_mul24_2_add1122;

assign local_bb1_mul24_2_add1122 = (local_bb1_shr19_2 + local_bb1_var__u21);

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_1_add186_stall_local;
wire [31:0] local_bb1_mul21_1_add186;

assign local_bb1_mul21_1_add186 = (local_bb1_var__u23 + local_bb1_var__u24);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_1_add248_stall_local;
wire [31:0] local_bb1_mul22_1_add248;

assign local_bb1_mul22_1_add248 = (local_bb1_mul22_1_masked + local_bb1_var__u25);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_1_add1060_stall_local;
wire [31:0] local_bb1_mul24_1_add1060;

assign local_bb1_mul24_1_add1060 = (local_bb1_shr19_1 + local_bb1_var__u26);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u34_stall_local;
wire [31:0] local_bb1_var__u34;

assign local_bb1_var__u34 = (local_bb1_var__u28 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_add62_stall_local;
wire [31:0] local_bb1_mul21_add62;

assign local_bb1_mul21_add62 = (local_bb1_var__u29 + local_bb1_var__u30);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_add124_stall_local;
wire [31:0] local_bb1_mul22_add124;

assign local_bb1_mul22_add124 = (local_bb1_mul22_masked + local_bb1_var__u31);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_add998_stall_local;
wire [31:0] local_bb1_mul24_add998;

assign local_bb1_mul24_add998 = (local_bb1_shr19 + local_bb1_var__u32);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_add1178_stall_local;
wire [31:0] local_bb1_mul24_2_add1178;

assign local_bb1_mul24_2_add1178 = (local_bb1_mul24_2_add1122 + local_bb1_var__u22);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_1_add1116_stall_local;
wire [31:0] local_bb1_mul24_1_add1116;

assign local_bb1_mul24_1_add1116 = (local_bb1_mul24_1_add1060 + local_bb1_var__u27);

// This section implements an unregistered operation.
// 
wire local_bb1_not_select1494_valid_out_1;
wire local_bb1_not_select1494_stall_in_1;
 reg local_bb1_not_select1494_consumed_1_NO_SHIFT_REG;
wire local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_valid_out_2;
wire local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_in_2;
 reg local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_consumed_2_NO_SHIFT_REG;
wire local_bb1_mul24_134_add1184_valid_out;
wire local_bb1_mul24_134_add1184_stall_in;
 reg local_bb1_mul24_134_add1184_consumed_0_NO_SHIFT_REG;
wire local_bb1_mul24_134_add1184_inputs_ready;
wire local_bb1_mul24_134_add1184_stall_local;
wire [31:0] local_bb1_mul24_134_add1184;

assign local_bb1_mul24_134_add1184_inputs_ready = local_bb1_c0_enter_c0_eni5_valid_out_1_NO_SHIFT_REG;
assign local_bb1_mul24_134_add1184 = (local_bb1_shr19_131 + local_bb1_var__u34);
assign local_bb1_not_select1494_valid_out_1 = 1'b1;
assign local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_valid_out_2 = 1'b1;
assign local_bb1_mul24_134_add1184_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni5_stall_in_1 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_not_select1494_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul24_134_add1184_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_not_select1494_consumed_1_NO_SHIFT_REG <= (local_bb1_mul24_134_add1184_inputs_ready & (local_bb1_not_select1494_consumed_1_NO_SHIFT_REG | ~(local_bb1_not_select1494_stall_in_1)) & local_bb1_mul24_134_add1184_stall_local);
		local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_consumed_2_NO_SHIFT_REG <= (local_bb1_mul24_134_add1184_inputs_ready & (local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_consumed_2_NO_SHIFT_REG | ~(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_in_2)) & local_bb1_mul24_134_add1184_stall_local);
		local_bb1_mul24_134_add1184_consumed_0_NO_SHIFT_REG <= (local_bb1_mul24_134_add1184_inputs_ready & (local_bb1_mul24_134_add1184_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul24_134_add1184_stall_in)) & local_bb1_mul24_134_add1184_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_mul24_add1054_stall_local;
wire [31:0] local_bb1_mul24_add1054;

assign local_bb1_mul24_add1054 = (local_bb1_mul24_add998 + local_bb1_var__u33);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_6_stall_local;
wire [31:0] local_bb1_reduction_6;

assign local_bb1_reduction_6 = (local_bb1_mul24_2_add1178 + local_bb1_mul22_2_add372);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_valid_out_2;
wire local_bb1_c0_ene1_stall_in_2;
 reg local_bb1_c0_ene1_consumed_2_NO_SHIFT_REG;
wire local_bb1_rows_1_0_pop6_acl_pop_i32_0_valid_out_0;
wire local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_in_0;
 reg local_bb1_rows_1_0_pop6_acl_pop_i32_0_consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_0_0_pop7_acl_pop_i32_0_valid_out_0;
wire local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_in_0;
 reg local_bb1_rows_0_0_pop7_acl_pop_i32_0_consumed_0_NO_SHIFT_REG;
wire local_bb1_mul21_2_add310_valid_out;
wire local_bb1_mul21_2_add310_stall_in;
 reg local_bb1_mul21_2_add310_consumed_0_NO_SHIFT_REG;
wire local_bb1_mul21_1_add186_valid_out;
wire local_bb1_mul21_1_add186_stall_in;
 reg local_bb1_mul21_1_add186_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_6_valid_out;
wire local_bb1_reduction_6_stall_in;
 reg local_bb1_reduction_6_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_3_valid_out;
wire local_bb1_reduction_3_stall_in;
 reg local_bb1_reduction_3_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_3_inputs_ready;
wire local_bb1_reduction_3_stall_local;
wire [31:0] local_bb1_reduction_3;

assign local_bb1_reduction_3_inputs_ready = local_bb1_c0_enter_c0_eni5_valid_out_0_NO_SHIFT_REG;
assign local_bb1_reduction_3 = (local_bb1_mul24_1_add1116 + local_bb1_mul22_1_add248);
assign local_bb1_c0_ene1_valid_out_2 = 1'b1;
assign local_bb1_rows_1_0_pop6_acl_pop_i32_0_valid_out_0 = 1'b1;
assign local_bb1_rows_0_0_pop7_acl_pop_i32_0_valid_out_0 = 1'b1;
assign local_bb1_mul21_2_add310_valid_out = 1'b1;
assign local_bb1_mul21_1_add186_valid_out = 1'b1;
assign local_bb1_reduction_6_valid_out = 1'b1;
assign local_bb1_reduction_3_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni5_stall_in_0 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_ene1_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_1_0_pop6_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_0_0_pop7_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul21_2_add310_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul21_1_add186_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_6_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_3_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_c0_ene1_consumed_2_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_c0_ene1_consumed_2_NO_SHIFT_REG | ~(local_bb1_c0_ene1_stall_in_2)) & local_bb1_reduction_3_stall_local);
		local_bb1_rows_1_0_pop6_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_rows_1_0_pop6_acl_pop_i32_0_consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_in_0)) & local_bb1_reduction_3_stall_local);
		local_bb1_rows_0_0_pop7_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_rows_0_0_pop7_acl_pop_i32_0_consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_in_0)) & local_bb1_reduction_3_stall_local);
		local_bb1_mul21_2_add310_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_mul21_2_add310_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_2_add310_stall_in)) & local_bb1_reduction_3_stall_local);
		local_bb1_mul21_1_add186_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_mul21_1_add186_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_1_add186_stall_in)) & local_bb1_reduction_3_stall_local);
		local_bb1_reduction_6_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_reduction_6_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_6_stall_in)) & local_bb1_reduction_3_stall_local);
		local_bb1_reduction_3_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_3_inputs_ready & (local_bb1_reduction_3_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_3_stall_in)) & local_bb1_reduction_3_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_not_select1494_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_not_select1494_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_not_select1494_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_not_select1494_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_not_select1494_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_not_select1494_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_not_select1494_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_not_select1494),
	.data_out(rnode_171to172_bb1_not_select1494_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_not_select1494_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_not_select1494_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb1_not_select1494_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_not_select1494_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_not_select1494_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_not_select1494_stall_in_1 = 1'b0;
assign rnode_171to172_bb1_not_select1494_0_NO_SHIFT_REG = rnode_171to172_bb1_not_select1494_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_not_select1494_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_not_select1494_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_3_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_4_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_4_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_5_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_5_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0),
	.data_out(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_stall_in_2 = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_1_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_2_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_3_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_4_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_5_NO_SHIFT_REG = rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_mul24_134_add1184_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul24_134_add1184_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul24_134_add1184_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul24_134_add1184_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul24_134_add1184_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul24_134_add1184_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul24_134_add1184_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul24_134_add1184_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_mul24_134_add1184_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_mul24_134_add1184_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_mul24_134_add1184_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_mul24_134_add1184_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_mul24_134_add1184_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_mul24_134_add1184),
	.data_out(rnode_171to172_bb1_mul24_134_add1184_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_mul24_134_add1184_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_mul24_134_add1184_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_mul24_134_add1184_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_mul24_134_add1184_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_mul24_134_add1184_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul24_134_add1184_stall_in = 1'b0;
assign rnode_171to172_bb1_mul24_134_add1184_0_NO_SHIFT_REG = rnode_171to172_bb1_mul24_134_add1184_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_mul24_134_add1184_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_mul24_134_add1184_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1___valid_out_0;
wire local_bb1___stall_in_0;
 reg local_bb1___consumed_0_NO_SHIFT_REG;
wire local_bb1_mul21_add62_valid_out;
wire local_bb1_mul21_add62_stall_in;
 reg local_bb1_mul21_add62_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_valid_out;
wire local_bb1_reduction_0_stall_in;
 reg local_bb1_reduction_0_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_inputs_ready;
wire local_bb1_reduction_0_stall_local;
wire [31:0] local_bb1_reduction_0;

assign local_bb1_reduction_0_inputs_ready = (local_bb1_c0_enter_c0_eni5_valid_out_3_NO_SHIFT_REG & local_bb1_c0_enter_c0_eni5_valid_out_4_NO_SHIFT_REG);
assign local_bb1_reduction_0 = (local_bb1_mul24_add1054 + local_bb1_mul22_add124);
assign local_bb1___valid_out_0 = 1'b1;
assign local_bb1_mul21_add62_valid_out = 1'b1;
assign local_bb1_reduction_0_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni5_stall_in_3 = 1'b0;
assign local_bb1_c0_enter_c0_eni5_stall_in_4 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1___consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul21_add62_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_0_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1___consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_0_inputs_ready & (local_bb1___consumed_0_NO_SHIFT_REG | ~(local_bb1___stall_in_0)) & local_bb1_reduction_0_stall_local);
		local_bb1_mul21_add62_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_0_inputs_ready & (local_bb1_mul21_add62_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_add62_stall_in)) & local_bb1_reduction_0_stall_local);
		local_bb1_reduction_0_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_0_inputs_ready & (local_bb1_reduction_0_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_0_stall_in)) & local_bb1_reduction_0_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_c0_ene1_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_c0_ene1_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_c0_ene1_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_c0_ene1_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_c0_ene1_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_c0_ene1_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene1),
	.data_out(rnode_171to172_bb1_c0_ene1_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_c0_ene1_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_c0_ene1_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb1_c0_ene1_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_c0_ene1_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_c0_ene1_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene1_stall_in_2 = 1'b0;
assign rnode_171to172_bb1_c0_ene1_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene1_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene1_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_171to172_bb1_c0_ene1_0_reg_172_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_inputs_ready;
 reg local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_stall_in;
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_output_regs_ready;
wire [31:0] local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_result;
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_fu_valid_out;
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_fu_stall_out;
 reg [31:0] local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_NO_SHIFT_REG;
wire local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_causedstall;

acl_push local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb1_rows_1_0_pop6_acl_pop_i32_0),
	.stall_out(local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_result),
	.feedback_out(feedback_data_out_3),
	.feedback_valid_out(feedback_valid_out_3),
	.feedback_stall_in(feedback_stall_in_3)
);

defparam local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback.STALLFREE = 1;
defparam local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback.FIFO_DEPTH = 968;
defparam local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback.MIN_FIFO_LATENCY = 968;
defparam local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_feedback.STYLE = "REGULAR";

assign local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_inputs_ready = 1'b1;
assign local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_output_regs_ready = 1'b1;
assign local_bb1_rows_1_0_pop6_acl_pop_i32_0_stall_in_0 = 1'b0;
assign local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[1] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_NO_SHIFT_REG <= 'x;
		local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_output_regs_ready)
		begin
			local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_NO_SHIFT_REG <= local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_result;
			local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_stall_in))
			begin
				local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_inputs_ready;
 reg local_bb1_rows_1_0_push6_rows_0_0_pop7_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_stall_in;
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_output_regs_ready;
wire [31:0] local_bb1_rows_1_0_push6_rows_0_0_pop7_result;
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_fu_valid_out;
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_fu_stall_out;
 reg [31:0] local_bb1_rows_1_0_push6_rows_0_0_pop7_NO_SHIFT_REG;
wire local_bb1_rows_1_0_push6_rows_0_0_pop7_causedstall;

acl_push local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene3),
	.predicate(1'b0),
	.data_in(local_bb1_rows_0_0_pop7_acl_pop_i32_0),
	.stall_out(local_bb1_rows_1_0_push6_rows_0_0_pop7_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_1_0_push6_rows_0_0_pop7_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_1_0_push6_rows_0_0_pop7_result),
	.feedback_out(feedback_data_out_6),
	.feedback_valid_out(feedback_valid_out_6),
	.feedback_stall_in(feedback_stall_in_6)
);

defparam local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback.STALLFREE = 1;
defparam local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_1_0_push6_rows_0_0_pop7_feedback.STYLE = "REGULAR";

assign local_bb1_rows_1_0_push6_rows_0_0_pop7_inputs_ready = 1'b1;
assign local_bb1_rows_1_0_push6_rows_0_0_pop7_output_regs_ready = 1'b1;
assign local_bb1_rows_0_0_pop7_acl_pop_i32_0_stall_in_0 = 1'b0;
assign local_bb1_c0_ene3_stall_in_0 = 1'b0;
assign local_bb1_rows_1_0_push6_rows_0_0_pop7_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[1] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_1_0_push6_rows_0_0_pop7_NO_SHIFT_REG <= 'x;
		local_bb1_rows_1_0_push6_rows_0_0_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_1_0_push6_rows_0_0_pop7_output_regs_ready)
		begin
			local_bb1_rows_1_0_push6_rows_0_0_pop7_NO_SHIFT_REG <= local_bb1_rows_1_0_push6_rows_0_0_pop7_result;
			local_bb1_rows_1_0_push6_rows_0_0_pop7_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_1_0_push6_rows_0_0_pop7_stall_in))
			begin
				local_bb1_rows_1_0_push6_rows_0_0_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_mul21_2_add310_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_2_add310_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_2_add310_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_2_add310_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_2_add310_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_2_add310_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_2_add310_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_2_add310_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_mul21_2_add310_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_mul21_2_add310_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_mul21_2_add310_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_mul21_2_add310_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_mul21_2_add310_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_2_add310),
	.data_out(rnode_171to172_bb1_mul21_2_add310_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_mul21_2_add310_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_mul21_2_add310_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_mul21_2_add310_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_mul21_2_add310_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_mul21_2_add310_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_2_add310_stall_in = 1'b0;
assign rnode_171to172_bb1_mul21_2_add310_0_NO_SHIFT_REG = rnode_171to172_bb1_mul21_2_add310_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_mul21_2_add310_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_mul21_2_add310_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_mul21_1_add186_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_1_add186_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_1_add186_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_1_add186_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_1_add186_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_1_add186_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_1_add186_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_1_add186_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_mul21_1_add186_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_mul21_1_add186_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_mul21_1_add186_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_mul21_1_add186_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_mul21_1_add186_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_1_add186),
	.data_out(rnode_171to172_bb1_mul21_1_add186_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_mul21_1_add186_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_mul21_1_add186_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_mul21_1_add186_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_mul21_1_add186_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_mul21_1_add186_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_1_add186_stall_in = 1'b0;
assign rnode_171to172_bb1_mul21_1_add186_0_NO_SHIFT_REG = rnode_171to172_bb1_mul21_1_add186_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_mul21_1_add186_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_mul21_1_add186_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_reduction_6_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_6_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_6_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_6_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_6_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_6_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_6_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_reduction_6_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_reduction_6_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_reduction_6_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_reduction_6_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_reduction_6_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_6),
	.data_out(rnode_171to172_bb1_reduction_6_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_reduction_6_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_reduction_6_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_reduction_6_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_reduction_6_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_reduction_6_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_6_stall_in = 1'b0;
assign rnode_171to172_bb1_reduction_6_0_NO_SHIFT_REG = rnode_171to172_bb1_reduction_6_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_reduction_6_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_reduction_3_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_3_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_3_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_3_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_3_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_3_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_3_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_reduction_3_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_reduction_3_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_reduction_3_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_reduction_3_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_reduction_3_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_3),
	.data_out(rnode_171to172_bb1_reduction_3_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_reduction_3_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_reduction_3_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_reduction_3_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_reduction_3_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_reduction_3_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_3_stall_in = 1'b0;
assign rnode_171to172_bb1_reduction_3_0_NO_SHIFT_REG = rnode_171to172_bb1_reduction_3_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_reduction_3_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__coalesced_pop2_acl_pop_i32_0_valid_out;
wire local_bb1__coalesced_pop2_acl_pop_i32_0_stall_in;
wire local_bb1__coalesced_pop2_acl_pop_i32_0_inputs_ready;
wire local_bb1__coalesced_pop2_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1__coalesced_pop2_acl_pop_i32_0;
wire local_bb1__coalesced_pop2_acl_pop_i32_0_fu_valid_out;
wire local_bb1__coalesced_pop2_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1__coalesced_pop2_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_171to172_bb1_not_select1494_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1__coalesced_pop2_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1__coalesced_pop2_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1__coalesced_pop2_acl_pop_i32_0_stall_local),
	.data_out(local_bb1__coalesced_pop2_acl_pop_i32_0),
	.feedback_in(feedback_data_in_2),
	.feedback_valid_in(feedback_valid_in_2),
	.feedback_stall_out(feedback_stall_out_2)
);

defparam local_bb1__coalesced_pop2_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 968;
defparam local_bb1__coalesced_pop2_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1__coalesced_pop2_acl_pop_i32_0_feedback.STYLE = "COALESCE";

assign local_bb1__coalesced_pop2_acl_pop_i32_0_inputs_ready = rnode_171to172_bb1_not_select1494_0_valid_out_NO_SHIFT_REG;
assign local_bb1__coalesced_pop2_acl_pop_i32_0_stall_local = 1'b0;
assign local_bb1__coalesced_pop2_acl_pop_i32_0_valid_out = 1'b1;
assign rnode_171to172_bb1_not_select1494_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_inputs_ready;
 reg local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_stall_in;
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_output_regs_ready;
wire [31:0] local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_result;
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_fu_valid_out;
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_fu_stall_out;
 reg [31:0] local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_NO_SHIFT_REG;
wire local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_causedstall;

acl_push local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_171to172_bb1_c0_ene3_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_result),
	.feedback_out(feedback_data_out_5),
	.feedback_valid_out(feedback_valid_out_5),
	.feedback_stall_in(feedback_stall_in_5)
);

defparam local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback.STALLFREE = 1;
defparam local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_feedback.STYLE = "REGULAR";

assign local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_inputs_ready = 1'b1;
assign local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_output_regs_ready = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_NO_SHIFT_REG <= 'x;
		local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_output_regs_ready)
		begin
			local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_NO_SHIFT_REG <= local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_result;
			local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_stall_in))
			begin
				local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_shr17_129_stall_local;
wire [31:0] local_bb1_shr17_129;

assign local_bb1_shr17_129 = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_1_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u35_stall_local;
wire [31:0] local_bb1_var__u35;

assign local_bb1_var__u35 = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_2_NO_SHIFT_REG >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u36_stall_local;
wire [31:0] local_bb1_var__u36;

assign local_bb1_var__u36 = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_3_NO_SHIFT_REG >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u37_stall_local;
wire [31:0] local_bb1_var__u37;

assign local_bb1_var__u37 = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_4_NO_SHIFT_REG >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u38_stall_local;
wire [31:0] local_bb1_var__u38;

assign local_bb1_var__u38 = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_5_NO_SHIFT_REG >> 32'h14);

// This section implements a registered operation.
// 
wire local_bb1_rows_0_0_push7___inputs_ready;
 reg local_bb1_rows_0_0_push7___valid_out_NO_SHIFT_REG;
wire local_bb1_rows_0_0_push7___stall_in;
wire local_bb1_rows_0_0_push7___output_regs_ready;
wire [31:0] local_bb1_rows_0_0_push7___result;
wire local_bb1_rows_0_0_push7___fu_valid_out;
wire local_bb1_rows_0_0_push7___fu_stall_out;
 reg [31:0] local_bb1_rows_0_0_push7___NO_SHIFT_REG;
wire local_bb1_rows_0_0_push7___causedstall;

acl_push local_bb1_rows_0_0_push7___feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene3),
	.predicate(1'b0),
	.data_in(local_bb1__),
	.stall_out(local_bb1_rows_0_0_push7___fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[1]),
	.valid_out(local_bb1_rows_0_0_push7___fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_0_0_push7___result),
	.feedback_out(feedback_data_out_7),
	.feedback_valid_out(feedback_valid_out_7),
	.feedback_stall_in(feedback_stall_in_7)
);

defparam local_bb1_rows_0_0_push7___feedback.STALLFREE = 1;
defparam local_bb1_rows_0_0_push7___feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_0_0_push7___feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_0_0_push7___feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_0_0_push7___feedback.STYLE = "REGULAR";

assign local_bb1_rows_0_0_push7___inputs_ready = 1'b1;
assign local_bb1_rows_0_0_push7___output_regs_ready = 1'b1;
assign local_bb1___stall_in_0 = 1'b0;
assign local_bb1_c0_ene3_stall_in_1 = 1'b0;
assign local_bb1_rows_0_0_push7___causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[1] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_0_0_push7___NO_SHIFT_REG <= 'x;
		local_bb1_rows_0_0_push7___valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_0_0_push7___output_regs_ready)
		begin
			local_bb1_rows_0_0_push7___NO_SHIFT_REG <= local_bb1_rows_0_0_push7___result;
			local_bb1_rows_0_0_push7___valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_0_0_push7___stall_in))
			begin
				local_bb1_rows_0_0_push7___valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_mul21_add62_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_add62_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_add62_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_add62_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_mul21_add62_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_add62_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_add62_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_mul21_add62_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_mul21_add62_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_mul21_add62_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_mul21_add62_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_mul21_add62_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_mul21_add62_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_add62),
	.data_out(rnode_171to172_bb1_mul21_add62_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_mul21_add62_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_mul21_add62_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_mul21_add62_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_mul21_add62_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_mul21_add62_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_add62_stall_in = 1'b0;
assign rnode_171to172_bb1_mul21_add62_0_NO_SHIFT_REG = rnode_171to172_bb1_mul21_add62_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_mul21_add62_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_mul21_add62_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_reduction_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_0_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_0_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_reduction_0_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_0_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_0_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_reduction_0_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_reduction_0_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_reduction_0_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_reduction_0_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_reduction_0_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_reduction_0_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_0),
	.data_out(rnode_171to172_bb1_reduction_0_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_reduction_0_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_reduction_0_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_reduction_0_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_reduction_0_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_reduction_0_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_0_stall_in = 1'b0;
assign rnode_171to172_bb1_reduction_0_0_NO_SHIFT_REG = rnode_171to172_bb1_reduction_0_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_reduction_0_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_0_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_rows_971_0_pop4_acl_pop_i32_0;
wire local_bb1_rows_971_0_pop4_acl_pop_i32_0_fu_valid_out;
wire local_bb1_rows_971_0_pop4_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_rows_971_0_pop4_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_171to172_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_rows_971_0_pop4_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_971_0_pop4_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_rows_971_0_pop4_acl_pop_i32_0),
	.feedback_in(feedback_data_in_4),
	.feedback_valid_in(feedback_valid_in_4),
	.feedback_stall_out(feedback_stall_out_4)
);

defparam local_bb1_rows_971_0_pop4_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_rows_971_0_pop4_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_971_0_pop4_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_valid_out;
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_stall_in;
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_inputs_ready;
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_rows_970_0_pop5_acl_pop_i32_0;
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_fu_valid_out;
wire local_bb1_rows_970_0_pop5_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_rows_970_0_pop5_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_171to172_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_rows_970_0_pop5_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_970_0_pop5_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_rows_970_0_pop5_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_rows_970_0_pop5_acl_pop_i32_0),
	.feedback_in(feedback_data_in_5),
	.feedback_valid_in(feedback_valid_in_5),
	.feedback_stall_out(feedback_stall_out_5)
);

defparam local_bb1_rows_970_0_pop5_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_rows_970_0_pop5_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_970_0_pop5_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1_rows_970_0_pop5_acl_pop_i32_0_inputs_ready = rnode_171to172_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_rows_970_0_pop5_acl_pop_i32_0_stall_local = 1'b0;
assign local_bb1_rows_970_0_pop5_acl_pop_i32_0_valid_out = 1'b1;
assign rnode_171to172_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_c0_ene1_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_c0_ene1_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_c0_ene1_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_c0_ene1_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_c0_ene1_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_c0_ene1_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb1_c0_ene1_2_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_c0_ene1_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_c0_ene1_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_c0_ene1_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_c0_ene1_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_c0_ene1_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_c0_ene1_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_c0_ene1_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_172to173_bb1_c0_ene1_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_172to173_bb1_c0_ene1_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_stall_in = 1'b0;
assign rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG = rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_rows_1_0_push6_rows_0_0_pop7_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_1_0_push6_rows_0_0_pop7_stall_in = 1'b0;
assign rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG = rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_7_stall_local;
wire [31:0] local_bb1_reduction_7;

assign local_bb1_reduction_7 = (rnode_171to172_bb1_mul21_2_add310_0_NO_SHIFT_REG + 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_4_stall_local;
wire [31:0] local_bb1_reduction_4;

assign local_bb1_reduction_4 = (rnode_171to172_bb1_mul21_1_add186_0_NO_SHIFT_REG + 32'h80);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_4_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_4_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_5_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_5_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_6_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_6_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_7_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_7_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__coalesced_pop2_acl_pop_i32_0),
	.data_out(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__coalesced_pop2_acl_pop_i32_0_stall_in = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_1_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_2_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_3_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_4_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_5_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_6_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_7_NO_SHIFT_REG = rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_stall_in = 1'b0;
assign rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_133_masked_stall_local;
wire [31:0] local_bb1_mul22_133_masked;

assign local_bb1_mul22_133_masked = (local_bb1_shr17_129 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u39_stall_local;
wire [31:0] local_bb1_var__u39;

assign local_bb1_var__u39 = (local_bb1_var__u35 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u40_stall_local;
wire [31:0] local_bb1_var__u40;

assign local_bb1_var__u40 = (local_bb1_var__u36 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u41_stall_local;
wire [31:0] local_bb1_var__u41;

assign local_bb1_var__u41 = (local_bb1_var__u37 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u42_stall_local;
wire [31:0] local_bb1_var__u42;

assign local_bb1_var__u42 = (local_bb1_var__u38 & 32'hFF0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_0_0_push7___0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_0_0_push7___0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_rows_0_0_push7___0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_0_0_push7___0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_0_0_push7___0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_rows_0_0_push7___0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_rows_0_0_push7___0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_rows_0_0_push7___0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_rows_0_0_push7___0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_rows_0_0_push7___0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_rows_0_0_push7___0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_rows_0_0_push7___NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_rows_0_0_push7___0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_rows_0_0_push7___0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_rows_0_0_push7___0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_rows_0_0_push7___0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_rows_0_0_push7___0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_rows_0_0_push7___0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_0_0_push7___stall_in = 1'b0;
assign rnode_172to173_bb1_rows_0_0_push7___0_NO_SHIFT_REG = rnode_172to173_bb1_rows_0_0_push7___0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_rows_0_0_push7___0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_1_stall_local;
wire [31:0] local_bb1_reduction_1;

assign local_bb1_reduction_1 = (rnode_171to172_bb1_mul21_add62_0_NO_SHIFT_REG + 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_2_1_stall_local;
wire [31:0] local_bb1_shr17_2_1;

assign local_bb1_shr17_2_1 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_2_1_stall_local;
wire [31:0] local_bb1_shr19_2_1;

assign local_bb1_shr19_2_1 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u43_stall_local;
wire [31:0] local_bb1_var__u43;

assign local_bb1_var__u43 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u44_stall_local;
wire [31:0] local_bb1_var__u44;

assign local_bb1_var__u44 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u45_stall_local;
wire [31:0] local_bb1_var__u45;

assign local_bb1_var__u45 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u46_stall_local;
wire [31:0] local_bb1_var__u46;

assign local_bb1_var__u46 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u47_stall_local;
wire [31:0] local_bb1_var__u47;

assign local_bb1_var__u47 = (local_bb1_rows_971_0_pop4_acl_pop_i32_0 >> 32'h14);

// This section implements a registered operation.
// 
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_inputs_ready;
 reg local_bb1_rows_971_0_push4_rows_970_0_pop5_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_stall_in;
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_output_regs_ready;
wire [31:0] local_bb1_rows_971_0_push4_rows_970_0_pop5_result;
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_fu_valid_out;
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_fu_stall_out;
 reg [31:0] local_bb1_rows_971_0_push4_rows_970_0_pop5_NO_SHIFT_REG;
wire local_bb1_rows_971_0_push4_rows_970_0_pop5_causedstall;

acl_push local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_171to172_bb1_c0_ene3_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_970_0_pop5_acl_pop_i32_0),
	.stall_out(local_bb1_rows_971_0_push4_rows_970_0_pop5_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_971_0_push4_rows_970_0_pop5_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_971_0_push4_rows_970_0_pop5_result),
	.feedback_out(feedback_data_out_4),
	.feedback_valid_out(feedback_valid_out_4),
	.feedback_stall_in(feedback_stall_in_4)
);

defparam local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback.STALLFREE = 1;
defparam local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback.DATA_WIDTH = 32;
defparam local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_971_0_push4_rows_970_0_pop5_feedback.STYLE = "REGULAR";

assign local_bb1_rows_971_0_push4_rows_970_0_pop5_inputs_ready = 1'b1;
assign local_bb1_rows_971_0_push4_rows_970_0_pop5_output_regs_ready = 1'b1;
assign local_bb1_rows_970_0_pop5_acl_pop_i32_0_stall_in = 1'b0;
assign rnode_171to172_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_971_0_push4_rows_970_0_pop5_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_971_0_push4_rows_970_0_pop5_NO_SHIFT_REG <= 'x;
		local_bb1_rows_971_0_push4_rows_970_0_pop5_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_971_0_push4_rows_970_0_pop5_output_regs_ready)
		begin
			local_bb1_rows_971_0_push4_rows_970_0_pop5_NO_SHIFT_REG <= local_bb1_rows_971_0_push4_rows_970_0_pop5_result;
			local_bb1_rows_971_0_push4_rows_970_0_pop5_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_971_0_push4_rows_970_0_pop5_stall_in))
			begin
				local_bb1_rows_971_0_push4_rows_970_0_pop5_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop8_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1__pop8_acl_pop_i32_0;
wire local_bb1__pop8_acl_pop_i32_0_fu_valid_out;
wire local_bb1__pop8_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1__pop8_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_172to173_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1__pop8_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1__pop8_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1__pop8_acl_pop_i32_0_stall_local),
	.data_out(local_bb1__pop8_acl_pop_i32_0),
	.feedback_in(feedback_data_in_8),
	.feedback_valid_in(feedback_valid_in_8),
	.feedback_stall_out(feedback_stall_out_8)
);

defparam local_bb1__pop8_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1__pop8_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1__pop8_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1__pop8_acl_pop_i32_0_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop9_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1__pop9_acl_pop_i32_0;
wire local_bb1__pop9_acl_pop_i32_0_fu_valid_out;
wire local_bb1__pop9_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1__pop9_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_172to173_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1__pop9_acl_pop_i32_0_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1__pop9_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1__pop9_acl_pop_i32_0_stall_local),
	.data_out(local_bb1__pop9_acl_pop_i32_0),
	.feedback_in(feedback_data_in_9),
	.feedback_valid_in(feedback_valid_in_9),
	.feedback_stall_out(feedback_stall_out_9)
);

defparam local_bb1__pop9_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1__pop9_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1__pop9_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1__pop9_acl_pop_i32_0_stall_local = 1'b0;

// Register node:
//  * latency = 6
//  * capacity = 6
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG),
	.data_out(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_fifo.DEPTH = 6;
defparam rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG = rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_179_NO_SHIFT_REG;
assign rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 6
//  * capacity = 6
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG),
	.data_out(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_fifo.DEPTH = 6;
defparam rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG = rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_179_NO_SHIFT_REG;
assign rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_8_stall_local;
wire [31:0] local_bb1_reduction_8;

assign local_bb1_reduction_8 = (rnode_171to172_bb1_reduction_6_0_NO_SHIFT_REG + local_bb1_reduction_7);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_5_stall_local;
wire [31:0] local_bb1_reduction_5;

assign local_bb1_reduction_5 = (rnode_171to172_bb1_reduction_3_0_NO_SHIFT_REG + local_bb1_reduction_4);

// This section implements a registered operation.
// 
wire local_bb1__push8__coalesced_pop2_inputs_ready;
 reg local_bb1__push8__coalesced_pop2_valid_out_NO_SHIFT_REG;
wire local_bb1__push8__coalesced_pop2_stall_in;
wire local_bb1__push8__coalesced_pop2_output_regs_ready;
wire [31:0] local_bb1__push8__coalesced_pop2_result;
wire local_bb1__push8__coalesced_pop2_fu_valid_out;
wire local_bb1__push8__coalesced_pop2_fu_stall_out;
 reg [31:0] local_bb1__push8__coalesced_pop2_NO_SHIFT_REG;
wire local_bb1__push8__coalesced_pop2_causedstall;

acl_push local_bb1__push8__coalesced_pop2_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_172to173_bb1_c0_ene3_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_NO_SHIFT_REG),
	.stall_out(local_bb1__push8__coalesced_pop2_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1__push8__coalesced_pop2_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push8__coalesced_pop2_result),
	.feedback_out(feedback_data_out_8),
	.feedback_valid_out(feedback_valid_out_8),
	.feedback_stall_in(feedback_stall_in_8)
);

defparam local_bb1__push8__coalesced_pop2_feedback.STALLFREE = 1;
defparam local_bb1__push8__coalesced_pop2_feedback.DATA_WIDTH = 32;
defparam local_bb1__push8__coalesced_pop2_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push8__coalesced_pop2_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push8__coalesced_pop2_feedback.STYLE = "REGULAR";

assign local_bb1__push8__coalesced_pop2_inputs_ready = 1'b1;
assign local_bb1__push8__coalesced_pop2_output_regs_ready = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1__push8__coalesced_pop2_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push8__coalesced_pop2_NO_SHIFT_REG <= 'x;
		local_bb1__push8__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push8__coalesced_pop2_output_regs_ready)
		begin
			local_bb1__push8__coalesced_pop2_NO_SHIFT_REG <= local_bb1__push8__coalesced_pop2_result;
			local_bb1__push8__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push8__coalesced_pop2_stall_in))
			begin
				local_bb1__push8__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_shr17_249_stall_local;
wire [31:0] local_bb1_shr17_249;

assign local_bb1_shr17_249 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_1_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_251_stall_local;
wire [31:0] local_bb1_shr19_251;

assign local_bb1_shr19_251 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_2_NO_SHIFT_REG >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u48_stall_local;
wire [31:0] local_bb1_var__u48;

assign local_bb1_var__u48 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_3_NO_SHIFT_REG >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u49_stall_local;
wire [31:0] local_bb1_var__u49;

assign local_bb1_var__u49 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_4_NO_SHIFT_REG >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u50_stall_local;
wire [31:0] local_bb1_var__u50;

assign local_bb1_var__u50 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_5_NO_SHIFT_REG >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u51_stall_local;
wire [31:0] local_bb1_var__u51;

assign local_bb1_var__u51 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_6_NO_SHIFT_REG >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u52_stall_local;
wire [31:0] local_bb1_var__u52;

assign local_bb1_var__u52 = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_7_NO_SHIFT_REG >> 32'h14);

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG),
	.data_out(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_fifo.DEPTH = 5;
defparam rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_179_NO_SHIFT_REG;
assign rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_132_add434_stall_local;
wire [31:0] local_bb1_mul21_132_add434;

assign local_bb1_mul21_132_add434 = (local_bb1_var__u39 + local_bb1_var__u40);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_133_add496_stall_local;
wire [31:0] local_bb1_mul22_133_add496;

assign local_bb1_mul22_133_add496 = (local_bb1_mul22_133_masked + local_bb1_var__u41);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_134_add1240_stall_local;
wire [31:0] local_bb1_mul24_134_add1240;

assign local_bb1_mul24_134_add1240 = (rnode_171to172_bb1_mul24_134_add1184_0_NO_SHIFT_REG + local_bb1_var__u42);

// Register node:
//  * latency = 6
//  * capacity = 6
 logic rnode_173to179_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_0_0_push7___0_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_0_0_push7___0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to179_bb1_rows_0_0_push7___0_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_0_0_push7___0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_0_0_push7___0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_173to179_bb1_rows_0_0_push7___0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_173to179_bb1_rows_0_0_push7___0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to179_bb1_rows_0_0_push7___0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to179_bb1_rows_0_0_push7___0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_173to179_bb1_rows_0_0_push7___0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_173to179_bb1_rows_0_0_push7___0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb1_rows_0_0_push7___0_NO_SHIFT_REG),
	.data_out(rnode_173to179_bb1_rows_0_0_push7___0_reg_179_NO_SHIFT_REG)
);

defparam rnode_173to179_bb1_rows_0_0_push7___0_reg_179_fifo.DEPTH = 6;
defparam rnode_173to179_bb1_rows_0_0_push7___0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_173to179_bb1_rows_0_0_push7___0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to179_bb1_rows_0_0_push7___0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_173to179_bb1_rows_0_0_push7___0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_0_0_push7___0_NO_SHIFT_REG = rnode_173to179_bb1_rows_0_0_push7___0_reg_179_NO_SHIFT_REG;
assign rnode_173to179_bb1_rows_0_0_push7___0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_173to179_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_stall_local;
wire [31:0] local_bb1_reduction_2;

assign local_bb1_reduction_2 = (rnode_171to172_bb1_reduction_0_0_NO_SHIFT_REG + local_bb1_reduction_1);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_1_masked_stall_local;
wire [31:0] local_bb1_mul22_2_1_masked;

assign local_bb1_mul22_2_1_masked = (local_bb1_shr17_2_1 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u53_stall_local;
wire [31:0] local_bb1_var__u53;

assign local_bb1_var__u53 = (local_bb1_var__u43 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u54_stall_local;
wire [31:0] local_bb1_var__u54;

assign local_bb1_var__u54 = (local_bb1_var__u44 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u55_stall_local;
wire [31:0] local_bb1_var__u55;

assign local_bb1_var__u55 = (local_bb1_var__u45 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u56_stall_local;
wire [31:0] local_bb1_var__u56;

assign local_bb1_var__u56 = (local_bb1_var__u46 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u57_stall_local;
wire [31:0] local_bb1_var__u57;

assign local_bb1_var__u57 = (local_bb1_var__u47 & 32'hFF0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_rows_971_0_push4_rows_970_0_pop5_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_971_0_push4_rows_970_0_pop5_stall_in = 1'b0;
assign rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG = rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_1_2_stall_local;
wire [31:0] local_bb1_shr17_1_2;

assign local_bb1_shr17_1_2 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_1_2_stall_local;
wire [31:0] local_bb1_shr19_1_2;

assign local_bb1_shr19_1_2 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u58_stall_local;
wire [31:0] local_bb1_var__u58;

assign local_bb1_var__u58 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u59_stall_local;
wire [31:0] local_bb1_var__u59;

assign local_bb1_var__u59 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u60_stall_local;
wire [31:0] local_bb1_var__u60;

assign local_bb1_var__u60 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u61_stall_local;
wire [31:0] local_bb1_var__u61;

assign local_bb1_var__u61 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u62_stall_local;
wire [31:0] local_bb1_var__u62;

assign local_bb1_var__u62 = (local_bb1__pop8_acl_pop_i32_0 >> 32'h14);

// This section implements an unregistered operation.
// 
wire local_bb1_shr17_2_2_stall_local;
wire [31:0] local_bb1_shr17_2_2;

assign local_bb1_shr17_2_2 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_shr19_2_2_stall_local;
wire [31:0] local_bb1_shr19_2_2;

assign local_bb1_shr19_2_2 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u63_stall_local;
wire [31:0] local_bb1_var__u63;

assign local_bb1_var__u63 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u64_stall_local;
wire [31:0] local_bb1_var__u64;

assign local_bb1_var__u64 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u65_stall_local;
wire [31:0] local_bb1_var__u65;

assign local_bb1_var__u65 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u66_stall_local;
wire [31:0] local_bb1_var__u66;

assign local_bb1_var__u66 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h15);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u67_stall_local;
wire [31:0] local_bb1_var__u67;

assign local_bb1_var__u67 = (local_bb1__pop9_acl_pop_i32_0 >> 32'h14);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to179_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_NO_SHIFT_REG = rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to179_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_NO_SHIFT_REG = rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_2_valid_out;
wire local_bb1_shr27_2_stall_in;
wire local_bb1_shr27_2_inputs_ready;
wire local_bb1_shr27_2_stall_local;
wire [31:0] local_bb1_shr27_2;

assign local_bb1_shr27_2_inputs_ready = (rnode_171to172_bb1_mul21_2_add310_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_reduction_6_0_valid_out_NO_SHIFT_REG);
assign local_bb1_shr27_2 = (local_bb1_reduction_8 >> 32'h8);
assign local_bb1_shr27_2_valid_out = 1'b1;
assign rnode_171to172_bb1_mul21_2_add310_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_6_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_1_valid_out;
wire local_bb1_shr27_1_stall_in;
wire local_bb1_shr27_1_inputs_ready;
wire local_bb1_shr27_1_stall_local;
wire [31:0] local_bb1_shr27_1;

assign local_bb1_shr27_1_inputs_ready = (rnode_171to172_bb1_mul21_1_add186_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_reduction_3_0_valid_out_NO_SHIFT_REG);
assign local_bb1_shr27_1 = (local_bb1_reduction_5 >> 32'h8);
assign local_bb1_shr27_1_valid_out = 1'b1;
assign rnode_171to172_bb1_mul21_1_add186_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_3_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push8__coalesced_pop2_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1__push8__coalesced_pop2_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1__push8__coalesced_pop2_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1__push8__coalesced_pop2_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1__push8__coalesced_pop2_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push8__coalesced_pop2_stall_in = 1'b0;
assign rnode_174to175_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG = rnode_174to175_bb1__push8__coalesced_pop2_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1__push8__coalesced_pop2_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_253_masked_stall_local;
wire [31:0] local_bb1_mul22_253_masked;

assign local_bb1_mul22_253_masked = (local_bb1_shr17_249 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u68_stall_local;
wire [31:0] local_bb1_var__u68;

assign local_bb1_var__u68 = (local_bb1_var__u48 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u69_stall_local;
wire [31:0] local_bb1_var__u69;

assign local_bb1_var__u69 = (local_bb1_var__u49 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u70_stall_local;
wire [31:0] local_bb1_var__u70;

assign local_bb1_var__u70 = (local_bb1_var__u50 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u71_stall_local;
wire [31:0] local_bb1_var__u71;

assign local_bb1_var__u71 = (local_bb1_var__u51 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u72_stall_local;
wire [31:0] local_bb1_var__u72;

assign local_bb1_var__u72 = (local_bb1_var__u52 & 32'hFF0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to179_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_10_stall_local;
wire [31:0] local_bb1_reduction_10;

assign local_bb1_reduction_10 = (local_bb1_mul21_132_add434 + 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_9_stall_local;
wire [31:0] local_bb1_reduction_9;

assign local_bb1_reduction_9 = (local_bb1_mul24_134_add1240 + local_bb1_mul22_133_add496);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_0_0_push7___0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_0_0_push7___0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_0_0_push7___0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_0_0_push7___0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_0_0_push7___0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_0_0_push7___0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_rows_0_0_push7___0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_rows_0_0_push7___0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_rows_0_0_push7___0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_rows_0_0_push7___0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_rows_0_0_push7___0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_173to179_bb1_rows_0_0_push7___0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_rows_0_0_push7___0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_rows_0_0_push7___0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_rows_0_0_push7___0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_rows_0_0_push7___0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_rows_0_0_push7___0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_rows_0_0_push7___0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to179_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_0_0_push7___0_NO_SHIFT_REG = rnode_179to180_bb1_rows_0_0_push7___0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_rows_0_0_push7___0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_0_0_push7___0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_valid_out;
wire local_bb1_shr27_stall_in;
wire local_bb1_shr27_inputs_ready;
wire local_bb1_shr27_stall_local;
wire [31:0] local_bb1_shr27;

assign local_bb1_shr27_inputs_ready = (rnode_171to172_bb1_mul21_add62_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_reduction_0_0_valid_out_NO_SHIFT_REG);
assign local_bb1_shr27 = (local_bb1_reduction_2 >> 32'h8);
assign local_bb1_shr27_valid_out = 1'b1;
assign rnode_171to172_bb1_mul21_add62_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_reduction_0_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_2_1_add558_stall_local;
wire [31:0] local_bb1_mul21_2_1_add558;

assign local_bb1_mul21_2_1_add558 = (local_bb1_var__u53 + local_bb1_var__u54);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_1_add620_stall_local;
wire [31:0] local_bb1_mul22_2_1_add620;

assign local_bb1_mul22_2_1_add620 = (local_bb1_mul22_2_1_masked + local_bb1_var__u55);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_1_add1246_stall_local;
wire [31:0] local_bb1_mul24_2_1_add1246;

assign local_bb1_mul24_2_1_add1246 = (local_bb1_shr19_2_1 + local_bb1_var__u56);

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG),
	.data_out(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_fifo.DEPTH = 5;
defparam rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG = rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_179_NO_SHIFT_REG;
assign rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_1_2_masked_stall_local;
wire [31:0] local_bb1_mul22_1_2_masked;

assign local_bb1_mul22_1_2_masked = (local_bb1_shr17_1_2 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u73_stall_local;
wire [31:0] local_bb1_var__u73;

assign local_bb1_var__u73 = (local_bb1_var__u58 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u74_stall_local;
wire [31:0] local_bb1_var__u74;

assign local_bb1_var__u74 = (local_bb1_var__u59 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u75_stall_local;
wire [31:0] local_bb1_var__u75;

assign local_bb1_var__u75 = (local_bb1_var__u60 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u76_stall_local;
wire [31:0] local_bb1_var__u76;

assign local_bb1_var__u76 = (local_bb1_var__u61 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u77_stall_local;
wire [31:0] local_bb1_var__u77;

assign local_bb1_var__u77 = (local_bb1_var__u62 & 32'hFF0);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_2_masked_stall_local;
wire [31:0] local_bb1_mul22_2_2_masked;

assign local_bb1_mul22_2_2_masked = (local_bb1_shr17_2_2 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u78_stall_local;
wire [31:0] local_bb1_var__u78;

assign local_bb1_var__u78 = (local_bb1_var__u63 & 32'h1FE);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u79_stall_local;
wire [31:0] local_bb1_var__u79;

assign local_bb1_var__u79 = (local_bb1_var__u64 & 32'h3FC0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u80_stall_local;
wire [31:0] local_bb1_var__u80;

assign local_bb1_var__u80 = (local_bb1_var__u65 & 32'h7F80);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u81_stall_local;
wire [31:0] local_bb1_var__u81;

assign local_bb1_var__u81 = (local_bb1_var__u66 & 32'h7F8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u82_stall_local;
wire [31:0] local_bb1_var__u82;

assign local_bb1_var__u82 = (local_bb1_var__u67 & 32'hFF0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_shr27_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr27_2_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_2_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr27_2_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_2_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_2_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_2_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_shr27_2_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_shr27_2_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_shr27_2_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_shr27_2_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_shr27_2_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_shr27_2),
	.data_out(rnode_172to173_bb1_shr27_2_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_shr27_2_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_shr27_2_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_shr27_2_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_shr27_2_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_shr27_2_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr27_2_stall_in = 1'b0;
assign rnode_172to173_bb1_shr27_2_0_NO_SHIFT_REG = rnode_172to173_bb1_shr27_2_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_shr27_2_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_shr27_2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_var__u83_inputs_ready;
 reg local_bb1_var__u83_valid_out_NO_SHIFT_REG;
wire local_bb1_var__u83_stall_in;
wire local_bb1_var__u83_output_regs_ready;
wire [31:0] local_bb1_var__u83;
 reg local_bb1_var__u83_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_var__u83_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_var__u83_causedstall;

acl_int_mult int_module_local_bb1_var__u83 (
	.clock(clock),
	.dataa(local_bb1_shr27_1),
	.datab(32'hFFFFFFFE),
	.enable(local_bb1_var__u83_output_regs_ready),
	.result(local_bb1_var__u83)
);

defparam int_module_local_bb1_var__u83.INPUT1_WIDTH = 10;
defparam int_module_local_bb1_var__u83.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_var__u83.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_var__u83.LATENCY = 3;
defparam int_module_local_bb1_var__u83.SIGNED = 0;

assign local_bb1_var__u83_inputs_ready = 1'b1;
assign local_bb1_var__u83_output_regs_ready = 1'b1;
assign local_bb1_shr27_1_stall_in = 1'b0;
assign local_bb1_var__u83_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_var__u83_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u83_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_var__u83_output_regs_ready)
		begin
			local_bb1_var__u83_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_var__u83_valid_pipe_1_NO_SHIFT_REG <= local_bb1_var__u83_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_var__u83_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_var__u83_output_regs_ready)
		begin
			local_bb1_var__u83_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_var__u83_stall_in))
			begin
				local_bb1_var__u83_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to179_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push8__coalesced_pop2_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to179_bb1__push8__coalesced_pop2_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_175to179_bb1__push8__coalesced_pop2_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_175to179_bb1__push8__coalesced_pop2_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_174to175_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG),
	.data_out(rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_fifo.DEPTH = 4;
defparam rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to179_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG = rnode_175to179_bb1__push8__coalesced_pop2_0_reg_179_NO_SHIFT_REG;
assign rnode_175to179_bb1__push8__coalesced_pop2_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_175to179_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_252_add682_stall_local;
wire [31:0] local_bb1_mul21_252_add682;

assign local_bb1_mul21_252_add682 = (local_bb1_var__u68 + local_bb1_var__u69);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_253_add744_stall_local;
wire [31:0] local_bb1_mul22_253_add744;

assign local_bb1_mul22_253_add744 = (local_bb1_mul22_253_masked + local_bb1_var__u70);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_254_add1308_stall_local;
wire [31:0] local_bb1_mul24_254_add1308;

assign local_bb1_mul24_254_add1308 = (local_bb1_shr19_251 + local_bb1_var__u71);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_11_stall_local;
wire [31:0] local_bb1_reduction_11;

assign local_bb1_reduction_11 = (local_bb1_reduction_9 + local_bb1_reduction_10);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_shr27_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr27_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr27_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr27_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_shr27_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_shr27_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_shr27_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_shr27_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_shr27_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_shr27),
	.data_out(rnode_172to173_bb1_shr27_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_shr27_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_shr27_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_shr27_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_shr27_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_shr27_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr27_stall_in = 1'b0;
assign rnode_172to173_bb1_shr27_0_NO_SHIFT_REG = rnode_172to173_bb1_shr27_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_shr27_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_shr27_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_1_add1302_stall_local;
wire [31:0] local_bb1_mul24_2_1_add1302;

assign local_bb1_mul24_2_1_add1302 = (local_bb1_mul24_2_1_add1246 + local_bb1_var__u57);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to179_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_NO_SHIFT_REG = rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_1_2_add806_stall_local;
wire [31:0] local_bb1_mul21_1_2_add806;

assign local_bb1_mul21_1_2_add806 = (local_bb1_var__u73 + local_bb1_var__u74);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_1_2_add868_stall_local;
wire [31:0] local_bb1_mul22_1_2_add868;

assign local_bb1_mul22_1_2_add868 = (local_bb1_mul22_1_2_masked + local_bb1_var__u75);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_1_2_add1370_stall_local;
wire [31:0] local_bb1_mul24_1_2_add1370;

assign local_bb1_mul24_1_2_add1370 = (local_bb1_shr19_1_2 + local_bb1_var__u76);

// This section implements an unregistered operation.
// 
wire local_bb1_mul21_2_2_add930_stall_local;
wire [31:0] local_bb1_mul21_2_2_add930;

assign local_bb1_mul21_2_2_add930 = (local_bb1_var__u78 + local_bb1_var__u79);

// This section implements an unregistered operation.
// 
wire local_bb1_mul22_2_2_add992_stall_local;
wire [31:0] local_bb1_mul22_2_2_add992;

assign local_bb1_mul22_2_2_add992 = (local_bb1_mul22_2_2_masked + local_bb1_var__u80);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_2_add1432_stall_local;
wire [31:0] local_bb1_mul24_2_2_add1432;

assign local_bb1_mul24_2_2_add1432 = (local_bb1_shr19_2_2 + local_bb1_var__u81);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_shr27_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_shr27_2_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_2_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_shr27_2_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_2_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_2_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_2_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_shr27_2_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_shr27_2_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_shr27_2_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_shr27_2_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_shr27_2_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb1_shr27_2_0_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb1_shr27_2_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_shr27_2_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_shr27_2_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_shr27_2_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_shr27_2_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_shr27_2_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_shr27_2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_shr27_2_0_NO_SHIFT_REG = rnode_173to174_bb1_shr27_2_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_shr27_2_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_shr27_2_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push8__coalesced_pop2_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__push8__coalesced_pop2_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__push8__coalesced_pop2_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__push8__coalesced_pop2_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_175to179_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_175to179_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push8__coalesced_pop2_0_NO_SHIFT_REG = rnode_179to180_bb1__push8__coalesced_pop2_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__push8__coalesced_pop2_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push8__coalesced_pop2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_16_stall_local;
wire [31:0] local_bb1_reduction_16;

assign local_bb1_reduction_16 = (local_bb1_mul21_252_add682 + 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_254_add1364_stall_local;
wire [31:0] local_bb1_mul24_254_add1364;

assign local_bb1_mul24_254_add1364 = (local_bb1_mul24_254_add1308 + local_bb1_var__u72);

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_138_valid_out;
wire local_bb1_shr27_138_stall_in;
wire local_bb1_shr27_138_inputs_ready;
wire local_bb1_shr27_138_stall_local;
wire [31:0] local_bb1_shr27_138;

assign local_bb1_shr27_138_inputs_ready = (rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG & rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG & rnode_171to172_bb1_mul24_134_add1184_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG & rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG);
assign local_bb1_shr27_138 = (local_bb1_reduction_11 >> 32'h8);
assign local_bb1_shr27_138_valid_out = 1'b1;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_mul24_134_add1184_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_rows_969_0_coalesced_pop3_acl_pop_i32_0_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_shr27_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_shr27_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_shr27_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_shr27_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_shr27_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_shr27_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_shr27_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_shr27_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_shr27_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb1_shr27_0_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb1_shr27_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_shr27_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_shr27_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_shr27_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_shr27_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_shr27_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_shr27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_shr27_0_NO_SHIFT_REG = rnode_173to174_bb1_shr27_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_shr27_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_shr27_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_971_0_pop4_acl_pop_i32_0_valid_out_0;
wire local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_in_0;
 reg local_bb1_rows_971_0_pop4_acl_pop_i32_0_consumed_0_NO_SHIFT_REG;
wire local_bb1_mul21_2_1_add558_valid_out;
wire local_bb1_mul21_2_1_add558_stall_in;
 reg local_bb1_mul21_2_1_add558_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_12_valid_out;
wire local_bb1_reduction_12_stall_in;
 reg local_bb1_reduction_12_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_12_inputs_ready;
wire local_bb1_reduction_12_stall_local;
wire [31:0] local_bb1_reduction_12;

assign local_bb1_reduction_12_inputs_ready = rnode_171to172_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_reduction_12 = (local_bb1_mul24_2_1_add1302 + local_bb1_mul22_2_1_add620);
assign local_bb1_rows_971_0_pop4_acl_pop_i32_0_valid_out_0 = 1'b1;
assign local_bb1_mul21_2_1_add558_valid_out = 1'b1;
assign local_bb1_reduction_12_valid_out = 1'b1;
assign rnode_171to172_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_971_0_pop4_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul21_2_1_add558_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_12_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_971_0_pop4_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_12_inputs_ready & (local_bb1_rows_971_0_pop4_acl_pop_i32_0_consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_in_0)) & local_bb1_reduction_12_stall_local);
		local_bb1_mul21_2_1_add558_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_12_inputs_ready & (local_bb1_mul21_2_1_add558_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_2_1_add558_stall_in)) & local_bb1_reduction_12_stall_local);
		local_bb1_reduction_12_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_12_inputs_ready & (local_bb1_reduction_12_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_12_stall_in)) & local_bb1_reduction_12_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_mul24_1_2_add1426_stall_local;
wire [31:0] local_bb1_mul24_1_2_add1426;

assign local_bb1_mul24_1_2_add1426 = (local_bb1_mul24_1_2_add1370 + local_bb1_var__u77);

// This section implements an unregistered operation.
// 
wire local_bb1_mul24_2_2_add1488_stall_local;
wire [31:0] local_bb1_mul24_2_2_add1488;

assign local_bb1_mul24_2_2_add1488 = (local_bb1_mul24_2_2_add1432 + local_bb1_var__u82);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1_shr27_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_shr27_2_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_shr27_2_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_shr27_2_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_2_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1_shr27_2_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1_shr27_2_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1_shr27_2_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1_shr27_2_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1_shr27_2_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb1_shr27_2_0_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb1_shr27_2_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1_shr27_2_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1_shr27_2_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1_shr27_2_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1_shr27_2_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1_shr27_2_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_shr27_2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_shr27_2_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_shr27_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1_shr27_2_0_NO_SHIFT_REG = rnode_174to175_bb1_shr27_2_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1_shr27_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1_shr27_2_1_NO_SHIFT_REG = rnode_174to175_bb1_shr27_2_0_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_15_stall_local;
wire [31:0] local_bb1_reduction_15;

assign local_bb1_reduction_15 = (local_bb1_mul24_254_add1364 + local_bb1_mul22_253_add744);

// This section implements a registered operation.
// 
wire local_bb1_var__u84_inputs_ready;
 reg local_bb1_var__u84_valid_out_NO_SHIFT_REG;
wire local_bb1_var__u84_stall_in;
wire local_bb1_var__u84_output_regs_ready;
wire [31:0] local_bb1_var__u84;
 reg local_bb1_var__u84_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_var__u84_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_var__u84_causedstall;

acl_int_mult int_module_local_bb1_var__u84 (
	.clock(clock),
	.dataa(local_bb1_shr27_138),
	.datab(32'hFFFFFFFE),
	.enable(local_bb1_var__u84_output_regs_ready),
	.result(local_bb1_var__u84)
);

defparam int_module_local_bb1_var__u84.INPUT1_WIDTH = 10;
defparam int_module_local_bb1_var__u84.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_var__u84.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_var__u84.LATENCY = 3;
defparam int_module_local_bb1_var__u84.SIGNED = 0;

assign local_bb1_var__u84_inputs_ready = 1'b1;
assign local_bb1_var__u84_output_regs_ready = 1'b1;
assign local_bb1_shr27_138_stall_in = 1'b0;
assign local_bb1_var__u84_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_var__u84_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u84_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_var__u84_output_regs_ready)
		begin
			local_bb1_var__u84_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_var__u84_valid_pipe_1_NO_SHIFT_REG <= local_bb1_var__u84_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_var__u84_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_var__u84_output_regs_ready)
		begin
			local_bb1_var__u84_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_var__u84_stall_in))
			begin
				local_bb1_var__u84_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1_shr27_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_shr27_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_shr27_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_shr27_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1_shr27_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1_shr27_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1_shr27_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1_shr27_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1_shr27_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb1_shr27_0_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb1_shr27_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1_shr27_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1_shr27_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1_shr27_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1_shr27_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1_shr27_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_shr27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_shr27_0_NO_SHIFT_REG = rnode_174to175_bb1_shr27_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1_shr27_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_shr27_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1__coalesced_push2_rows_971_0_pop4_inputs_ready;
 reg local_bb1__coalesced_push2_rows_971_0_pop4_valid_out_NO_SHIFT_REG;
wire local_bb1__coalesced_push2_rows_971_0_pop4_stall_in;
wire local_bb1__coalesced_push2_rows_971_0_pop4_output_regs_ready;
wire [31:0] local_bb1__coalesced_push2_rows_971_0_pop4_result;
wire local_bb1__coalesced_push2_rows_971_0_pop4_fu_valid_out;
wire local_bb1__coalesced_push2_rows_971_0_pop4_fu_stall_out;
 reg [31:0] local_bb1__coalesced_push2_rows_971_0_pop4_NO_SHIFT_REG;
wire local_bb1__coalesced_push2_rows_971_0_pop4_causedstall;

acl_push local_bb1__coalesced_push2_rows_971_0_pop4_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb1_rows_971_0_pop4_acl_pop_i32_0),
	.stall_out(local_bb1__coalesced_push2_rows_971_0_pop4_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1__coalesced_push2_rows_971_0_pop4_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__coalesced_push2_rows_971_0_pop4_result),
	.feedback_out(feedback_data_out_2),
	.feedback_valid_out(feedback_valid_out_2),
	.feedback_stall_in(feedback_stall_in_2)
);

defparam local_bb1__coalesced_push2_rows_971_0_pop4_feedback.STALLFREE = 1;
defparam local_bb1__coalesced_push2_rows_971_0_pop4_feedback.DATA_WIDTH = 32;
defparam local_bb1__coalesced_push2_rows_971_0_pop4_feedback.FIFO_DEPTH = 968;
defparam local_bb1__coalesced_push2_rows_971_0_pop4_feedback.MIN_FIFO_LATENCY = 968;
defparam local_bb1__coalesced_push2_rows_971_0_pop4_feedback.STYLE = "REGULAR";

assign local_bb1__coalesced_push2_rows_971_0_pop4_inputs_ready = 1'b1;
assign local_bb1__coalesced_push2_rows_971_0_pop4_output_regs_ready = 1'b1;
assign local_bb1_rows_971_0_pop4_acl_pop_i32_0_stall_in_0 = 1'b0;
assign local_bb1__coalesced_push2_rows_971_0_pop4_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__coalesced_push2_rows_971_0_pop4_NO_SHIFT_REG <= 'x;
		local_bb1__coalesced_push2_rows_971_0_pop4_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__coalesced_push2_rows_971_0_pop4_output_regs_ready)
		begin
			local_bb1__coalesced_push2_rows_971_0_pop4_NO_SHIFT_REG <= local_bb1__coalesced_push2_rows_971_0_pop4_result;
			local_bb1__coalesced_push2_rows_971_0_pop4_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__coalesced_push2_rows_971_0_pop4_stall_in))
			begin
				local_bb1__coalesced_push2_rows_971_0_pop4_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_mul21_2_1_add558_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_mul21_2_1_add558_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_mul21_2_1_add558_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_mul21_2_1_add558_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_mul21_2_1_add558_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_mul21_2_1_add558_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_mul21_2_1_add558_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_mul21_2_1_add558_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_mul21_2_1_add558_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_2_1_add558),
	.data_out(rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_2_1_add558_stall_in = 1'b0;
assign rnode_172to173_bb1_mul21_2_1_add558_0_NO_SHIFT_REG = rnode_172to173_bb1_mul21_2_1_add558_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_mul21_2_1_add558_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_mul21_2_1_add558_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_reduction_12_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_reduction_12_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_reduction_12_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_reduction_12_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_reduction_12_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_reduction_12_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_reduction_12_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_reduction_12_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_reduction_12_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_reduction_12_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_reduction_12_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_reduction_12_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_reduction_12_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_12),
	.data_out(rnode_172to173_bb1_reduction_12_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_reduction_12_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_reduction_12_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_reduction_12_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_reduction_12_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_reduction_12_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_12_stall_in = 1'b0;
assign rnode_172to173_bb1_reduction_12_0_NO_SHIFT_REG = rnode_172to173_bb1_reduction_12_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_reduction_12_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_reduction_12_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__pop8_acl_pop_i32_0_valid_out_0;
wire local_bb1__pop8_acl_pop_i32_0_stall_in_0;
 reg local_bb1__pop8_acl_pop_i32_0_consumed_0_NO_SHIFT_REG;
wire local_bb1_mul21_1_2_add806_valid_out;
wire local_bb1_mul21_1_2_add806_stall_in;
 reg local_bb1_mul21_1_2_add806_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_18_valid_out;
wire local_bb1_reduction_18_stall_in;
 reg local_bb1_reduction_18_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_18_inputs_ready;
wire local_bb1_reduction_18_stall_local;
wire [31:0] local_bb1_reduction_18;

assign local_bb1_reduction_18_inputs_ready = rnode_172to173_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_reduction_18 = (local_bb1_mul24_1_2_add1426 + local_bb1_mul22_1_2_add868);
assign local_bb1__pop8_acl_pop_i32_0_valid_out_0 = 1'b1;
assign local_bb1_mul21_1_2_add806_valid_out = 1'b1;
assign local_bb1_reduction_18_valid_out = 1'b1;
assign rnode_172to173_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop8_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul21_1_2_add806_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_18_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop8_acl_pop_i32_0_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_18_inputs_ready & (local_bb1__pop8_acl_pop_i32_0_consumed_0_NO_SHIFT_REG | ~(local_bb1__pop8_acl_pop_i32_0_stall_in_0)) & local_bb1_reduction_18_stall_local);
		local_bb1_mul21_1_2_add806_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_18_inputs_ready & (local_bb1_mul21_1_2_add806_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_1_2_add806_stall_in)) & local_bb1_reduction_18_stall_local);
		local_bb1_reduction_18_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_18_inputs_ready & (local_bb1_reduction_18_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_18_stall_in)) & local_bb1_reduction_18_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_mul21_2_2_add930_valid_out;
wire local_bb1_mul21_2_2_add930_stall_in;
 reg local_bb1_mul21_2_2_add930_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_21_valid_out;
wire local_bb1_reduction_21_stall_in;
 reg local_bb1_reduction_21_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_21_inputs_ready;
wire local_bb1_reduction_21_stall_local;
wire [31:0] local_bb1_reduction_21;

assign local_bb1_reduction_21_inputs_ready = rnode_172to173_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_reduction_21 = (local_bb1_mul24_2_2_add1488 + local_bb1_mul22_2_2_add992);
assign local_bb1_mul21_2_2_add930_valid_out = 1'b1;
assign local_bb1_reduction_21_valid_out = 1'b1;
assign rnode_172to173_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul21_2_2_add930_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_21_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_mul21_2_2_add930_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_21_inputs_ready & (local_bb1_mul21_2_2_add930_consumed_0_NO_SHIFT_REG | ~(local_bb1_mul21_2_2_add930_stall_in)) & local_bb1_reduction_21_stall_local);
		local_bb1_reduction_21_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_21_inputs_ready & (local_bb1_reduction_21_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_21_stall_in)) & local_bb1_reduction_21_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_mul33_2_stall_local;
wire [31:0] local_bb1_mul33_2;

assign local_bb1_mul33_2 = (32'hFFFFFFF0 - rnode_174to175_bb1_shr27_2_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_17_stall_local;
wire [31:0] local_bb1_reduction_17;

assign local_bb1_reduction_17 = (local_bb1_reduction_15 + local_bb1_reduction_16);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_35_valid_out;
wire local_bb1_reduction_35_stall_in;
wire local_bb1_reduction_35_inputs_ready;
wire local_bb1_reduction_35_stall_local;
wire [31:0] local_bb1_reduction_35;

assign local_bb1_reduction_35_inputs_ready = (local_bb1_var__u84_valid_out_NO_SHIFT_REG & rnode_174to175_bb1_shr27_2_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_reduction_35 = (local_bb1_var__u84 + rnode_174to175_bb1_shr27_2_1_NO_SHIFT_REG);
assign local_bb1_reduction_35_valid_out = 1'b1;
assign local_bb1_var__u84_stall_in = 1'b0;
assign rnode_174to175_bb1_shr27_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_mul33_stall_local;
wire [31:0] local_bb1_mul33;

assign local_bb1_mul33 = (32'hFFFFFFF0 - rnode_174to175_bb1_shr27_0_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1__coalesced_push2_rows_971_0_pop4_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__coalesced_push2_rows_971_0_pop4_stall_in = 1'b0;
assign rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG = rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_13_stall_local;
wire [31:0] local_bb1_reduction_13;

assign local_bb1_reduction_13 = (rnode_172to173_bb1_mul21_2_1_add558_0_NO_SHIFT_REG + 32'h80);

// This section implements a registered operation.
// 
wire local_bb1__push9__pop8_inputs_ready;
 reg local_bb1__push9__pop8_valid_out_NO_SHIFT_REG;
wire local_bb1__push9__pop8_stall_in;
wire local_bb1__push9__pop8_output_regs_ready;
wire [31:0] local_bb1__push9__pop8_result;
wire local_bb1__push9__pop8_fu_valid_out;
wire local_bb1__push9__pop8_fu_stall_out;
 reg [31:0] local_bb1__push9__pop8_NO_SHIFT_REG;
wire local_bb1__push9__pop8_causedstall;

acl_push local_bb1__push9__pop8_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_172to173_bb1_c0_ene3_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop8_acl_pop_i32_0),
	.stall_out(local_bb1__push9__pop8_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1__push9__pop8_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push9__pop8_result),
	.feedback_out(feedback_data_out_9),
	.feedback_valid_out(feedback_valid_out_9),
	.feedback_stall_in(feedback_stall_in_9)
);

defparam local_bb1__push9__pop8_feedback.STALLFREE = 1;
defparam local_bb1__push9__pop8_feedback.DATA_WIDTH = 32;
defparam local_bb1__push9__pop8_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push9__pop8_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push9__pop8_feedback.STYLE = "REGULAR";

assign local_bb1__push9__pop8_inputs_ready = 1'b1;
assign local_bb1__push9__pop8_output_regs_ready = 1'b1;
assign local_bb1__pop8_acl_pop_i32_0_stall_in_0 = 1'b0;
assign rnode_172to173_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1__push9__pop8_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push9__pop8_NO_SHIFT_REG <= 'x;
		local_bb1__push9__pop8_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push9__pop8_output_regs_ready)
		begin
			local_bb1__push9__pop8_NO_SHIFT_REG <= local_bb1__push9__pop8_result;
			local_bb1__push9__pop8_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push9__pop8_stall_in))
			begin
				local_bb1__push9__pop8_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_mul21_1_2_add806_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_1_2_add806_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_mul21_1_2_add806_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_1_2_add806_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_1_2_add806_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_1_2_add806_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_mul21_1_2_add806_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_mul21_1_2_add806_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_mul21_1_2_add806_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_1_2_add806),
	.data_out(rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_1_2_add806_stall_in = 1'b0;
assign rnode_173to174_bb1_mul21_1_2_add806_0_NO_SHIFT_REG = rnode_173to174_bb1_mul21_1_2_add806_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_mul21_1_2_add806_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_mul21_1_2_add806_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_reduction_18_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_18_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_18_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_18_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_18_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_18_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_18_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_18_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_reduction_18_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_reduction_18_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_reduction_18_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_reduction_18_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_reduction_18_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_18),
	.data_out(rnode_173to174_bb1_reduction_18_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_reduction_18_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_reduction_18_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_reduction_18_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_reduction_18_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_reduction_18_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_18_stall_in = 1'b0;
assign rnode_173to174_bb1_reduction_18_0_NO_SHIFT_REG = rnode_173to174_bb1_reduction_18_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_reduction_18_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_18_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_mul21_2_2_add930_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_2_2_add930_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_mul21_2_2_add930_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_2_2_add930_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_2_2_add930_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_mul21_2_2_add930_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_mul21_2_2_add930_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_mul21_2_2_add930_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_mul21_2_2_add930_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_mul21_2_2_add930),
	.data_out(rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul21_2_2_add930_stall_in = 1'b0;
assign rnode_173to174_bb1_mul21_2_2_add930_0_NO_SHIFT_REG = rnode_173to174_bb1_mul21_2_2_add930_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_mul21_2_2_add930_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_mul21_2_2_add930_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_reduction_21_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_21_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_21_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_21_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_21_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_21_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_21_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_21_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_reduction_21_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_reduction_21_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_reduction_21_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_reduction_21_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_reduction_21_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_21),
	.data_out(rnode_173to174_bb1_reduction_21_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_reduction_21_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_reduction_21_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_reduction_21_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_reduction_21_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_reduction_21_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_21_stall_in = 1'b0;
assign rnode_173to174_bb1_reduction_21_0_NO_SHIFT_REG = rnode_173to174_bb1_reduction_21_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_reduction_21_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_21_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_258_valid_out;
wire local_bb1_shr27_258_stall_in;
wire local_bb1_shr27_258_inputs_ready;
wire local_bb1_shr27_258_stall_local;
wire [31:0] local_bb1_shr27_258;

assign local_bb1_shr27_258_inputs_ready = (rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_5_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_6_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_7_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_3_NO_SHIFT_REG & rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_valid_out_4_NO_SHIFT_REG);
assign local_bb1_shr27_258 = (local_bb1_reduction_17 >> 32'h8);
assign local_bb1_shr27_258_valid_out = 1'b1;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__coalesced_pop2_acl_pop_i32_0_0_stall_in_4_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_reduction_35_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_35_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_35_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_35_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_35_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_35_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_35_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_35_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_reduction_35_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_reduction_35_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_reduction_35_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_reduction_35_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_reduction_35_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_35),
	.data_out(rnode_175to176_bb1_reduction_35_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_reduction_35_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_reduction_35_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_reduction_35_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_reduction_35_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_reduction_35_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_35_stall_in = 1'b0;
assign rnode_175to176_bb1_reduction_35_0_NO_SHIFT_REG = rnode_175to176_bb1_reduction_35_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_reduction_35_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_35_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_25_stall_local;
wire [31:0] local_bb1_reduction_25;

assign local_bb1_reduction_25 = (local_bb1_mul33_2 + local_bb1_mul33);

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG;
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG),
	.data_out(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_fifo.DEPTH = 5;
defparam rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG = rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_reg_179_NO_SHIFT_REG;
assign rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_14_stall_local;
wire [31:0] local_bb1_reduction_14;

assign local_bb1_reduction_14 = (rnode_172to173_bb1_reduction_12_0_NO_SHIFT_REG + local_bb1_reduction_13);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__push9__pop8_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push9__pop8_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__push9__pop8_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push9__pop8_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push9__pop8_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__push9__pop8_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1__push9__pop8_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1__push9__pop8_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1__push9__pop8_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1__push9__pop8_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1__push9__pop8_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1__push9__pop8_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb1__push9__pop8_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1__push9__pop8_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1__push9__pop8_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1__push9__pop8_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1__push9__pop8_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1__push9__pop8_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push9__pop8_stall_in = 1'b0;
assign rnode_174to175_bb1__push9__pop8_0_NO_SHIFT_REG = rnode_174to175_bb1__push9__pop8_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1__push9__pop8_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_19_stall_local;
wire [31:0] local_bb1_reduction_19;

assign local_bb1_reduction_19 = (rnode_173to174_bb1_mul21_1_2_add806_0_NO_SHIFT_REG + 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_22_stall_local;
wire [31:0] local_bb1_reduction_22;

assign local_bb1_reduction_22 = (rnode_173to174_bb1_mul21_2_2_add930_0_NO_SHIFT_REG + 32'h80);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_173to175_bb1_shr27_258_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_173to175_bb1_shr27_258_0_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_173to175_bb1_shr27_258_1_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to175_bb1_shr27_258_0_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb1_shr27_258_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_173to175_bb1_shr27_258_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to175_bb1_shr27_258_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to175_bb1_shr27_258_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_173to175_bb1_shr27_258_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_173to175_bb1_shr27_258_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1_shr27_258),
	.data_out(rnode_173to175_bb1_shr27_258_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_173to175_bb1_shr27_258_0_reg_175_fifo.DEPTH = 2;
defparam rnode_173to175_bb1_shr27_258_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_173to175_bb1_shr27_258_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to175_bb1_shr27_258_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_173to175_bb1_shr27_258_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr27_258_stall_in = 1'b0;
assign rnode_173to175_bb1_shr27_258_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_173to175_bb1_shr27_258_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_173to175_bb1_shr27_258_0_NO_SHIFT_REG = rnode_173to175_bb1_shr27_258_0_reg_175_NO_SHIFT_REG;
assign rnode_173to175_bb1_shr27_258_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_173to175_bb1_shr27_258_1_NO_SHIFT_REG = rnode_173to175_bb1_shr27_258_0_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_38_stall_local;
wire [31:0] local_bb1_reduction_38;

assign local_bb1_reduction_38 = (rnode_175to176_bb1_reduction_35_0_NO_SHIFT_REG + 32'h10);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to179_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_NO_SHIFT_REG = rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u85_valid_out;
wire local_bb1_var__u85_stall_in;
wire local_bb1_var__u85_inputs_ready;
wire local_bb1_var__u85_stall_local;
wire [31:0] local_bb1_var__u85;

assign local_bb1_var__u85_inputs_ready = (rnode_172to173_bb1_mul21_2_1_add558_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_reduction_12_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u85 = (local_bb1_reduction_14 >> 32'h7);
assign local_bb1_var__u85_valid_out = 1'b1;
assign rnode_172to173_bb1_mul21_2_1_add558_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_reduction_12_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_175to179_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to179_bb1__push9__pop8_0_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push9__pop8_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to179_bb1__push9__pop8_0_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push9__pop8_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push9__pop8_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_175to179_bb1__push9__pop8_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_175to179_bb1__push9__pop8_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to179_bb1__push9__pop8_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to179_bb1__push9__pop8_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_175to179_bb1__push9__pop8_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_175to179_bb1__push9__pop8_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_174to175_bb1__push9__pop8_0_NO_SHIFT_REG),
	.data_out(rnode_175to179_bb1__push9__pop8_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_175to179_bb1__push9__pop8_0_reg_179_fifo.DEPTH = 4;
defparam rnode_175to179_bb1__push9__pop8_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_175to179_bb1__push9__pop8_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to179_bb1__push9__pop8_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_175to179_bb1__push9__pop8_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to179_bb1__push9__pop8_0_NO_SHIFT_REG = rnode_175to179_bb1__push9__pop8_0_reg_179_NO_SHIFT_REG;
assign rnode_175to179_bb1__push9__pop8_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_175to179_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_20_stall_local;
wire [31:0] local_bb1_reduction_20;

assign local_bb1_reduction_20 = (rnode_173to174_bb1_reduction_18_0_NO_SHIFT_REG + local_bb1_reduction_19);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_23_stall_local;
wire [31:0] local_bb1_reduction_23;

assign local_bb1_reduction_23 = (rnode_173to174_bb1_reduction_21_0_NO_SHIFT_REG + local_bb1_reduction_22);

// This section implements an unregistered operation.
// 
wire local_bb1_mul39_264_stall_local;
wire [31:0] local_bb1_mul39_264;

assign local_bb1_mul39_264 = (32'hFFFFFFF0 - rnode_173to175_bb1_shr27_258_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_27_valid_out;
wire local_bb1_reduction_27_stall_in;
wire local_bb1_reduction_27_inputs_ready;
wire local_bb1_reduction_27_stall_local;
wire [31:0] local_bb1_reduction_27;

assign local_bb1_reduction_27_inputs_ready = (local_bb1_var__u83_valid_out_NO_SHIFT_REG & rnode_173to175_bb1_shr27_258_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_reduction_27 = (rnode_173to175_bb1_shr27_258_1_NO_SHIFT_REG + local_bb1_var__u83);
assign local_bb1_reduction_27_valid_out = 1'b1;
assign local_bb1_var__u83_stall_in = 1'b0;
assign rnode_173to175_bb1_shr27_258_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_var__u85_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u85_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u85_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u85_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u85_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u85_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u85_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u85_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_var__u85_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_var__u85_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_var__u85_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_var__u85_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_var__u85_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_var__u85),
	.data_out(rnode_173to174_bb1_var__u85_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_var__u85_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_var__u85_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_var__u85_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_var__u85_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_var__u85_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u85_stall_in = 1'b0;
assign rnode_173to174_bb1_var__u85_0_NO_SHIFT_REG = rnode_173to174_bb1_var__u85_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u85_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u85_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__push9__pop8_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push9__pop8_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__push9__pop8_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push9__pop8_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push9__pop8_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__push9__pop8_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__push9__pop8_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__push9__pop8_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__push9__pop8_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__push9__pop8_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__push9__pop8_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_175to179_bb1__push9__pop8_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1__push9__pop8_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__push9__pop8_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__push9__pop8_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1__push9__pop8_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__push9__pop8_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__push9__pop8_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_175to179_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push9__pop8_0_NO_SHIFT_REG = rnode_179to180_bb1__push9__pop8_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__push9__pop8_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push9__pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u86_stall_local;
wire [31:0] local_bb1_var__u86;

assign local_bb1_var__u86 = (local_bb1_reduction_20 >> 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_shr27_2_2_stall_local;
wire [31:0] local_bb1_shr27_2_2;

assign local_bb1_shr27_2_2 = (local_bb1_reduction_23 >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_33_stall_local;
wire [31:0] local_bb1_reduction_33;

assign local_bb1_reduction_33 = (local_bb1_mul39_264 + local_bb1_mul33);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_reduction_27_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_27_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_27_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_27_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_27_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_27_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_27_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_27_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_reduction_27_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_reduction_27_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_reduction_27_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_reduction_27_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_reduction_27_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_27),
	.data_out(rnode_175to176_bb1_reduction_27_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_reduction_27_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_reduction_27_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_reduction_27_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_reduction_27_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_reduction_27_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_27_stall_in = 1'b0;
assign rnode_175to176_bb1_reduction_27_0_NO_SHIFT_REG = rnode_175to176_bb1_reduction_27_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_reduction_27_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_27_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_add28_2_1_stall_local;
wire [31:0] local_bb1_add28_2_1;

assign local_bb1_add28_2_1 = (rnode_173to174_bb1_var__u85_0_NO_SHIFT_REG & 32'h1FFFFFE);

// This section implements an unregistered operation.
// 
wire local_bb1_add28_1_2_stall_local;
wire [31:0] local_bb1_add28_1_2;

assign local_bb1_add28_1_2 = (local_bb1_var__u86 & 32'h1FFFFFE);

// This section implements an unregistered operation.
// 
wire local_bb1_add28_2_2_stall_local;
wire [31:0] local_bb1_add28_2_2;

assign local_bb1_add28_2_2 = (local_bb1_shr27_2_2 + 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_30_stall_local;
wire [31:0] local_bb1_reduction_30;

assign local_bb1_reduction_30 = (rnode_175to176_bb1_reduction_27_0_NO_SHIFT_REG + 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_26_stall_local;
wire [31:0] local_bb1_reduction_26;

assign local_bb1_reduction_26 = (local_bb1_add28_2_2 + local_bb1_add28_1_2);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_26_valid_out;
wire local_bb1_reduction_26_stall_in;
 reg local_bb1_reduction_26_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_34_valid_out;
wire local_bb1_reduction_34_stall_in;
 reg local_bb1_reduction_34_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_34_inputs_ready;
wire local_bb1_reduction_34_stall_local;
wire [31:0] local_bb1_reduction_34;

assign local_bb1_reduction_34_inputs_ready = (rnode_173to174_bb1_mul21_1_2_add806_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_reduction_18_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_mul21_2_2_add930_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_reduction_21_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_var__u85_0_valid_out_NO_SHIFT_REG);
assign local_bb1_reduction_34 = (local_bb1_add28_2_2 + local_bb1_add28_2_1);
assign local_bb1_reduction_26_valid_out = 1'b1;
assign local_bb1_reduction_34_valid_out = 1'b1;
assign rnode_173to174_bb1_mul21_1_2_add806_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_18_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_mul21_2_2_add930_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_21_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u85_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_reduction_26_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_34_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_reduction_26_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_34_inputs_ready & (local_bb1_reduction_26_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_26_stall_in)) & local_bb1_reduction_34_stall_local);
		local_bb1_reduction_34_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_34_inputs_ready & (local_bb1_reduction_34_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_34_stall_in)) & local_bb1_reduction_34_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1_reduction_26_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_26_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_reduction_26_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_26_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_reduction_26_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_26_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_26_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_26_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1_reduction_26_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1_reduction_26_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1_reduction_26_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1_reduction_26_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1_reduction_26_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_26),
	.data_out(rnode_174to175_bb1_reduction_26_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1_reduction_26_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1_reduction_26_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1_reduction_26_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1_reduction_26_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1_reduction_26_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_26_stall_in = 1'b0;
assign rnode_174to175_bb1_reduction_26_0_NO_SHIFT_REG = rnode_174to175_bb1_reduction_26_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1_reduction_26_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_reduction_26_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1_reduction_34_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_34_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_reduction_34_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_34_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1_reduction_34_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_34_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_34_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1_reduction_34_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1_reduction_34_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1_reduction_34_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1_reduction_34_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1_reduction_34_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1_reduction_34_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_34),
	.data_out(rnode_174to175_bb1_reduction_34_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1_reduction_34_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1_reduction_34_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1_reduction_34_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1_reduction_34_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1_reduction_34_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_34_stall_in = 1'b0;
assign rnode_174to175_bb1_reduction_34_0_NO_SHIFT_REG = rnode_174to175_bb1_reduction_34_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1_reduction_34_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_reduction_34_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_29_stall_local;
wire [31:0] local_bb1_reduction_29;

assign local_bb1_reduction_29 = (local_bb1_reduction_25 + rnode_174to175_bb1_reduction_26_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_29_valid_out;
wire local_bb1_reduction_29_stall_in;
 reg local_bb1_reduction_29_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_37_valid_out;
wire local_bb1_reduction_37_stall_in;
 reg local_bb1_reduction_37_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_37_inputs_ready;
wire local_bb1_reduction_37_stall_local;
wire [31:0] local_bb1_reduction_37;

assign local_bb1_reduction_37_inputs_ready = (rnode_174to175_bb1_shr27_2_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb1_shr27_0_valid_out_NO_SHIFT_REG & rnode_173to175_bb1_shr27_258_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb1_reduction_26_0_valid_out_NO_SHIFT_REG & rnode_174to175_bb1_reduction_34_0_valid_out_NO_SHIFT_REG);
assign local_bb1_reduction_37 = (local_bb1_reduction_33 + rnode_174to175_bb1_reduction_34_0_NO_SHIFT_REG);
assign local_bb1_reduction_29_valid_out = 1'b1;
assign local_bb1_reduction_37_valid_out = 1'b1;
assign rnode_174to175_bb1_shr27_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_shr27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to175_bb1_shr27_258_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_reduction_26_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1_reduction_34_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_reduction_29_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_37_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_reduction_29_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_37_inputs_ready & (local_bb1_reduction_29_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_29_stall_in)) & local_bb1_reduction_37_stall_local);
		local_bb1_reduction_37_consumed_0_NO_SHIFT_REG <= (local_bb1_reduction_37_inputs_ready & (local_bb1_reduction_37_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_37_stall_in)) & local_bb1_reduction_37_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_reduction_29_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_29_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_29_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_29_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_29_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_29_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_29_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_29_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_reduction_29_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_reduction_29_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_reduction_29_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_reduction_29_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_reduction_29_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_29),
	.data_out(rnode_175to176_bb1_reduction_29_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_reduction_29_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_reduction_29_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_reduction_29_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_reduction_29_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_reduction_29_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_29_stall_in = 1'b0;
assign rnode_175to176_bb1_reduction_29_0_NO_SHIFT_REG = rnode_175to176_bb1_reduction_29_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_reduction_29_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_reduction_37_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_37_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_37_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_37_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_reduction_37_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_37_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_37_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_reduction_37_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_reduction_37_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_reduction_37_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_reduction_37_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_reduction_37_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_reduction_37_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_37),
	.data_out(rnode_175to176_bb1_reduction_37_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_reduction_37_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_reduction_37_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_reduction_37_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_reduction_37_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_reduction_37_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_37_stall_in = 1'b0;
assign rnode_175to176_bb1_reduction_37_0_NO_SHIFT_REG = rnode_175to176_bb1_reduction_37_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_reduction_37_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_37_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_31_valid_out;
wire local_bb1_reduction_31_stall_in;
wire local_bb1_reduction_31_inputs_ready;
wire local_bb1_reduction_31_stall_local;
wire [31:0] local_bb1_reduction_31;

assign local_bb1_reduction_31_inputs_ready = (rnode_175to176_bb1_reduction_27_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb1_reduction_29_0_valid_out_NO_SHIFT_REG);
assign local_bb1_reduction_31 = (rnode_175to176_bb1_reduction_29_0_NO_SHIFT_REG + local_bb1_reduction_30);
assign local_bb1_reduction_31_valid_out = 1'b1;
assign rnode_175to176_bb1_reduction_27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_29_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_39_valid_out;
wire local_bb1_reduction_39_stall_in;
wire local_bb1_reduction_39_inputs_ready;
wire local_bb1_reduction_39_stall_local;
wire [31:0] local_bb1_reduction_39;

assign local_bb1_reduction_39_inputs_ready = (rnode_175to176_bb1_reduction_35_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb1_reduction_37_0_valid_out_NO_SHIFT_REG);
assign local_bb1_reduction_39 = (rnode_175to176_bb1_reduction_37_0_NO_SHIFT_REG + local_bb1_reduction_38);
assign local_bb1_reduction_39_valid_out = 1'b1;
assign rnode_175to176_bb1_reduction_35_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_reduction_37_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_reduction_31_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_31_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_31_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_31_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_31_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_valid_out_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_stall_in_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_31_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_reduction_31_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_reduction_31_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_reduction_31_0_stall_in_0_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_reduction_31_0_valid_out_0_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_reduction_31_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_31),
	.data_out(rnode_176to177_bb1_reduction_31_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_reduction_31_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_reduction_31_0_reg_177_fifo.DATA_WIDTH = 32;
defparam rnode_176to177_bb1_reduction_31_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_reduction_31_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_reduction_31_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_31_stall_in = 1'b0;
assign rnode_176to177_bb1_reduction_31_0_stall_in_0_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_31_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_31_0_NO_SHIFT_REG = rnode_176to177_bb1_reduction_31_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_reduction_31_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_31_1_NO_SHIFT_REG = rnode_176to177_bb1_reduction_31_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_reduction_31_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_31_2_NO_SHIFT_REG = rnode_176to177_bb1_reduction_31_0_reg_177_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_reduction_39_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_39_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_39_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_39_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_reduction_39_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_valid_out_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_stall_in_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_reduction_39_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_reduction_39_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_reduction_39_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_reduction_39_0_stall_in_0_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_reduction_39_0_valid_out_0_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_reduction_39_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_39),
	.data_out(rnode_176to177_bb1_reduction_39_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_reduction_39_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_reduction_39_0_reg_177_fifo.DATA_WIDTH = 32;
defparam rnode_176to177_bb1_reduction_39_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_reduction_39_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_reduction_39_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_39_stall_in = 1'b0;
assign rnode_176to177_bb1_reduction_39_0_stall_in_0_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_39_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_39_0_NO_SHIFT_REG = rnode_176to177_bb1_reduction_39_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_reduction_39_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_39_1_NO_SHIFT_REG = rnode_176to177_bb1_reduction_39_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_reduction_39_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_reduction_39_2_NO_SHIFT_REG = rnode_176to177_bb1_reduction_39_0_reg_177_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i_stall_local;
wire [31:0] local_bb1_sub_i;

assign local_bb1_sub_i = (32'h0 - rnode_176to177_bb1_reduction_31_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i_stall_local;
wire local_bb1_cmp_i;

assign local_bb1_cmp_i = ($signed(rnode_176to177_bb1_reduction_31_1_NO_SHIFT_REG) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i2_stall_local;
wire [31:0] local_bb1_sub_i2;

assign local_bb1_sub_i2 = (32'h0 - rnode_176to177_bb1_reduction_39_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i1_stall_local;
wire local_bb1_cmp_i1;

assign local_bb1_cmp_i1 = ($signed(rnode_176to177_bb1_reduction_39_1_NO_SHIFT_REG) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i_valid_out;
wire local_bb1_cond_i_stall_in;
wire local_bb1_cond_i_inputs_ready;
wire local_bb1_cond_i_stall_local;
wire [31:0] local_bb1_cond_i;

assign local_bb1_cond_i_inputs_ready = (rnode_176to177_bb1_reduction_31_0_valid_out_0_NO_SHIFT_REG & rnode_176to177_bb1_reduction_31_0_valid_out_2_NO_SHIFT_REG & rnode_176to177_bb1_reduction_31_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_cond_i = (local_bb1_cmp_i ? local_bb1_sub_i : rnode_176to177_bb1_reduction_31_2_NO_SHIFT_REG);
assign local_bb1_cond_i_valid_out = 1'b1;
assign rnode_176to177_bb1_reduction_31_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_31_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_31_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i3_valid_out;
wire local_bb1_cond_i3_stall_in;
wire local_bb1_cond_i3_inputs_ready;
wire local_bb1_cond_i3_stall_local;
wire [31:0] local_bb1_cond_i3;

assign local_bb1_cond_i3_inputs_ready = (rnode_176to177_bb1_reduction_39_0_valid_out_0_NO_SHIFT_REG & rnode_176to177_bb1_reduction_39_0_valid_out_2_NO_SHIFT_REG & rnode_176to177_bb1_reduction_39_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_cond_i3 = (local_bb1_cmp_i1 ? local_bb1_sub_i2 : rnode_176to177_bb1_reduction_39_2_NO_SHIFT_REG);
assign local_bb1_cond_i3_valid_out = 1'b1;
assign rnode_176to177_bb1_reduction_39_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_39_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_reduction_39_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_cond_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_cond_i_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_cond_i_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_cond_i_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_cond_i_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_cond_i_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_cond_i_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_cond_i_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_cond_i),
	.data_out(rnode_177to178_bb1_cond_i_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_cond_i_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_cond_i_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_cond_i_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_cond_i_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_cond_i_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cond_i_stall_in = 1'b0;
assign rnode_177to178_bb1_cond_i_0_NO_SHIFT_REG = rnode_177to178_bb1_cond_i_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_cond_i_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_cond_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_cond_i3_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_cond_i3_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i3_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_cond_i3_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i3_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i3_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_cond_i3_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_cond_i3_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_cond_i3_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_cond_i3_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_cond_i3_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_cond_i3_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_cond_i3),
	.data_out(rnode_177to178_bb1_cond_i3_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_cond_i3_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_cond_i3_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_cond_i3_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_cond_i3_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_cond_i3_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cond_i3_stall_in = 1'b0;
assign rnode_177to178_bb1_cond_i3_0_NO_SHIFT_REG = rnode_177to178_bb1_cond_i3_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_cond_i3_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_cond_i3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_add47_valid_out;
wire local_bb1_add47_stall_in;
wire local_bb1_add47_inputs_ready;
wire local_bb1_add47_stall_local;
wire [31:0] local_bb1_add47;

assign local_bb1_add47_inputs_ready = (rnode_177to178_bb1_cond_i3_0_valid_out_NO_SHIFT_REG & rnode_177to178_bb1_cond_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_add47 = (rnode_177to178_bb1_cond_i3_0_NO_SHIFT_REG + rnode_177to178_bb1_cond_i_0_NO_SHIFT_REG);
assign local_bb1_add47_valid_out = 1'b1;
assign rnode_177to178_bb1_cond_i3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_cond_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_add47_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add47_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add47_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add47_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add47_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add47_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add47_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add47_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_add47_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_add47_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_add47_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_add47_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_add47_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_add47),
	.data_out(rnode_178to179_bb1_add47_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_add47_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_add47_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_add47_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_add47_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_add47_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add47_stall_in = 1'b0;
assign rnode_178to179_bb1_add47_0_NO_SHIFT_REG = rnode_178to179_bb1_add47_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_add47_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add47_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp48_valid_out;
wire local_bb1_cmp48_stall_in;
wire local_bb1_cmp48_inputs_ready;
wire local_bb1_cmp48_stall_local;
wire local_bb1_cmp48;

assign local_bb1_cmp48_inputs_ready = rnode_178to179_bb1_add47_0_valid_out_NO_SHIFT_REG;
assign local_bb1_cmp48 = (rnode_178to179_bb1_add47_0_NO_SHIFT_REG > input_threshold);
assign local_bb1_cmp48_valid_out = 1'b1;
assign rnode_178to179_bb1_add47_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_cmp48_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp48_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_cmp48_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_cmp48_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_cmp48_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_cmp48_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_cmp48_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_cmp48),
	.data_out(rnode_179to180_bb1_cmp48_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_cmp48_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_cmp48_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_cmp48_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_cmp48_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_cmp48_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp48_stall_in = 1'b0;
assign rnode_179to180_bb1_cmp48_0_NO_SHIFT_REG = rnode_179to180_bb1_cmp48_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_cmp48_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp48_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1___u87_stall_local;
wire [31:0] local_bb1___u87;

assign local_bb1___u87 = (rnode_179to180_bb1_cmp48_0_NO_SHIFT_REG ? 32'hFFFFFF : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_valid_out;
wire local_bb1_c0_exi1_stall_in;
wire local_bb1_c0_exi1_inputs_ready;
wire local_bb1_c0_exi1_stall_local;
wire [63:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1_inputs_ready = rnode_179to180_bb1_cmp48_0_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exi1[31:0] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
assign local_bb1_c0_exi1[63:32] = local_bb1___u87;
assign local_bb1_c0_exi1_valid_out = 1'b1;
assign rnode_179to180_bb1_cmp48_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi1_inputs_ready;
 reg local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_stall_in;
 reg [63:0] local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG;
wire [63:0] local_bb1_c0_exit_c0_exi1_in;
wire local_bb1_c0_exit_c0_exi1_valid;
wire local_bb1_c0_exit_c0_exi1_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi1),
	.data_out(local_bb1_c0_exit_c0_exi1_in),
	.input_accepted(local_bb1_c0_enter_c0_eni5_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi1_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi1_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi1_entry_stall),
	.valids(local_bb1_c0_exit_c0_exi1_valid_bits),
	.IIphases(local_bb1_c0_exit_c0_exi1_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni5_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni5_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi1_instance.DATA_WIDTH = 64;
defparam local_bb1_c0_exit_c0_exi1_instance.PIPELINE_DEPTH = 15;
defparam local_bb1_c0_exit_c0_exi1_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi1_instance.SCHEDULEII = 1;

assign local_bb1_c0_exit_c0_exi1_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi1_output_regs_ready = (&(~(local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi1_stall_in)));
assign local_bb1_c0_exi1_stall_in = 1'b0;
assign rnode_179to180_bb1_rows_1_0_push6_rows_0_0_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_0_0_push7___0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_969_0_coalesced_push3_rows_1_0_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_970_0_push5_rows_969_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_rows_971_0_push4_rows_970_0_pop5_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__coalesced_push2_rows_971_0_pop4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push9__pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__push8__coalesced_pop2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb1_c0_exit_c0_exi1_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi1_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_in;
			local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi1_stall_in))
			begin
				local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
wire local_bb1_c0_exe1_inputs_ready;
wire local_bb1_c0_exe1_stall_local;
wire [31:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1_inputs_ready = local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG[63:32];
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe1_inputs_ready;
assign local_bb1_c0_exe1_stall_local = local_bb1_c0_exe1_stall_in;
assign local_bb1_c0_exit_c0_exi1_stall_in = (|local_bb1_c0_exe1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_st_c0_exe1_inputs_ready;
 reg local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
wire local_bb1_st_c0_exe1_stall_in;
wire local_bb1_st_c0_exe1_output_regs_ready;
wire local_bb1_st_c0_exe1_fu_stall_out;
wire local_bb1_st_c0_exe1_fu_valid_out;
wire local_bb1_st_c0_exe1_causedstall;

lsu_top lsu_local_bb1_st_c0_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_st_c0_exe1_fu_stall_out),
	.i_valid(local_bb1_st_c0_exe1_inputs_ready),
	.i_address(rnode_184to185_bb1_c1_exe6_0_NO_SHIFT_REG),
	.i_writedata(local_bb1_c0_exe1),
	.i_cmpdata(),
	.i_predicate(rnode_184to185_bb1_c1_exe5_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_st_c0_exe1_output_regs_ready)),
	.o_valid(local_bb1_st_c0_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_st_c0_exe1_active),
	.avm_address(avm_local_bb1_st_c0_exe1_address),
	.avm_read(avm_local_bb1_st_c0_exe1_read),
	.avm_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_write(avm_local_bb1_st_c0_exe1_write),
	.avm_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.avm_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_st_c0_exe1.AWIDTH = 30;
defparam lsu_local_bb1_st_c0_exe1.WIDTH_BYTES = 4;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb1_st_c0_exe1.READ = 0;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC = 0;
defparam lsu_local_bb1_st_c0_exe1.WIDTH = 32;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH = 256;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_st_c0_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_st_c0_exe1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb1_st_c0_exe1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb1_st_c0_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_st_c0_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_st_c0_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_st_c0_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb1_st_c0_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_st_c0_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb1_st_c0_exe1.USECACHING = 0;
defparam lsu_local_bb1_st_c0_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_st_c0_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_st_c0_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb1_st_c0_exe1.ADDRSPACE = 1;
defparam lsu_local_bb1_st_c0_exe1.STYLE = "BURST-COALESCED";
defparam lsu_local_bb1_st_c0_exe1.USE_BYTE_EN = 0;

assign local_bb1_st_c0_exe1_inputs_ready = (local_bb1_c0_exe1_valid_out & rnode_184to185_bb1_c1_exe5_0_valid_out_NO_SHIFT_REG & rnode_184to185_bb1_c1_exe6_0_valid_out_NO_SHIFT_REG);
assign local_bb1_st_c0_exe1_output_regs_ready = (&(~(local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb1_st_c0_exe1_stall_in)));
assign local_bb1_c0_exe1_stall_in = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign rnode_184to185_bb1_c1_exe5_0_stall_in_NO_SHIFT_REG = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign rnode_184to185_bb1_c1_exe6_0_stall_in_NO_SHIFT_REG = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign local_bb1_st_c0_exe1_causedstall = (local_bb1_st_c0_exe1_inputs_ready && (local_bb1_st_c0_exe1_fu_stall_out && !(~(local_bb1_st_c0_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_st_c0_exe1_output_regs_ready)
		begin
			local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= local_bb1_st_c0_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_st_c0_exe1_stall_in))
			begin
				local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_189to189_bb1_st_c0_exe1_valid_out;
wire rstag_189to189_bb1_st_c0_exe1_stall_in;
wire rstag_189to189_bb1_st_c0_exe1_inputs_ready;
wire rstag_189to189_bb1_st_c0_exe1_stall_local;
 reg rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_189to189_bb1_st_c0_exe1_combined_valid;

assign rstag_189to189_bb1_st_c0_exe1_inputs_ready = local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
assign rstag_189to189_bb1_st_c0_exe1_combined_valid = (rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG | rstag_189to189_bb1_st_c0_exe1_inputs_ready);
assign rstag_189to189_bb1_st_c0_exe1_valid_out = rstag_189to189_bb1_st_c0_exe1_combined_valid;
assign rstag_189to189_bb1_st_c0_exe1_stall_local = rstag_189to189_bb1_st_c0_exe1_stall_in;
assign local_bb1_st_c0_exe1_stall_in = (|rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_189to189_bb1_st_c0_exe1_stall_local)
		begin
			if (~(rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= rstag_189to189_bb1_st_c0_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_189to189_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;

assign branch_var__inputs_ready = (rnode_188to189_bb1_c1_exe7_0_valid_out_NO_SHIFT_REG & rstag_189to189_bb1_st_c0_exe1_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign rnode_188to189_bb1_c1_exe7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_189to189_bb1_st_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			branch_compare_result_NO_SHIFT_REG <= rnode_188to189_bb1_c1_exe7_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = ~(stall_in);
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_function
	(
		input 		clock,
		input 		resetn,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		input 		start,
		input [31:0] 		input_iterations,
		input 		clock2x,
		input [63:0] 		input_frame_in,
		input [63:0] 		input_frame_out,
		input [31:0] 		input_threshold,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] workgroup_size;
wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire bb_0_lvb_bb0_cmp12;
wire bb_1_stall_out_0;
wire bb_1_stall_out_1;
wire bb_1_valid_out_0;
wire bb_1_valid_out_1;
wire bb_1_feedback_stall_out_0;
wire bb_1_feedback_stall_out_1;
wire bb_1_acl_pipelined_valid;
wire bb_1_acl_pipelined_exiting_valid;
wire bb_1_acl_pipelined_exiting_stall;
wire bb_1_feedback_stall_out_11;
wire bb_1_feedback_stall_out_13;
wire bb_1_feedback_stall_out_10;
wire bb_1_feedback_stall_out_12;
wire bb_1_feedback_valid_out_11;
wire [3:0] bb_1_feedback_data_out_11;
wire bb_1_feedback_valid_out_0;
wire bb_1_feedback_data_out_0;
wire bb_1_feedback_valid_out_10;
wire [63:0] bb_1_feedback_data_out_10;
wire bb_1_feedback_valid_out_12;
wire [10:0] bb_1_feedback_data_out_12;
wire bb_1_feedback_valid_out_1;
wire bb_1_feedback_data_out_1;
wire bb_1_feedback_valid_out_13;
wire [3:0] bb_1_feedback_data_out_13;
wire bb_1_local_bb1_ld__active;
wire bb_1_feedback_stall_out_6;
wire bb_1_feedback_stall_out_7;
wire bb_1_feedback_stall_out_3;
wire bb_1_feedback_valid_out_3;
wire [31:0] bb_1_feedback_data_out_3;
wire bb_1_feedback_valid_out_6;
wire [31:0] bb_1_feedback_data_out_6;
wire bb_1_feedback_stall_out_2;
wire bb_1_feedback_valid_out_5;
wire [31:0] bb_1_feedback_data_out_5;
wire bb_1_feedback_valid_out_7;
wire [31:0] bb_1_feedback_data_out_7;
wire bb_1_feedback_stall_out_4;
wire bb_1_feedback_stall_out_5;
wire bb_1_feedback_valid_out_4;
wire [31:0] bb_1_feedback_data_out_4;
wire bb_1_feedback_stall_out_8;
wire bb_1_feedback_stall_out_9;
wire bb_1_feedback_valid_out_8;
wire [31:0] bb_1_feedback_data_out_8;
wire bb_1_feedback_valid_out_2;
wire [31:0] bb_1_feedback_data_out_2;
wire bb_1_feedback_valid_out_9;
wire [31:0] bb_1_feedback_data_out_9;
wire bb_1_local_bb1_st_c0_exe1_active;
wire bb_2_stall_out;
wire bb_2_valid_out;
wire feedback_stall_12;
wire feedback_valid_12;
wire [10:0] feedback_data_12;
wire feedback_stall_11;
wire feedback_valid_11;
wire [3:0] feedback_data_11;
wire feedback_stall_0;
wire feedback_valid_0;
wire feedback_data_0;
wire feedback_stall_10;
wire feedback_valid_10;
wire [63:0] feedback_data_10;
wire feedback_stall_1;
wire feedback_valid_1;
wire feedback_data_1;
wire feedback_stall_13;
wire feedback_valid_13;
wire [3:0] feedback_data_13;
wire feedback_stall_3;
wire feedback_valid_3;
wire [31:0] feedback_data_3;
wire feedback_stall_2;
wire feedback_valid_2;
wire [31:0] feedback_data_2;
wire feedback_stall_9;
wire feedback_valid_9;
wire [31:0] feedback_data_9;
wire feedback_stall_8;
wire feedback_valid_8;
wire [31:0] feedback_data_8;
wire feedback_stall_6;
wire feedback_valid_6;
wire [31:0] feedback_data_6;
wire feedback_stall_5;
wire feedback_valid_5;
wire [31:0] feedback_data_5;
wire feedback_stall_4;
wire feedback_valid_4;
wire [31:0] feedback_data_4;
wire feedback_stall_7;
wire feedback_valid_7;
wire [31:0] feedback_data_7;
wire loop_limiter_0_stall_out;
wire loop_limiter_0_valid_out;
wire writes_pending;
wire [1:0] lsus_active;

acl_loop_limiter loop_limiter_0 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_0_valid_out),
	.i_stall(bb_1_stall_out_1),
	.i_valid_exit(bb_1_acl_pipelined_exiting_valid),
	.i_stall_exit(bb_1_acl_pipelined_exiting_stall),
	.o_valid(loop_limiter_0_valid_out),
	.o_stall(loop_limiter_0_stall_out)
);

defparam loop_limiter_0.ENTRY_WIDTH = 1;
defparam loop_limiter_0.EXIT_WIDTH = 1;
defparam loop_limiter_0.THRESHOLD = 1;

sobel_basic_block_0 sobel_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_iterations(input_iterations),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.valid_out(bb_0_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_bb0_cmp12(bb_0_lvb_bb0_cmp12),
	.workgroup_size(workgroup_size)
);


sobel_basic_block_1 sobel_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_iterations(input_iterations),
	.input_frame_in(input_frame_in),
	.input_frame_out(input_frame_out),
	.input_threshold(input_threshold),
	.input_wii_cmp12(bb_0_lvb_bb0_cmp12),
	.valid_in_0(bb_1_acl_pipelined_valid),
	.stall_out_0(bb_1_stall_out_0),
	.input_forked_0(1'b0),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_1_stall_out_1),
	.input_forked_1(1'b1),
	.valid_out_0(bb_1_valid_out_0),
	.stall_in_0(bb_2_stall_out),
	.valid_out_1(bb_1_valid_out_1),
	.stall_in_1(1'b0),
	.workgroup_size(workgroup_size),
	.start(start),
	.feedback_valid_in_0(feedback_valid_0),
	.feedback_stall_out_0(feedback_stall_0),
	.feedback_data_in_0(feedback_data_0),
	.feedback_valid_in_1(feedback_valid_1),
	.feedback_stall_out_1(feedback_stall_1),
	.feedback_data_in_1(feedback_data_1),
	.acl_pipelined_valid(bb_1_acl_pipelined_valid),
	.acl_pipelined_stall(bb_1_stall_out_0),
	.acl_pipelined_exiting_valid(bb_1_acl_pipelined_exiting_valid),
	.acl_pipelined_exiting_stall(bb_1_acl_pipelined_exiting_stall),
	.feedback_valid_in_11(feedback_valid_11),
	.feedback_stall_out_11(feedback_stall_11),
	.feedback_data_in_11(feedback_data_11),
	.feedback_valid_in_13(feedback_valid_13),
	.feedback_stall_out_13(feedback_stall_13),
	.feedback_data_in_13(feedback_data_13),
	.feedback_valid_in_10(feedback_valid_10),
	.feedback_stall_out_10(feedback_stall_10),
	.feedback_data_in_10(feedback_data_10),
	.feedback_valid_in_12(feedback_valid_12),
	.feedback_stall_out_12(feedback_stall_12),
	.feedback_data_in_12(feedback_data_12),
	.feedback_valid_out_11(feedback_valid_11),
	.feedback_stall_in_11(feedback_stall_11),
	.feedback_data_out_11(feedback_data_11),
	.feedback_valid_out_0(feedback_valid_0),
	.feedback_stall_in_0(feedback_stall_0),
	.feedback_data_out_0(feedback_data_0),
	.feedback_valid_out_10(feedback_valid_10),
	.feedback_stall_in_10(feedback_stall_10),
	.feedback_data_out_10(feedback_data_10),
	.feedback_valid_out_12(feedback_valid_12),
	.feedback_stall_in_12(feedback_stall_12),
	.feedback_data_out_12(feedback_data_12),
	.feedback_valid_out_1(feedback_valid_1),
	.feedback_stall_in_1(feedback_stall_1),
	.feedback_data_out_1(feedback_data_1),
	.feedback_valid_out_13(feedback_valid_13),
	.feedback_stall_in_13(feedback_stall_13),
	.feedback_data_out_13(feedback_data_13),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__burstcount),
	.local_bb1_ld__active(bb_1_local_bb1_ld__active),
	.clock2x(clock2x),
	.feedback_valid_in_6(feedback_valid_6),
	.feedback_stall_out_6(feedback_stall_6),
	.feedback_data_in_6(feedback_data_6),
	.feedback_valid_in_7(feedback_valid_7),
	.feedback_stall_out_7(feedback_stall_7),
	.feedback_data_in_7(feedback_data_7),
	.feedback_valid_in_3(feedback_valid_3),
	.feedback_stall_out_3(feedback_stall_3),
	.feedback_data_in_3(feedback_data_3),
	.feedback_valid_out_3(feedback_valid_3),
	.feedback_stall_in_3(feedback_stall_3),
	.feedback_data_out_3(feedback_data_3),
	.feedback_valid_out_6(feedback_valid_6),
	.feedback_stall_in_6(feedback_stall_6),
	.feedback_data_out_6(feedback_data_6),
	.feedback_valid_in_2(feedback_valid_2),
	.feedback_stall_out_2(feedback_stall_2),
	.feedback_data_in_2(feedback_data_2),
	.feedback_valid_out_5(feedback_valid_5),
	.feedback_stall_in_5(feedback_stall_5),
	.feedback_data_out_5(feedback_data_5),
	.feedback_valid_out_7(feedback_valid_7),
	.feedback_stall_in_7(feedback_stall_7),
	.feedback_data_out_7(feedback_data_7),
	.feedback_valid_in_4(feedback_valid_4),
	.feedback_stall_out_4(feedback_stall_4),
	.feedback_data_in_4(feedback_data_4),
	.feedback_valid_in_5(feedback_valid_5),
	.feedback_stall_out_5(feedback_stall_5),
	.feedback_data_in_5(feedback_data_5),
	.feedback_valid_out_4(feedback_valid_4),
	.feedback_stall_in_4(feedback_stall_4),
	.feedback_data_out_4(feedback_data_4),
	.feedback_valid_in_8(feedback_valid_8),
	.feedback_stall_out_8(feedback_stall_8),
	.feedback_data_in_8(feedback_data_8),
	.feedback_valid_in_9(feedback_valid_9),
	.feedback_stall_out_9(feedback_stall_9),
	.feedback_data_in_9(feedback_data_9),
	.feedback_valid_out_8(feedback_valid_8),
	.feedback_stall_in_8(feedback_stall_8),
	.feedback_data_out_8(feedback_data_8),
	.feedback_valid_out_2(feedback_valid_2),
	.feedback_stall_in_2(feedback_stall_2),
	.feedback_data_out_2(feedback_data_2),
	.feedback_valid_out_9(feedback_valid_9),
	.feedback_stall_in_9(feedback_stall_9),
	.feedback_data_out_9(feedback_data_9),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.local_bb1_st_c0_exe1_active(bb_1_local_bb1_st_c0_exe1_active)
);


sobel_basic_block_2 sobel_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_1_valid_out_0),
	.stall_out(bb_2_stall_out),
	.valid_out(bb_2_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start)
);


sobel_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign workgroup_size = 32'h1;
assign valid_out = bb_2_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_1_local_bb1_st_c0_exe1_active;
assign lsus_active[0] = bb_1_local_bb1_ld__active;
assign lsus_active[1] = bb_1_local_bb1_st_c0_exe1_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb1_ld__inst0_readdata,
		input 		avm_local_bb1_ld__inst0_readdatavalid,
		input 		avm_local_bb1_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld__inst0_address,
		output 		avm_local_bb1_ld__inst0_read,
		output 		avm_local_bb1_ld__inst0_write,
		input 		avm_local_bb1_ld__inst0_writeack,
		output [255:0] 		avm_local_bb1_ld__inst0_writedata,
		output [31:0] 		avm_local_bb1_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb1_st_c0_exe1_inst0_readdata,
		input 		avm_local_bb1_st_c0_exe1_inst0_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_inst0_address,
		output 		avm_local_bb1_st_c0_exe1_inst0_read,
		output 		avm_local_bb1_st_c0_exe1_inst0_write,
		input 		avm_local_bb1_st_c0_exe1_inst0_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_inst0_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [191:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
 reg [63:0] cra_readdata_st1_NO_SHIFT_REG;
 reg [3:0] cra_addr_st1_NO_SHIFT_REG;
 reg cra_read_st1_NO_SHIFT_REG;
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 192'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[191:160] <= ((kernel_arguments_NO_SHIFT_REG[191:160] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= 1'b0;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cra_read_st1_NO_SHIFT_REG <= 1'b0;
		cra_addr_st1_NO_SHIFT_REG <= 4'h0;
		cra_readdata_st1_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		cra_read_st1_NO_SHIFT_REG <= avs_cra_read;
		cra_addr_st1_NO_SHIFT_REG <= avs_cra_address;
		case (avs_cra_address)
			4'h0:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= status_NO_SHIFT_REG;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h1:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= 'x;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h2:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h3:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h4:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			default:
			begin
				cra_readdata_st1_NO_SHIFT_REG <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		avs_cra_readdatavalid <= cra_read_st1_NO_SHIFT_REG;
		case (cra_addr_st1_NO_SHIFT_REG)
			4'h2:
			begin
				avs_cra_readdata[63:0] <= profile_data_NO_SHIFT_REG;
			end

			default:
			begin
				avs_cra_readdata <= cra_readdata_st1_NO_SHIFT_REG;
			end

		endcase
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.TESSELLATION_SIZE = 0;
defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
sobel_function sobel_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__inst0_readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__inst0_readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__inst0_waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__inst0_address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__inst0_read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__inst0_write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__inst0_writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__inst0_writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__inst0_byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__inst0_burstcount),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_inst0_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_inst0_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_inst0_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_inst0_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_inst0_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_inst0_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_inst0_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_inst0_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_inst0_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_inst0_burstcount),
	.start(start_out),
	.input_iterations(kernel_arguments_NO_SHIFT_REG[159:128]),
	.clock2x(clock2x),
	.input_frame_in(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_frame_out(kernel_arguments_NO_SHIFT_REG[127:64]),
	.input_threshold(kernel_arguments_NO_SHIFT_REG[191:160]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module sobel_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

