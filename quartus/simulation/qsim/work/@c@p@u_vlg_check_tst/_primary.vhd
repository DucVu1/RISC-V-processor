library verilog;
use verilog.vl_types.all;
entity CPU_vlg_check_tst is
    port(
        ALUSrc          : in     vl_logic;
        ALU_result2     : in     vl_logic_vector(31 downto 0);
        Aluop           : in     vl_logic_vector(1 downto 0);
        Branch          : in     vl_logic;
        ForwardA_signal : in     vl_logic_vector(1 downto 0);
        ForwardB_signal : in     vl_logic_vector(1 downto 0);
        Instruction_in  : in     vl_logic_vector(31 downto 0);
        Instruction_out : in     vl_logic_vector(31 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        MemtoReg        : in     vl_logic;
        Muxselect       : in     vl_logic;
        PC_out          : in     vl_logic_vector(31 downto 0);
        ReadData0       : in     vl_logic_vector(31 downto 0);
        ReadData1       : in     vl_logic_vector(31 downto 0);
        RegWrite        : in     vl_logic;
        Register_dest   : in     vl_logic_vector(4 downto 0);
        Stall           : in     vl_logic;
        flush           : in     vl_logic;
        r8              : in     vl_logic_vector(31 downto 0);
        r11             : in     vl_logic_vector(31 downto 0);
        rs0             : in     vl_logic_vector(4 downto 0);
        rs1             : in     vl_logic_vector(4 downto 0);
        sampler_rx      : in     vl_logic
    );
end CPU_vlg_check_tst;
