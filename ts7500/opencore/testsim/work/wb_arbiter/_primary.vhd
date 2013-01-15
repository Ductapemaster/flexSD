library verilog;
use verilog.vl_types.all;
entity wb_arbiter is
    port(
        wb_clk_i        : in     vl_logic;
        wb1_adr_i       : in     vl_logic_vector(31 downto 0);
        wb1_dat_i       : in     vl_logic_vector(31 downto 0);
        wb1_dat_o       : out    vl_logic_vector(31 downto 0);
        wb1_cyc_i       : in     vl_logic;
        wb1_stb_i       : in     vl_logic;
        wb1_cti_i       : in     vl_logic_vector(2 downto 0);
        wb1_bte_i       : in     vl_logic_vector(1 downto 0);
        wb1_we_i        : in     vl_logic;
        wb1_sel_i       : in     vl_logic_vector(3 downto 0);
        wb1_ack_o       : out    vl_logic;
        wb2_adr_i       : in     vl_logic_vector(31 downto 0);
        wb2_dat_i       : in     vl_logic_vector(31 downto 0);
        wb2_dat_o       : out    vl_logic_vector(31 downto 0);
        wb2_cyc_i       : in     vl_logic;
        wb2_stb_i       : in     vl_logic;
        wb2_cti_i       : in     vl_logic_vector(2 downto 0);
        wb2_bte_i       : in     vl_logic_vector(1 downto 0);
        wb2_we_i        : in     vl_logic;
        wb2_sel_i       : in     vl_logic_vector(3 downto 0);
        wb2_ack_o       : out    vl_logic;
        wb3_adr_i       : in     vl_logic_vector(31 downto 0);
        wb3_dat_i       : in     vl_logic_vector(31 downto 0);
        wb3_dat_o       : out    vl_logic_vector(31 downto 0);
        wb3_cyc_i       : in     vl_logic;
        wb3_stb_i       : in     vl_logic;
        wb3_cti_i       : in     vl_logic_vector(2 downto 0);
        wb3_bte_i       : in     vl_logic_vector(1 downto 0);
        wb3_we_i        : in     vl_logic;
        wb3_sel_i       : in     vl_logic_vector(3 downto 0);
        wb3_ack_o       : out    vl_logic;
        wb4_adr_i       : in     vl_logic_vector(31 downto 0);
        wb4_dat_i       : in     vl_logic_vector(31 downto 0);
        wb4_dat_o       : out    vl_logic_vector(31 downto 0);
        wb4_cyc_i       : in     vl_logic;
        wb4_stb_i       : in     vl_logic;
        wb4_cti_i       : in     vl_logic_vector(2 downto 0);
        wb4_bte_i       : in     vl_logic_vector(1 downto 0);
        wb4_we_i        : in     vl_logic;
        wb4_sel_i       : in     vl_logic_vector(3 downto 0);
        wb4_ack_o       : out    vl_logic;
        wbowner_adr_o   : out    vl_logic_vector(31 downto 0);
        wbowner_dat_i   : in     vl_logic_vector(31 downto 0);
        wbowner_dat_o   : out    vl_logic_vector(31 downto 0);
        wbowner_cyc_o   : out    vl_logic;
        wbowner_stb_o   : out    vl_logic;
        wbowner_cti_o   : out    vl_logic_vector(2 downto 0);
        wbowner_bte_o   : out    vl_logic_vector(1 downto 0);
        wbowner_we_o    : out    vl_logic;
        wbowner_sel_o   : out    vl_logic_vector(3 downto 0);
        wbowner_ack_i   : in     vl_logic;
        wbowner_o       : out    vl_logic_vector(1 downto 0)
    );
end wb_arbiter;
