# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Sun Dec 18 02:30:37 2022
# Designs open: 1
#   Sim: /DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES/simv
# Toplevel windows open: 1
# 	TopLevel.1
#   Source.1: tb
#   Group count = 8
#   Group inst[0].fifo signal count = 15
#   Group inst[0].portout signal count = 18
#   Group inst[0].mux8x1 signal count = 14
#   Group inst[0].port signal count = 12
#   Group inst[1].fifo signal count = 13
#   Group inst[1].mux8x1 signal count = 14
#   Group inst[1].port signal count = 12
#   Group inst[1].portout signal count = 18
# End_DVE_Session_Save_Info

# DVE version: P-2019.06-SP2-1_Full64
# DVE build date: Jan 30 2020 21:14:28


#<Session mode="Full" path="/DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{582 76} {1918 1050}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_set_toolbar_attributes -toolbar {Simulator} -dock_state top
gui_set_toolbar_attributes -toolbar {Simulator} -offset 0
gui_show_toolbar -toolbar {Simulator}
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -dock_state top
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -offset 0
gui_show_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 197]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
catch { set Stack.1 [gui_share_window -id ${HSPane.1} -type Stack -silent] }
catch { set Class.1 [gui_share_window -id ${HSPane.1} -type Class -silent] }
catch { set Object.1 [gui_share_window -id ${HSPane.1} -type Object -silent] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 197
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 196} {height 682} {dock_state left} {dock_on_new_line true} {child_hier_colhier 140} {child_hier_coltype 100} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 246]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
catch { set Local.1 [gui_share_window -id ${DLPane.1} -type Local -silent] }
catch { set Member.1 [gui_share_window -id ${DLPane.1} -type Member -silent] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 246
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 682
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 245} {height 682} {dock_state left} {dock_on_new_line true} {child_data_colvariable 189} {child_data_colvalue 100} {child_data_coltype 40} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 175]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 1337
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 175
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1336} {height 174} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { [llength [lindex [gui_get_db -design Sim] 0]] == 0 } {
gui_set_env SIMSETUP::SIMARGS {{-ucligui +1PORT}}
gui_set_env SIMSETUP::SIMEXE {/DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES/simv}
gui_set_env SIMSETUP::ALLOW_POLL {0}
if { ![gui_is_db_opened -db {/DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES/simv}] } {
gui_sim_run Ucli -exe simv -args {-ucligui +1PORT} -dir /DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES -nosource
}
}
if { ![gui_sim_state -check active] } {error "Simulator did not start correctly" error}
gui_set_precision 1ps
gui_set_time_units 1ps
#</Database>

# DVE Global setting session: 


# Global: Breakpoints

# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {tb.dut.inst[1].mux8x1}
gui_load_child_values {tb.dut.inst[0].portout}
gui_load_child_values {tb.dut.inst[1].port}
gui_load_child_values {tb.dut.inst[1].portout}
gui_load_child_values {tb.dut.inst[0].mux8x1}
gui_load_child_values {tb.dut.inst[0].port}


set _session_group_9 {inst[0].fifo}
gui_sg_create "$_session_group_9"
set {inst[0].fifo} "$_session_group_9"

gui_sg_addsignal -group "$_session_group_9" { {tb.dut.inst[0].fifo.head} {tb.dut.inst[0].fifo.data_out} {tb.dut.inst[0].fifo.i} {tb.dut.inst[0].fifo.clk_pop} {tb.dut.inst[0].fifo.data_in} {tb.dut.inst[0].fifo.clk_push} {tb.dut.inst[0].fifo.reset_n} {tb.dut.inst[0].fifo.tail} {tb.dut.inst[0].fifo.push_req_n} {tb.dut.inst[0].fifo.clear} {tb.dut.inst[0].fifo.stack[1]} {tb.dut.inst[0].fifo.stack[0]} {tb.dut.inst[0].fifo.stack} {tb.dut.inst[0].fifo.pop_req_n} {tb.dut.inst[0].fifo.$unit} }

set _session_group_10 {inst[0].portout}
gui_sg_create "$_session_group_10"
set {inst[0].portout} "$_session_group_10"

