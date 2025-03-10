`default_nettype none

module sha1(
            // Clock and reset.
            input wire           clk,
            input wire           reset_n,

            // Control.
            input wire           cs,
            input wire           we,

            // Data ports.
            input wire  [7 : 0]  address,
            input wire  [31 : 0] write_data,
            output wire [31 : 0] read_data,
            output wire          error
           );

  //----------------------------------------------------------------
  localparam ADDR_NAME0       = 8'h00;
  localparam ADDR_NAME1       = 8'h01;
  localparam ADDR_VERSION     = 8'h02;

  localparam ADDR_CTRL        = 8'h08;
  localparam CTRL_INIT_BIT    = 0;
  localparam CTRL_NEXT_BIT    = 1;

  localparam ADDR_STATUS      = 8'h09;
  localparam STATUS_READY_BIT = 0;
  localparam STATUS_VALID_BIT = 1;

  localparam ADDR_BLOCK0    = 8'h10;
  localparam ADDR_BLOCK15   = 8'h1f;

  localparam ADDR_DIGEST0   = 8'h20;
  localparam ADDR_DIGEST4   = 8'h24;
  
  //----------------------------------------------------------------
  reg init_reg;
  reg init_new;

  reg next_reg;
  reg next_new;

  reg ready_reg;

  reg [31 : 0] block_reg [0 : 15];
  reg          block_we;

  reg [159 : 0] digest_reg;

  reg digest_valid_reg;


  //----------------------------------------------------------------
  wire           core_ready;
  wire [511 : 0] core_block;
  wire [159 : 0] core_digest;
  wire           core_digest_valid;

  reg [31 : 0]   tmp_read_data;
  reg            tmp_error;


  //----------------------------------------------------------------
  assign core_block = {block_reg[00], block_reg[01], block_reg[02], block_reg[03],
                       block_reg[04], block_reg[05], block_reg[06], block_reg[07],
                       block_reg[08], block_reg[09], block_reg[10], block_reg[11],
                       block_reg[12], block_reg[13], block_reg[14], block_reg[15]};

  assign read_data = tmp_read_data;
  assign error     = tmp_error;


  //----------------------------------------------------------------
  sha1_core core(
                 .clk(clk),
                 .reset_n(reset_n),

                 .init(init_reg),
                 .next(next_reg),

                 .block(core_block),

                 .ready(core_ready),

                 .digest(core_digest),
                 .digest_valid(core_digest_valid)
                );


  //----------------------------------------------------------------
  always @ (posedge clk or negedge reset_n)
    begin : reg_update
      integer i;

      if (!reset_n)
        begin
          init_reg         <= 1'h0;
          next_reg         <= 1'h0;
          ready_reg        <= 1'h0;
          digest_reg       <= 160'h0;
          digest_valid_reg <= 1'h0;

          for (i = 0 ; i < 16 ; i = i + 1)
            block_reg[i] <= 32'h0;
        end
      else
        begin
          ready_reg        <= core_ready;
          digest_valid_reg <= core_digest_valid;
          init_reg         <= init_new;
          next_reg         <= next_new;

          if (block_we)
            block_reg[address[3 : 0]] <= write_data;

          if (core_digest_valid)
            digest_reg <= core_digest;
        end
    end // reg_update

  //----------------------------------------------------------------
  always @*
    begin 
      init_new      = 1'h0;
      next_new      = 1'h0;
      block_we      = 1'h0;
      tmp_read_data = 32'h0;
      tmp_error     = 1'h0;

      if (cs)
        begin
          if (we)
            begin
              if ((address >= ADDR_BLOCK0) && (address <= ADDR_BLOCK15))
                block_we = 1'h1;

              if (address == ADDR_CTRL)
                begin
                  init_new = write_data[CTRL_INIT_BIT];
                  next_new = write_data[CTRL_NEXT_BIT];
                end
            end // if (write_read)
          else
            begin
              if ((address >= ADDR_BLOCK0) && (address <= ADDR_BLOCK15))
                tmp_read_data = block_reg[address[3 : 0]];

              if ((address >= ADDR_DIGEST0) && (address <= ADDR_DIGEST4))
                tmp_read_data = digest_reg[(4 - (address - ADDR_DIGEST0)) * 32 +: 32];

              case (address)
                ADDR_CTRL:
                  tmp_read_data = {30'h0, next_reg, init_reg};

                ADDR_STATUS:
                  tmp_read_data = {30'h0, digest_valid_reg, ready_reg};

                default:
                  begin
                    tmp_error = 1'h1;
                  end
              endcase // case (addr)
            end
        end
    end // addr_decoder
endmodule // sha1

