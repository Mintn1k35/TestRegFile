library verilog;
use verilog.vl_types.all;
entity tb is
    generic(
        CLOCK           : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK : constant is 1;
end tb;