gui_sg_addsignal -group "$_session_group_10" { {tb.dut.inst[0].portout.clock} {tb.dut.inst[0].portout.vld} {tb.dut.inst[0].portout.reset_n} {tb.dut.inst[0].portout.din} {tb.dut.inst[0].portout.payload} {tb.dut.inst[0].portout.dout} {tb.dut.inst[0].portout.frameo_n} {tb.dut.inst[0].portout.valido_n} {tb.dut.inst[0].portout.pop} {tb.dut.inst[0].portout.cntp} {tb.dut.inst[0].portout.cnta} {tb.dut.inst[0].portout.current_state} {tb.dut.inst[0].portout.Wait} {tb.dut.inst[0].portout.validState} {tb.dut.inst[0].portout.payloadState} {tb.dut.inst[0].portout.addr} {tb.dut.inst[0].portout.writeout} {tb.dut.inst[0].portout.$unit} }
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].portout.Wait}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].portout.Wait}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].portout.validState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].portout.validState}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].portout.payloadState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].portout.payloadState}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].portout.addr}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].portout.addr}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].portout.writeout}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].portout.writeout}}

set _session_group_11 {inst[0].mux8x1}
gui_sg_create "$_session_group_11"
set {inst[0].mux8x1} "$_session_group_11"

gui_sg_addsignal -group "$_session_group_11" { {tb.dut.inst[0].mux8x1.vld_from_input} {tb.dut.inst[0].mux8x1.clock} {tb.dut.inst[0].mux8x1.reset_n} {tb.dut.inst[0].mux8x1.clr} {tb.dut.inst[0].mux8x1.x} {tb.dut.inst[0].mux8x1.valid_from_mux} {tb.dut.inst[0].mux8x1.datout} {tb.dut.inst[0].mux8x1.addr_from_input} {tb.dut.inst[0].mux8x1.datain} {tb.dut.inst[0].mux8x1.i} {tb.dut.inst[0].mux8x1.current_state} {tb.dut.inst[0].mux8x1.readenable} {tb.dut.inst[0].mux8x1.validState} {tb.dut.inst[0].mux8x1.$unit} }
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].mux8x1.readenable}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].mux8x1.readenable}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[0].mux8x1.validState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[0].mux8x1.validState}}

set _session_group_12 {inst[0].port}
gui_sg_create "$_session_group_12"
set {inst[0].port} "$_session_group_12"

gui_sg_addsignal -group "$_session_group_12" { {tb.dut.inst[0].port.clock} {tb.dut.inst[0].port.reset_n} {tb.dut.inst[0].port.frame_n} {tb.dut.inst[0].port.valid_n} {tb.dut.inst[0].port.di} {tb.dut.inst[0].port.clr} {tb.dut.inst[0].port.payload} {tb.dut.inst[0].port.addr} {tb.dut.inst[0].port.vld} {tb.dut.inst[0].port.cnta} {tb.dut.inst[0].port.cntp} {tb.dut.inst[0].port.$unit} }

set _session_group_13 {inst[1].fifo}
gui_sg_create "$_session_group_13"
set {inst[1].fifo} "$_session_group_13"

gui_sg_addsignal -group "$_session_group_13" { {tb.dut.inst[1].fifo.clk_push} {tb.dut.inst[1].fifo.clk_pop} {tb.dut.inst[1].fifo.reset_n} {tb.dut.inst[1].fifo.push_req_n} {tb.dut.inst[1].fifo.pop_req_n} {tb.dut.inst[1].fifo.data_in} {tb.dut.inst[1].fifo.clear} {tb.dut.inst[1].fifo.data_out} {tb.dut.inst[1].fifo.head} {tb.dut.inst[1].fifo.tail} {tb.dut.inst[1].fifo.i} {tb.dut.inst[1].fifo.stack} {tb.dut.inst[1].fifo.$unit} }

set _session_group_14 {inst[1].mux8x1}
gui_sg_create "$_session_group_14"
set {inst[1].mux8x1} "$_session_group_14"

