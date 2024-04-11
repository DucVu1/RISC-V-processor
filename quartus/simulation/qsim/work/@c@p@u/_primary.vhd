library verilog;
use verilog.vl_types.all;
entity CPU is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rs0             : out    vl_logic_vector(4 downto 0);
        rs1             : out    vl_logic_vector(4 downto 0);
        Register_dest   : out    vl_logic_vector(4 downto 0);
        ALUSrc          : out    vl_logic;
        MemtoReg        : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        Aluop           : out    vl_logic_vector(1 downto 0);
        ForwardA_signal : out    vl_logic_vector(1 downto 0);
        ForwardB_signal : out    vl_logic_vector(1 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        Instruction_in  : out    vl_logic_vector(31 downto 0);
        Instruction_out : out    vl_logic_vector(31 downto 0);
        r8              : out    vl_logic_vector(31 downto 0);
        r11             : out    vl_logic_vector(31 downto 0);
        ReadData0       : out    vl_logic_vector(31 downto 0);
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ALU_result2     : out    vl_logic_vector(31 downto 0);
        flush           : out    vl_logic;
        Stall           : out    vl_logic;
        Muxselect       : out    vl_logic;
        Branch          : out    vl_logic
    );
end CPU;
