# Clocks
add wave /add_sub_top/rtl/clk
add wave /add_sub_top/rtl/rst

# add
add wave -group add /add_sub_top/rtl/a \
                    /add_sub_top/rtl/b \
                    /add_sub_top/rtl/add 

# sub
add wave -group sub /add_sub_top/rtl/x \
                    /add_sub_top/rtl/y \
                    /add_sub_top/rtl/sub