gui_sg_addsignal -group "$_session_group_14" { {tb.dut.inst[1].mux8x1.vld_from_input} {tb.dut.inst[1].mux8x1.clock} {tb.dut.inst[1].mux8x1.reset_n} {tb.dut.inst[1].mux8x1.clr} {tb.dut.inst[1].mux8x1.x} {tb.dut.inst[1].mux8x1.valid_from_mux} {tb.dut.inst[1].mux8x1.datout} {tb.dut.inst[1].mux8x1.addr_from_input} {tb.dut.inst[1].mux8x1.datain} {tb.dut.inst[1].mux8x1.i} {tb.dut.inst[1].mux8x1.current_state} {tb.dut.inst[1].mux8x1.readenable} {tb.dut.inst[1].mux8x1.validState} {tb.dut.inst[1].mux8x1.$unit} }
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].mux8x1.readenable}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].mux8x1.readenable}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].mux8x1.validState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].mux8x1.validState}}

set _session_group_15 {inst[1].port}
gui_sg_create "$_session_group_15"
set {inst[1].port} "$_session_group_15"

gui_sg_addsignal -group "$_session_group_15" { {tb.dut.inst[1].port.clock} {tb.dut.inst[1].port.reset_n} {tb.dut.inst[1].port.frame_n} {tb.dut.inst[1].port.valid_n} {tb.dut.inst[1].port.di} {tb.dut.inst[1].port.clr} {tb.dut.inst[1].port.payload} {tb.dut.inst[1].port.addr} {tb.dut.inst[1].port.vld} {tb.dut.inst[1].port.cnta} {tb.dut.inst[1].port.cntp} {tb.dut.inst[1].port.$unit} }

set _session_group_16 {inst[1].portout}
gui_sg_create "$_session_group_16"
set {inst[1].portout} "$_session_group_16"

gui_sg_addsignal -group "$_session_group_16" { {tb.dut.inst[1].portout.Wait} {tb.dut.inst[1].portout.vld} {tb.dut.inst[1].portout.dout} {tb.dut.inst[1].portout.din} {tb.dut.inst[1].portout.clock} {tb.dut.inst[1].portout.cntp} {tb.dut.inst[1].portout.pop} {tb.dut.inst[1].portout.frameo_n} {tb.dut.inst[1].portout.payloadState} {tb.dut.inst[1].portout.addr} {tb.dut.inst[1].portout.reset_n} {tb.dut.inst[1].portout.valido_n} {tb.dut.inst[1].portout.validState} {tb.dut.inst[1].portout.payload} {tb.dut.inst[1].portout.$unit} {tb.dut.inst[1].portout.current_state} {tb.dut.inst[1].portout.writeout} {tb.dut.inst[1].portout.cnta} }
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].portout.Wait}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].portout.Wait}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].portout.payloadState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].portout.payloadState}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].portout.addr}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].portout.addr}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].portout.validState}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].portout.validState}}
gui_set_radix -radix {decimal} -signals {{Sim:tb.dut.inst[1].portout.writeout}}
gui_set_radix -radix {twosComplement} -signals {{Sim:tb.dut.inst[1].portout.writeout}}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 239933000



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design Sim
catch {gui_list_expand -id ${Hier.1} tb}
catch {gui_list_expand -id ${Hier.1} tb.dut}
catch {gui_list_select -id ${Hier.1} {{tb.dut.inst[0].fifo}}}
gui_view_scroll -id ${Hier.1} -vertical -set 44
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Class 'Class.1'
gui_list_set_filter -id ${Class.1} -list { {OVM 1} {VMM 1} {All 1} {Object 1} {UVM 1} {RVM 1} }
gui_list_set_filter -id ${Class.1} -text {*}
gui_change_design -id ${Class.1} -design Sim

# Member 'Member.1'
gui_list_set_filter -id ${Member.1} -list { {InternalMember 0} {RandMember 1} {All 0} {BaseMember 0} {PrivateMember 1} {LibBaseMember 0} {AutomaticMember 1} {VirtualMember 1} {PublicMember 1} {ProtectedMember 1} {OverRiddenMember 0} {InterfaceClassMember 1} {StaticMember 1} }
gui_list_set_filter -id ${Member.1} -text {*}

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {tb.dut.inst[1].portout}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 44
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active tb /DCNFS/users/student/lkim/Desktop/Fall2022/603/FILES/testbenchSMOKE.sv
gui_view_scroll -id ${Source.1} -vertical -set 85
gui_src_set_reusable -id ${Source.1}
# Warning: Class view not found.
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${HSPane.1}
}
#</Session>

